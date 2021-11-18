---
title:      "Home Server Setup"
tags:       nas media-server ansible provisioning
---

"The Swiss knife of servers!"

## Table of Contents

1.  TOC
{:toc}

## Version History

|Date       |Description
|---        |---
|2021-11-18 |Initial version

## Overview

This whole thing came out of a desire to have a private NAS, basically,
to be able to share collected files among owned devices. Then it went to
adding a torrent client to be able to seed all legally owned copies of
stuff, to add VPN to hide the connection from ISP and make it resilient
for an external access. Then to adding a media streaming service and VPN
tunnelling and home automation server. And last but not least,
encrypting the whole thing using
[LUKS](https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup) and using
[ZFS](https://en.wikipedia.org/wiki/ZFS) for data storage.

But, one thing at a time. For the starter, having a file server, torrent
client and VPN will suffice.

## What am I working with?

Well, the initial research was on procuring one of the pre-made NAS
solutions and expand it further. But after obtaining an Intel NUC,
[6i5SYK](https://www.intel.com/content/www/us/en/products/sku/89188/intel-nuc-kit-nuc6i5syk/specifications.html)
in particular, I've decided on going with a custom solution.

Regarding the content storage, I've went with the 2.5" USB HDD attached
to the NUC.

As for the software solution, went with customizing an [Ubuntu Server
distro](https://ubuntu.com/download/server), as it seems to suffice for
the intended use and be nimbler than using eg.
[OMV](https://www.openmediavault.org/).

Next, onto how to do it. The choice here is to automate what can be done
from provisioning using
[Testinfra](https://testinfra.readthedocs.io/en/latest/) to specify the
expected system state and [Ansible](https://github.com/ansible/ansible)
to document and perform the actual provisioning, as experience with
these tools would be universally applicable.

The last step is the question how to support the development testing.
There the use of [VirtualBox](https://www.virtualbox.org) and setting up
an instance of the virtual server seems like a good option. Then the
development steps can be quickly tested on the VM, and when verified to
work as intended, setup can be deployed on the actual device.

So, that should all look something like this:

![deployment
diagram](/assets/posts/guides/2021-11-18-home-server-setup/deployment-diagram.png)

## Expected Server State

Here are the details of the expected system state, as well as the marker
if that state element can be reached automatically ([A]) or need to be
set up manually ([M]).

1.  [M] Install latest Ubuntu Server (20.04).
2.  System configuration:
    1.  [?] Dedicated user for running all services.
    2.  [M] Router static address assignment to the server.
    3.  [M] External HDD auto mount.
3.  Software installation and config:
    1.  [M] SSH server.
    2.  [A] SAMBA server.
    3.  [A] NordVPN client.
    4.  [A] GUI-less qBittorrent client.
4.  Data drive (external HDD) setup:
    1.  [M] Partitioning and file system setup.
    2.  [M] File organization.

## Resources

## To-Do

*   Add media streaming server.
*   Add home automation server.
*   Add VPN tunnelling.
*   Encrypt disks.
*   Increase fault tolerance for data drives (introduce RAID).
*   Switch to ZFS for data storage.
*   Increase server robustness by controlling them through systemd services.
