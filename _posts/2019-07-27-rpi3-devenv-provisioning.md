---
layout: post
title:  "RPi - Provisionging Netboot Environment"
date:   2019-07-27 00:36 +0200
categories: embedded rpi vagrant chef
---

# Overview

The software environment setup done in [the RPi3 network
boot post][rpi-network-boot] was done by hand. [TODO]

Aim is to automate the environment setup, so that it is possible to
network boot prepared RPi immediately from it.

# HW/SW Versions

[TODO]

# Tools

[TODO]

# Setup Procedure

[TODO]

# Resources

*   [rpi-network-boot] : Previous post on booting up RPi over network.

[rpi-network-boot]: <{{ site.baseurl }}{% post_url 2019-07-12-rpi3-netboot %}>
[vagrant-tutorial]: <https://medium.com/@Joachim8675309/vagrant-provisioning-with-chef-90a2bf724f>
[chef-resources]: <https://docs.chef.io/resource_reference.html>
[vagrant-naming]: <https://stackoverflow.com/questions/17845637>

# Sketch

The defconfig file [is
here](/assets/files/posts/2019-07-17-rpi3-hello-buildroot/).

*   Tool selection:
    *   Vagrant for bringing up the virtual machine
    *   Chef Infra for infrastructure configuration
*   Steps description:
    *   Install Vagrant
    *   Run provisioning
        *   Vagrant
            *   Install, configure VM
            *   Run Chef
        *   Chef
            *   Configure VM - Packages and configuration (Netplan, NFS,
                Dnsmasq, Picocom, Tcpdump)
                *   Verification
            *   RPi image deployment
                *   Populate directories
                *   Update configuration
                *   Verification
*   Vagrant
    *   Using the Ubuntu-built box
    *   Chef Infra Client -
        <https://github.com/swiftstack/vagrant-swift-all-in-one/issues/82>

*   Bridged IF has to be up until
    <https://github.com/hashicorp/vagrant/pull/10740> is merged. Best to
    run it with RPi on.
*   VM losing IP address - `$ sudo dhclient`

*   Steps:
    ```
    vagrant
        network adapter
        vm setup
    chef
        netplan
            address to 192.168.100.1
        nfs
        dnsmasq
        picocom
        tcpdump
        download, deploy rpi image
        configure rpi image
    ```


