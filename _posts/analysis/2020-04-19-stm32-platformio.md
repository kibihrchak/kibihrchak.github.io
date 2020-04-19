---
layout:     post
title:      "STM32 use on PlatformIO"
date:       2020-04-19 16:17 +0200
categories: embedded stm32 platformio
---

# Todo

1.  Devise use cases to be tested
2.  PlatformIO general overview
3.  Go through the use cases and compare PlatformIO to STM32CubeIDE
4.  Additional PlatformIO features

# Use Cases

|As a|I want to|In order to|
|---|---|---|
|DevOps|Select toolchain and framework|Have requested build environment|
|DevOps|Set up the devenv|Developers can do their activities|
|Developer|Easily configure MCU|Have a firmware tailored to a board|
|Developer|Develop user code|Implement required functionality|
|Developer|Write, run unit tests|Verify required functionality|
|Developer|Build, flash firmware to target|Check operation on hardware|
|Developer|Run a debug session|Troubleshoot invalid execution|

# Workflows

1.  Use STM tools exclusively, that is, STM32CubeIDE.
2.  Use PlatformIO framework, and supplement it with STM tools where
    needed.

## Select Toolchain and Framework

|Workflow|Toolchain and toolchain version selection|
|---|---|
|STM32CubeIDE|GCC, shipped with STM32CubeIDE (tied to IDE version)|
|PlatformIO|GCC, tied to (development) platform version|

|Workflow|Framework and framework version selection|
|---|---|
|STM32CubeIDE|STM32Cube primarily|
|PlatformIO|Able to select different frameworks|

For PlatformIO, it is possible to specify platform/framework version in
the configuration file.

## Development Environment Setup

|Workflow|Tools provisioning|
|---|---|
|STM32CubeIDE|Install STM32CubeIDE from official sources|
|PlatformIO|Install IDE (VSCode), install PlatformIO and support tools|

For PlatformIO workflow, PlatformIO can be installed through a VSCode
extension, or as a standalone tool.

## MCU Configuration and Code Generation

|Workflow|MCU configuration and code generation|
|---|---|
|STM32CubeIDE|Integrated STM32CubeMX use|
|PlatformIO|Can use STM32CubeMX externally to perform configuration|

For both workflows, important question is the way code is generated, that is -

1.  Are used framework/middleware files going to be just linked in the
    project,
2.  Or copied?

First approach results in a smaller project size, and no file
duplication in case of having multiple projects. On the other hand,
linking files results in introduction of framework path in the project
configuration, which reduces portability. Also, devenv provisioning is
more complex (framework needs to be provided). So, second approach is
considered here.

For PlatformIO, most convenient approach is to:

1.  Generate source files using STM32CubeMX.
2.  Add these directories to the project configuration.

[stm32pio tool][stm32pio] and its accompanying workflow may help here.

[TODO] middleware/additional packages configuration for PlatformIO.

## User Code Development

[TODO]

## Writing and Execution of Unit Tests

[TODO]

## Debug Session

[TODO]

# Resources

[platformio-devplatform]: <https://docs.platformio.org/en/latest/platforms/index.html>
[platformio-ver-selection]: <https://community.platformio.org/t/how-to-downgrade-nodemcu-platform-version/7614>
[platformio-stm32cubemx]: <https://community.platformio.org/t/using-stm32cubemx-and-platformio/2611/2>
[platformio-stm32cube]: <https://docs.platformio.org/en/latest/frameworks/stm32cube.html>
[stm32pio]: <https://github.com/ussserrr/stm32pio>
