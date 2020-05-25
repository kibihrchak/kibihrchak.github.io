---
title:      "A Take on GCC Linux Cross-Compilation"
tags:       cross-compilation gcc linux libc
---

`arm-linux-gnueabihf`, almost usable for all platforms.

# Table of Contents

1.  TOC
{:toc}

# Overview

This is a look on what consists a cross-compiler toolkit for a Linux
target, what are its specifics, and as the subtitle says, why is a
cross-compiler tied to a particular target even if the toolkit name
prefix sounds generic enough so that it can cover a multitude of
platforms. And at last, why that sometimes may be the case.

# Cross-Compilation 101

Here's a quick refresher on cross-compilation.

Cross compilation
:   A process of building code on one machine that is to be executed on
    another (potentially incompatible) machine.

As this process considers using different machines (execution platforms,
that is), here's a recap of these -

|Machine    |Purpose
|---        |---
|Build      |Builds the compiler
|Host       |Runs the compiler
|Target     |Executes the compiled code

And here's a recap of different build types -

|Build name     |Compiler built on  |Compiler ran on|Built code ran on
|---            |---                |---            |---
|Native         |A                  |A              |A
|Cross          |A                  |A              |B
|Cross-native   |A                  |B              |B
|Canadian cross |A                  |B              |C

# Parameters and Compatibility

Next, onto what parameters impact the resulting cross-compiler.

|Parameter                  |Example        |Compatibility
|---                        |---            |---
|CPU architecture           |ARM            |Incompatible
|CPU architecture variant   |ARMv6          |Backward(1)
|ABI                        |EABI           |Variants inside ABI(2)
|Object file format         |ELF            |Incompatible
|OS API                     |Linux API      |Backward for Linux one
|Standard C library(3)      |glibc          |Backward for glibc
|Compiler runtime library   |libgcc         |Backward for libgcc

Notes:

1.  Eg. for ARM AArch32, or x86 sans extensions.
2.  Eg. EABI hard-float and soft-float variants are compatible between
    themselves.
3.  Standard library components:
    *   Dynamic linker/loader
    *   C library with headers

Knowledge on *all of these parameters* is used when building the
compiler.

## Cross-Compilation Issues

Now, with knowledge what parameters are all involved when making a
cross-compiler, let's see what are the potential effects of using an
unsuitable one:

*   Wrong CPU architecture - Invalid code execution.
*   Unsupported CPU architecture variant - Unsupported instruction
    execution will fail.
*   Using incompatible ABI - Execution fails upon trying to communicate
    with linked libraries, or when trying to invoke an OS system call.
*   Wrong object file format - Linker/loader won't accept the file.
*   Using wrong OS API - System calls will outright fail.
*   Using newer OS API than the one supported - Some system call may
    fail.
*   Expecting newer standard C library or compiler runtime library -
    Symbol request will fail during execution.

# Linux Shared Libraries

|Name           |Naming example             |Note
|---            |---                        |---
|soname         |`libstdc++.so.6`(1)        |Symlink to real name
|Real name      |`libstdc++.so.6.0.28`      |-
|Linker name    |`libstdc++.so`             |Symlink to latest soname

Notes:

1.  Standard C libraries don't start with `lib`.

Quick look on Linux shared library versioning -

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

# GCC Build

Autoconf system definition - `<arch>-<vendor>-<os>-<libc/abi>`.

|Tool           |Use on |Expected in    |Note
|---            |---    |---            |---
|Binutils       |Host   |Prefix         |Linker and assembler
|GCC dep. libs  |Host   |GCC build      |For built-time calculations
|Kernel headers |-      |Sysroot        |For target OS
|1st stage GCC  |Host   |Prefix         |Static C only, no libc
|Libc           |Target |Sysroot        |-
|2nd stage GCC  |H/T(1) |Pref/Sysroot(1)|Need to know libc names/vers(2)

1.  Libgcc built for target.
2.  Changing Libc requires GCC rebuild!
Prefix/sysroot relationship - Relative path.

Used architecture, ABI - Cannot be changed without rebuild

1.  Libgcc
2.  C standard library

Toolchain directory contents:

1.  GCC requires binutils names without prefix
2.  Standard C++ library considered as a build-up to C library
3.  GCC library headers
4.  Linker scripts

Cross-compiler stuff and where's it going to end up -

|Stuff                  |Where
|---                    |---
|C static libraries     |Compiled program(1)
|C dynamic libraries    |Target
|C libraries headers    |Compiled program
|GCC static libraries   |Compiled program(1)
|CRT object files       |Compiled program
|GCC headers            |Compiled program
|Linker scripts         |Compiled program
|Binaries               |Build platform
|Documentation          |Build platform

# Alternative Takes

1.  Build GCC using prebuilt Glibc - Won't work
2.  Build newer GCC than the one used on target - Works, although libgcc
    compatibility not guaranteed.
3.  Build newer Glibc - Works, execution risky.
4.  Using toolchain built for different machine - Works, execution not
    guaranteed.

# Stash

https://youtu.be/Pbt330zuNPc?t=1695 - What is built when and why

# Resources

*   [bootlin_cctc_slides] : "Anatomy of Cross-Compilation Toolchains"
    presentation slides.
*   [bootlin_cctc_rec] : "Anatomy of Cross-Compilation Toolchains"
    presentation recording.
*   [gcc_mach-dep-opt] : GCC machine-dependent options - Machine
    architecture, ABI, etc.
*   [gcc_build-config] : GCC build - Configuration options.
*   [bootlin_emblin_slides] : General information on cross-compilers.
*   [tldp_so] : Naming, version info on shared libraries.

[bootlin_cctc_slides]: <https://bootlin.com/pub/conferences/2016/elce/petazzoni-toolchain-anatomy/petazzoni-toolchain-anatomy.pdf>
[bootlin_cctc_rec]: <https://youtu.be/Pbt330zuNPc>
[gcc_mach-dep-opt]: <https://gcc.gnu.org/onlinedocs/gcc/Submodel-Options.html>
[gcc_build-config]: <https://gcc.gnu.org/install/configure.html>
[bootlin_emblin_slides]: <https://bootlin.com/doc/training/embedded-linux/embedded-linux-slides.pdf>
[tldp_so]: <http://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html>
