---
title:      "Cross-compile Program for Raspbian"
tags:       rpi cmake raspbian cross-compilation
---

"Hello, Raspbian from a more capable build machine!\n"

# Table of Contents

1.  TOC
{:toc}

# Overview

Goal is to set up a cross-compilation environment on an Ubuntu-based
machine and build a "Hello, world!" CMake project for the target.

Setup used for testing is -

|Component          |Value
|---                |---
|Build OS           |Ubuntu 20.04 LTS
|Target OS          |Raspbian Buster Lite, February 2020
|Target platform    |Raspberry Pi 3 Model B

# Cross-Compilation Toolchain Selection

Here, the main point is to obtain the cross-compilation toolchain for
RPi. The important thing is that this toolchain produces binaries which
are compatible with the execution environment. This is a topic to be
covered, but for now following toolchains will work:

|Source             |GCC version    |Source
|---                |---            |---
|[toolchain_rpi]    |4.9.3          |Raspberry Pi Foundation
|[toolchain_pro]    |8.3.0          |Alternative build by Pro

Notes:

1.  RPi repo has several toolchains. Select one per [this
    article][deardevices_rpi-cross-compile].

# Environment/Project Setup Procedure

1.  Checkout this repo with test CMake projects - [GitHub
    link][hello-vscode-cmake].
2.  Set up the RPi test project per its readme.

# Building The Project

1.  Run configure/build for CMake (`<project>/build$ cmake .. && make`).
2.  Built binaries are in CMake subproject subdirectories.
3.  We can verify they have been cross compiled by running `file` -
    ```
    <project>/build/hello-raspbian-cross-pi-gcc$ file HelloRaspbianCrossPiGcc 
    HelloRaspbianCrossPiGcc: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 3.2.0, with debug_info, not stripped
    ```

# Resources

*   [toolchain_rpi] : Overview of MCU and the ESP32-based boards.
*   [toolchain_pro] : Page with pretty much everything on ESP32.
*   [hello-vscode-cmake] : Repo with test CMake project.
*   [pro-toolchain-build] : Article on building a GCC toolchain for RPi.
*   [cmake-cross-compile] : How to setup CMake project for cross
    compilation.
*   [deardevices_rpi-cross-compile] : How to setup RPi provided
    toolchains.

[toolchain_rpi]: <https://github.com/raspberrypi/tools>
[toolchain_pro]: <https://github.com/Pro/raspi-toolchain>
[hello-vscode-cmake]: <https://github.com/kibihrchak/hello-vscode-cmake>
[pro-toolchain-build]: <https://solarianprogrammer.com/2018/05/06/building-gcc-cross-compiler-raspberry-pi/>
[cmake-cross-compile]: <https://cmake.org/cmake/help/v3.17/manual/cmake-toolchains.7.html#cross-compiling-for-linux>
[deardevices_rpi-cross-compile]: <https://deardevices.com/2019/04/18/how-to-crosscompile-raspi/>

# To-Do

1.  Checklist for toolchain suitability for the given target. 
