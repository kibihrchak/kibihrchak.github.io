---
title:      "Visual Studio Code and CMake (and Other Tools)"
tags:       development-environment vscode cmake clang static-analysis
---

Visual Studio Code and C/C++ project development? Let's see how they
work together.

# Separation of Paths

When started with C/C++ software development, I didn't give much thought
on the integration of components that make an IDE. Basically, what I did
is to fire it up, create a project which automagically set up build
configurations, altogether with toolchain, sources and includes
configuration, and then - code away! Code assistance operations like
disabling inactive code lines, code completion, jump to definition
worked out of the box, as well as highlighting of syntax and compile
errors.

This mode of operation translated seamlessly to the MCU embedded
development, with every vendor providing a complete tool ecosystem for
creating a firmware to be executed on their hardware platform portfolio.
But, on the other hand, Linux application development diverged in the
other area, one with clear demarcation between the code editor, and the
build system. There, former was seen as independent from the latter, and
furthermore, oblivious to the configuration provided by it. And, even
with the editor providing facilities as aforementioned code assistance
and highlighting, it was often a manual process to keep its perception
of software project configuration in line with the build system's one.
This led to being wary of these "assistance" tools as they could provide
a false image on the project code, and went as far as ditching them
altogether and demoting the code editor to a intelligent text editor at
best, dumb notepad at worst.

# Enter VSCode

There were previous interests for regaining this connection between a
development environment and a code editor, but with short longevity.
This state of affairs went on as I got introduced to a
[VSCode](https://code.visualstudio.com/). I've ditched it first as a
coding hipsters kind of a tool, especially seeing it in light of web
development where it first took ahold. Instead, I've stuck rather to a
proven Vim text editing environment. But, gradually I transitioned to
VSCode, mostly driven by liking of its workspace management and a
suitable enough Vim extension. With time it became my main file projects
management tool, providing almost all-in-one environment for needed
operations.

So, with that in mind I've revisited the old topic of bridging a gap
between a code editor and a the build system. The question was, can
Visual Studio Code be connected with a C/C++ set up console-driven build
system, and assist in the code development while relying on the project
configuration specified outside of it?

# Setting The Stage

First topic to clarify was, what would be the assumed build system to
attach to? [CMake](https://cmake.org/) here came out as a first
candidate, as it is a popular-enough project
configure/build/test/package toolkit, and with which I had most previous
experience. As for the other options, plain Makefiles are also a good
option but more suitable for simpler task specification, and other
toolkits I haven't considered at all.

Second topic was, what would be the expectations from the integration?
From the top of the head first would be code assistance aligned with
selected build configuration, that is with selected source files to be
built, included includes and libraries, and project defines. Next in
line would be interface for running build system tasks, then
configuration of the debugger so that a debug session can be ran from
VSCode. As a last addition, integration with code writing assistance
tools, namely a formatter and a static analysis would be great, with
latter again aligned to the current build configuration.

For formatting and static analysis choice fell on the Clang toolkit,
[ClangFormat](https://clang.llvm.org/docs/ClangFormat.html) and
[Clang-Tidy](https://clang.llvm.org/extra/clang-tidy/), mostly because
they're good free tools, with configuration specifiable in config files,
and with good preexisting integration to VSCode and CMake.

# Add Extensions to The Mix

Basically, to get things running all I needed were two extensions for
VSCode -
[`ms-vscode.cpptools`](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
for code assistance and formatting, and
[`ms-vscode.cmake-tools`](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
for CMake integration. With them, and with other prerequisite packages
installed in the evaluation VM (gdb, clang-format, clang-tidy), I was
set to go.

# Initial Impressions

In short, positive. Code assistance works for the opened projects, even
if CMake contains subprojects with same-named symbols. Interface also
works without a hitch - Configuring project, building it, running
particular subproject. Debugging, too, non-compiled code gets ignored
just fine.

For the additional tools, VSCode invokes formatting per given
configuration, while static analysis is enabled through CMake and ran
before the compilation unit build. What made me smile is that the
reported analysis findings are shown in the code editor window
altogether with squiggly lines.

# What Next?

Well, good initial findings are there, but there's still that nagging
feeling about disjuncture between the build system and code editor.
Guess it will need some additional test projects and the use of this
integration on the actual projects to dispel that impression.

If you want to check it out, current VSCode workspace with test projects
I have hosted on GitHub - [here's a repo
link](https://github.com/kibihrchak/hello-vscode-cmake).
