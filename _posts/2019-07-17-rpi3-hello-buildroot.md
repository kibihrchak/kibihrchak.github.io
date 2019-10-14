---
layout: post
title:  "RPi - Basic Buildroot Image"
date:   2019-07-17 21:57 +0200
categories: embedded rpi buildroot
---

This is the try to do the basic Buildroot image build for Raspberry Pi.
Built image will then be booted over network, using the setup made in
[the previous post][rpi-network-boot].

Aim is to get it boot successfully, and be able to login through the
serial console.

# HW/SW Setup Outline

Check [the previous post][rpi-network-boot] for this. Only the new
items are stated here.

## Concrete Versions

|Item                       |Value
|---                        |---
|Buildroot                  |2019.05

# Setup Procedure

1.  Get the Buildroot.
2.  Configure Buildroot, and do the build.
3.  Deploy and customize the built image.
4.  Run, enjoy.

## Get The Buildroot

I've cloned the Buildroot Git repository in `<br-repo-dir>`, and set up
the out-of-tree build in `<br-build-dir>` -

```bash
$ git clone https://git.buildroot.net/buildroot
(br-repo-dir)$ git checkout 2019.05
(br-build-dir)$ make -C <br-repo-dir> O="$(pwd)" menuconfig
```

## Configuration, Build

For the configuration I've used `raspberrypi3_defconfig` file as a base,
not the A64 version. General info on the setup, and what to expect as a
build output can be seen in
`<br-repo-dir>/board/raspberrypi3/readme.txt`.

Here are the executed commands -

```bash
(br-build-dir)$ make raspberrypi3_defconfig
(br-build-dir)$ make menuconfig
```

Important changes made on the RPi3 defconfig - 

1.  `BR2_DEFCONFIG="$(O)/defconfig"` - Save defconfig locally, don't
    overwrite the RPi3 one.
3.  `BR2_ROOTFS_POST_SCRIPT_ARGS=""` - Remove overlay for BT mini UART
    use, we're going to use it for the console.

The defconfig file [is
here](/assets/files/posts/2019-07-17-rpi3-hello-buildroot/defconfig).

Regarding the post script arguments, for more info check
`<br-repo-dir>/board/raspberrypi3/post-image.sh`.

With that cleared, do -

```bash
(br-build-dir)$ make
```

It should take an hour or so, and some GiB of disk space to do the
build.

## Deployment, Customization

Deployment is done in `/tftpboot`, and `/nfs/rpi` directories, set up in
the previous article. Important changes are related to:

1.  Enabling the RFS NFS mount.
2.  Setting console to mini UART.

Modified config files are -
[cmdline](/assets/files/posts/2019-07-17-rpi3-hello-buildroot/cmdline.txt),
[config](/assets/files/posts/2019-07-17-rpi3-hello-buildroot/config.txt).

## Run

For tracking the boot process, see [the previous
post][rpi-network-boot].

Here's a snippet of boot console output -

```
[    8.415777] IP-Config: Got DHCP answer from 192.168.1.1, my address is 192.168.1.132
[    8.423663] IP-Config: Complete:
[    8.426943]      device=eth0, hwaddr=b8:27:eb:49:f5:8c, ipaddr=192.168.1.132, mask=255.255.255.0, gw=192.168.1.1
[    8.437283]      host=192.168.1.132, domain=, nis-domain=(none)
[    8.443303]      bootserver=192.168.1.1, rootserver=192.168.1.1, rootpath=
[    8.443310]      nameserver0=192.168.1.1
[    8.479199] VFS: Mounted root (nfs filesystem) on device 0:15.
[    8.487104] devtmpfs: mounted
[    8.496264] Freeing unused kernel memory: 1024K
[    8.512126] Run /sbin/init as init process
Starting syslogd: OK
Starting klogd: OK
Initializing random number generator... [    8.988141] random: dd: uninitialized urandom read (512 bytes read)
done.
Starting network: [    9.376368] NET: Registered protocol family 10
[    9.383117] Segment Routing with IPv6
ip: RTNETLINK answers: File exists
Skipping eth0, used for NFS from 192.168.1.1
FAIL

Welcome to Buildroot
buildroot login:
Welcome to Buildroot
buildroot login: root
# uname -r
4.19.23-v7
# ip a show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether b8:27:eb:49:f5:8c brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.132/24 brd 192.168.1.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::ba27:ebff:fe49:f58c/64 scope link
       valid_lft forever preferred_lft forever
# [   19.942026] random: crng init done

# poweroff
# Stopping network: ifdown: interface lo not configured
ifdown: interface eth0 not configured
OK
Saving random seed... done.
Stopping klogd: OK
Stopping syslogd: OK
umount: devtmpfs busy - remounted read-only
The system is going down NOW!
Sent SIGTERM to all processes
Sent SI[   27.388058] reboot: Power down
```

# Resources

*   [buildroot] : Official Buildroot page, and download location.
*   [bootlin] : Excellent guide on Buildroot use.
*   [rpi-network-boot] : Previous post on booting up RPi over network.

[buildroot]: <https://buildroot.org/>
[bootlin]: <https://bootlin.com/training/buildroot/>
[rpi-network-boot]: <{{ site.baseurl }}{% post_url 2019-07-12-rpi3-netboot %}>

