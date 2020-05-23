---
title:      "Cross Compilation"
tags:       cross-compilation gcc linux libc
---

Who compiles the compiler?

# Table of Contents

1.  TOC
{:toc}

# Stash

|Machine    |Purpose
|---        |---
|Build      |Builds the compiler
|Host       |Runs the compiler
|Target     |Executes the compiled code

Autoconf system definition - `<arch>-<vendor>-<os>-<libc/abi>`.

Parameters and compatibility:

|Parameter                  |Example        |Compatibility
|---                        |---            |---
|CPU architecture           |ARM            |Incompatible
|CPU architecture version   |ARMv6          |Backward
|Operating system           |Linux          |Incompatible
|OS API version             |Linux headers  |Backward for Linux
|Standard C library         |glibc          |Backward for glibc
|Compiler runtime library   |libgcc         |Backward for libgcc
|ABI                        |EABI           |Variants inside ABI

All of this is known and used when building the compiler.

Standard library components:

*   Dynamic linker/loader
*   C library w. headers

Cross-compilation issues:

*   CPU architecture - Won't execute.
*   CPU architecture version - Some instruction will fail.
*   Wrong operating system - Loader won't work.
*   Expecting newer OS API - Some system call may fail.
*   Expecting newer standard C library or compiler runtime library -
    Symbol request will fail during execution.
*   Using incompatible ABI - Execution fails due to communication with
    linked precompiled libraries, or with OS system calls.

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

https://youtu.be/Pbt330zuNPc?t=1695 - What is built when and why

Prefix/sysroot relationship - Relative path.

Used architecture, ABI - Cannot be changed without rebuild

1.  Libgcc
2.  C standard library

Operations:

1.  Build GCC using prebuilt Glibc - Won't work
2.  Build newer GCC than the one used on target - Works, although libgcc
    compatibility not guaranteed.
3.  Build newer Glibc - Works, execution risky.
4.  Using toolchain built for different machine - Works, execution not
    guaranteed.

Shared library versioning -

1.  Linker uses latest library
2.  Multiple shared libraries by major number
3.  Versioned API inside library

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

# Resources

*   [bootlin_cctc_slides] : "Anatomy of Cross-Compilation Toolchains"
    presentation slides.
*   [bootlin_cctc_rec] : "Anatomy of Cross-Compilation Toolchains"
    presentation recording.
*   [gcc_mach-dep-opt] : GCC machine-dependent options - Machine
    architecture, ABI, etc.
*   [gcc_build-config] : GCC build - Configuration options.

[bootlin_cctc_slides]: <https://bootlin.com/pub/conferences/2016/elce/petazzoni-toolchain-anatomy/petazzoni-toolchain-anatomy.pdf>
[bootlin_cctc_rec]: <https://youtu.be/Pbt330zuNPc>
[gcc_mach-dep-opt]: <https://gcc.gnu.org/onlinedocs/gcc/Submodel-Options.html>
[gcc_build-config]: <https://gcc.gnu.org/install/configure.html>
