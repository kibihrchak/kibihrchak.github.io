---
title:      "VS Code Remote Development"
tags:       vs-code remote-development development-environment
---

When remote work is not enough.

## Initial Encounter with VS Code Remote Development

During the past week I gave [VS Code Remote
Development](https://code.visualstudio.com/docs/remote/remote-overview)
a try, mainly to see how it would work with a build environment set up
in a Docker container. Victim for this was [this blog
repo](https://github.com/kibihrchak/kibihrchak.github.io), so the work
went in setting up an image with Jekyll/GitHub Pages, and feeding it
this repo's content to inspect the locally generated output.

First try went with using the Docker Desktop on the Windows host. But,
it appeared that running Docker Desktop relies on Hyper-V being enabled,
and that brought its own set of issues, [in particular with
VirtualBox](https://forums.virtualbox.org/viewtopic.php?t=90853). With
that encountered, I've moved the Docker installation to the VirtualBox
Ubuntu VM with an idea to run VS Code there (better something than
nothing). But, as it happened, VS Code offers an option [to remotely
connect to a container through
SSH](https://code.visualstudio.com/docs/remote/containers#_open-a-folder-on-a-remote-ssh-host-in-a-container).
This allowed me at the end to have the following setup which
surprisingly enough works without a hitch:

1.  VS Code runs on the Windows host.
2.  It can SSH to the Ubuntu VirtualBox VM and open up workspaces there.
3.  Furthermore, it can run a Docker container in the said VM and work
    on a workspace inside of it.

## Common Development Interface

The most significant benefit of this setup for me is the ability to use
the common development interface, but tailored to the peculiarities of
the particular project. This kind of setup before required either -

*   Doing the development on the same base system, which led to the
    overlapping of development environment setups (needed software, VS
    Code extensions), or
*   Having multiple instances of VS Code deployed in independent
    development environments, which then required repeated base setup of
    VS Code, and introduced an effort for keeping this base setup same
    between all environments.

With this remote development setup, it is possible to use the same,
*host-based* instance of VS Code, and then have separate configurations
for each *independent* development environment. First point allows for
the speed and convenience of doing the work from the host-based
interface, and not having to run the VS Code through virtual machine
instances. Second point means that the development environments are not
mashed together which complicates provisioning and gives opportunity for
environment collisions.

In this vein, an ideal development setup for me should be looking
something like this:

1.  Have the base VS Code setup on the host system for host-related
    projects (that is, text-based projects, or the software projects
    intended to be ran on the host system).
2.  For each non-host project, their build/test environment is set up in
    an isolated fashion through Docker.
