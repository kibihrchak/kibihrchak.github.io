---
title:      "A Take on GCC Linux Cross-Compilation Compatibility"
tags:       cross-compilation gcc linux libc
---

`arm-linux-gnueabihf`, almost usable for all ARM platforms.

## Table of Contents

1.  TOC
{:toc}

## Version History

|Version    |Date       |Description
|---        |---        |---
|0.1        |2020-05-27 |Initial bare-bones post

## Overview

This topic started as a search for a more modern GCC version for
cross-compiling the programs for Raspbian, and then turned into an
all-out compatibility research on what it takes to cross-compile
software, and be sure it's going to run without issues on the target
platform. The original topic got [its own dedicated guide][raspbian-cc],
and the rest of stuff collected on cross-compilation compatibility got
slated for a dedicated analysis post, that is, this one.

This is a look on what consists a cross-compiler toolkit for a Linux
target, what are its specifics, and as the subtitle says, why is a
cross-compiler tied to a particular target even if the toolkit name
prefix sounds generic enough so that it can cover a multitude of
platforms. And at last, why that sometimes may be the case.

As a process to answer that question, here's the outline of covered
topics -

*   First there's a refresher on cross-compilation
*   There's a look on what are the relevant parameters for
    cross-compilation
*   A look at what makes a shared libraries compatible
*   What is the GCC cross-compiler build process
*   What are the assumed pitfalls of cross-compilation toolkit use

## Cross-Compilation 101

Cross compilation in a nutshell is a process of building code on one
machine that is to be executed on another (potentially incompatible)
machine.

As this process considers using different machines (execution platforms,
that is), here's a recap of these -

|Machine    |Purpose                        |Built artifact
|---        |---                            |---
|Build      |Builds the compiler            |Cross-compiler toolkit
|Host       |Runs the compiler              |Cross-compiled user program
|Target     |Executes the compiled code     |-

And here's a recap of different build types and the corresponding
machines -

|Build name/Machine |Build  |Host   |Target |Example
|---                |---    |---    |---    |---
|Native             |A      |A      |A      |Local compilation
|Cross              |A      |A      |B      |For MCU target
|Cross-native       |A      |B      |B      |-
|Canadian cross     |A      |B      |C      |-

## Cross-Compilation Parameters and Compatibility

Here's a summary of parameters relevant for creating a cross-compiler
toolkit. All parameters are related to a target machine.

|Parameter                  |Example        |Compatibility note
|---                        |---            |---
|CPU architecture           |ARM            |Incompatible
|CPU architecture variant   |ARMv6          |Backward(1)
|ABI                        |EABI           |Variants inside ABI(2)
|Object file format         |ELF            |Depends on format, linker
|OS API                     |Linux API      |Incompatible
|OS API version             |Linux API 3.2.0|Backward for Linux
|Standard C library         |glibc, uclibc  |Incompatible
|Standard C library version |glibc 2.28     |Backward for glibc
|Compiler runtime library   |libgcc         |Incompatible
|Compiler RT library version|libgcc 7.0.0   |Backward for libgcc

Notes:

1.  Eg. for ARM AArch32, or x86 sans extensions.
2.  Eg. EABI hard-float and soft-float variants are compatible between
    themselves.

### Parameter Violation Effects

Now, with knowledge what parameters are all involved when making a
cross-compiler, let's see what are the potential effects of setting an
incorrect parameter value  

|Parameter violation        |Effect
|---                        |---
|CPU architecture           |Code execution will crash
|CPU architecture variant   |Crash on unsupported execution
|ABI                        |Crash on linked library call
|ABI                        |Crash on an OS system call
|Object file format         |Linker/loader won't accept the file
|OS API                     |Any system call will fail
|OS API version             |Unsupported system calls will fail
|Standard C library         |Linking will fail
|Standard C library version |Linking will fail
|Compiler runtime library   |Linking will fail
|Compiler RT library version|Linking will fail

## Linux Shared Libraries

Shared libraries in Linux go under three names -

|Name           |Naming example             |Note
|---            |---                        |---
|soname         |`libstdc++.so.6`(1)        |Symlink to real name
|Real name      |`libstdc++.so.6.0.28`      |-
|Linker name    |`libstdc++.so`             |Symlink to latest soname

Notes:

1.  Standard C libraries don't start with `lib`.

As for the shared library and their symbols versioning, here are the
notes -

1.  Linker uses library represented with latest library (one represented
    by linker name).
2.  Version number specifies interface, and it's possible to have
    multiple sonames for different major library versions.
3.  API inside library is also versioned, with newer libraries adding
    API revisions, while keeping the old API. Example from
    `libc-2.31.so` -
    ```
    414: 00149b80  7039 FUNC    GLOBAL DEFAULT   16 glob64@GLIBC_2.2
    415: 0014b900  7039 FUNC    GLOBAL DEFAULT   16 glob64@GLIBC_2.1
    416: 000d1620  7039 FUNC    GLOBAL DEFAULT   16 glob64@@GLIBC_2.27
    ```

## GCC

### Cross-Compilation Toolkit Components

Here's an overview of components, and how and where they're gonna be
used -

|Component              |Use                            |Use location
|---                    |---                            |---
|Binaries               |Perform compilation, linking   |Host
|C static libraries     |Link with compiled program     |Host
|C dynamic libraries    |Link with compiled program     |Target
|C libraries headers    |Program compilation            |Host
|Dynamic linker/loader  |Load and link with dynamic libs|Target
|GCC static libraries   |Link with compiled program     |Host
|GCC dynamic libraries  |Link with compiled program     |Target
|CRT object files       |Program compilation            |Host
|GCC headers            |Program compilation            |Host
|Linker scripts         |Produce object file            |Host
|Documentation          |Get to perform tasks           |Host

### GCC Toolkit Build Process

Build by steps -

|Tool               |Note
|---                |---
|Binutils           |Linker and assembler most importantly
|GCC dependency libs|Needed for build-time calculations
|1st stage GCC      |Static C only, no libc
|Libc               |Build both dynamic linker/loader, and C library
|2nd stage GCC      |Libgcc built here; Need to know libc type/ver(1)

Notes:

1.  Changing Libc requires GCC rebuild!

Most notably, used architecture, ABI is used for building libc and
libgcc. This means that:

1.  Whatever architecture configuration modifications are performed
    during application build, originally built libc and libgcc are still
    going to be used.
2.  Any change needed necessitates rebuild for both libc and libgcc.

### Cross-Compilation Toolkit Install Directory Contents

1.  GCC requires binutils names without prefix
2.  GCC cross-compiler naming prefix - Autoconf system canonical name -
    `<arch>-<vendor>-<os>-<libc/abi>`.
3.  Standard C++ library considered as a build-up to C library
4.  GCC library headers
5.  Linker scripts

## Potential Use Cases

1.  Build GCC using prebuilt Glibc - Won't work
2.  Build newer GCC than the one used on target - Works, although libgcc
    compatibility not guaranteed.
3.  Build with newer Glibc than the one used on target - Works,
    execution risky.
4.  Using toolchain built for different machine - Works, execution not
    guaranteed.

## Resources

*   [bootlin_cctc_slides] : "Anatomy of Cross-Compilation Toolchains"
    presentation slides.
*   [bootlin_cctc_rec] : "Anatomy of Cross-Compilation Toolchains"
    presentation recording.
*   [gcc_mach-dep-opt] : GCC machine-dependent options - Machine
    architecture, ABI, etc.
*   [gcc_build-config] : GCC build - Configuration options.
*   [bootlin_emblin_slides] : General information on cross-compilers.
*   [tldp_so] : Naming, version info on shared libraries.
*   [redhat_lib-if-vers] : How library does interface versioning.
*   [autoconf_gcc-prefix] : Cross-compiler GCC prefix format.
*   [gcc_releases] : GCC release history.

[bootlin_cctc_slides]: <https://bootlin.com/pub/conferences/2016/elce/petazzoni-toolchain-anatomy/petazzoni-toolchain-anatomy.pdf>
[bootlin_cctc_rec]: <https://youtu.be/Pbt330zuNPc>
[gcc_mach-dep-opt]: <https://gcc.gnu.org/onlinedocs/gcc/Submodel-Options.html>
[gcc_build-config]: <https://gcc.gnu.org/install/configure.html>
[bootlin_emblin_slides]: <https://bootlin.com/doc/training/embedded-linux/embedded-linux-slides.pdf>
[tldp_so]: <http://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html>
[redhat_lib-if-vers]: <https://developers.redhat.com/blog/2019/08/01/how-the-gnu-c-library-handles-backward-compatibility/>
[autoconf_gcc-prefix]: <https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/System-Type.html#System-Type>
[gcc_releases]: <https://gcc.gnu.org/releases.html>

[raspbian-cc]: <{{ site.baseurl }}{% post_url guides/2020-05-23-raspbian-cross-compile %}>
