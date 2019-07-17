---
layout: post
title:  "RPi - Basic Buildroot Image"
date:   2019-07-17 21:57 +0200
categories: embedded rpi buildroot
---

# Overview

This is the try to do the basic Buildroot image build for Raspberry Pi.
Built image will then be booted over network, using the setup made in
[the previous post]({{ site.baseurl }}{% post_url
2019-07-12-rpi3-netboot %}).

Aim is to get it boot successfully, and be able to login through the
serial console.

# HW/SW Setup Outline

Check the previous post for this. Only the new items are stated here.

## Concrete Versions

|Item                       |Value
|---                        |---
|Buildroot                  |2019.05

# Setup Procedure

1.  Get the Buildroot.
2.  Configure Buildroot, and do the build.
3.  Deploy and customize the built image.
4.  Run, enjoy. [TODO]

## Get The Buildroot

I've cloned the Buildroot Git repository in `<br-repo-dir>`, and set up
the out-of-tree build in `<br-build-dir>` -

```bash
$ git clone https://git.buildroot.net/buildroot
(br-repo-dir)$ git checkout 2019.05
(br-build-dir)$ make -C <br-repo-dir> O="$(pwd)" menuconfig
```

## Configuration

For the configuration I've used `raspberrypi3_defconfig` file as a base,
not the A64 version -

```bash
(br-build-dir)$ make raspberrypi3_defconfig
(br-build-dir)$ make menuconfig
```

Important changes made on the RPi3 defconfig - 

1.  `BR2_DEFCONFIG="$(O)/defconfig"` - Save defconfig locally, don't
    overwrite the RPi3 one.
3.  `BR2_ROOTFS_POST_SCRIPT_ARGS=""` - Remove overlay for BT mini UART
    use, we're going to use it for the console. For more info, check
    `<br-repo-dir>/board/raspberrypi3/post-build.sh`.

The defconfig file [is
here](/assets/files/posts/2019-07-17-rpi3-hello-buildroot/defconfig).

## Deployment, Customization

Deployment is done in `/tftpboot`, and `/nfs/rpi` directories, set up in
the previous article.

[TODO]

Modified config files are -
[cmdline](/assets/files/posts/2019-07-17-rpi3-hello-buildroot/cmdline.txt),
[config](/assets/files/posts/2019-07-17-rpi3-hello-buildroot/config.txt).

# Resources

*   [buildroot] : Official Buildroot page, and download location.
*   [bootlin] : Excellent guide on Buildroot use.

[buildroot]: <https://buildroot.org/>
[bootlin]: <https://bootlin.com/training/buildroot/>

