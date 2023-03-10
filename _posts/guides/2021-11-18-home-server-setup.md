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

## [TODO] Server Details

initial user with sudo permissions - used for provisioning
user for services - home-server

file layout - 

/mnt/data - Mount point for data
/mnt/data/user/home-server/data/apps/qbittorrent
/mnt/data/user/<user> - <user> directory shared by SAMBA
/mnt/data/shr - Will be shared by SAMBA
/mnt/data/shr/torrents
/mnt/data/shr/media

## Expected Server State

Here are the details of the expected system state:

1.  Manual setup.
2.  System configuration:
    1.  Dedicated user for running all services.
3.  Software installation and config:
    1.  SAMBA server.
    2.  NordVPN client.
    3.  GUI-less qBittorrent client.
4.  Data drive (external HDD) setup:
    2.  File organization.

### Manual Setup

http://cobbler.github.io/
https://blog.scottlowe.org/2015/05/20/fully-automated-ubuntu-install/
https://fai-project.org/fai-guide/#_a_id_work_a_how_does_fai_work

1.  Router static address assignment to the server.
2.  Install latest Ubuntu Server (20.04).
    1.  English language.
    2.  English (US) keyboard.
    3.  No network interface config.
    4.  No proxy.
    5.  Default mirror address.
    6.  Whole disk, no LVM, no encryption.
    7.  Create user for provisioning.
    8.  Install OpenSSH server, no SSH identity import.
    9.  No snaps.
3.  Remote access setup:
    1.  Generate SSH key and copy it to the server via
        [`ssh-copy-id`](https://www.ssh.com/academy/ssh/copy-id).
    2.  Execute sudo w/o password for the provisioning user.
4.  Data partition setup:
    1.  Create and setup data partition.
    2.  Create mount point directory `/mnt/data`.
    3.  Auto-mount data partition by [editing
        fstab](https://wiki.archlinux.org/title/Fstab), then reloading
        it with `# mount -a`.

#### Setting up Data Partition for Test Server

On the test server a data partition can be set up as a file containing
the partition and mount it as a loop device -

```{.bash}
# dd if=/dev/zero of=/root/data.ext4 bs=1M count=1000
# mkfs.ext4 /root/data.ext4
# cat <<EOF >> /root/test.txt 
> # Home server data partition
> /root/data.ext4 /mnt/data ext4 defaults 0 0 
> EOF
```

## Resources

## To-Do

*   Add media streaming server.
*   Add home automation server.
*   Add VPN tunnelling.
*   Encrypt disks.
*   Increase fault tolerance for data drives (introduce RAID).
*   Switch to ZFS for data storage.
*   Increase server robustness by controlling them through systemd services.
