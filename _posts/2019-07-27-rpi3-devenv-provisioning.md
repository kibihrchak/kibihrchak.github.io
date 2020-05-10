---
title:  "RPi - Provisioning Netboot Environment"
categories: embedded rpi vagrant chef
---

The software environment setup done in [the post on booting the RPi over
network][rpi-network-boot] had an environment set up by hand - Virtual
machine, package installation, configuration, image deployment etc. This
post looks at how to facilitate setup process.

Aim is to automate the setup of environment from that post, so that it
is possible to network boot prepared RPi (USB host booting OTP boot bit
set, SD card prepared) immediately from it.

# Process Outline

Plan is to use [Vagrant][vagrant-intro]/[Chef Solo][chef-solo-intro]
combination for an automated VM bring-up, and infrastructure
configuration, respectively.

First, Vagrant will be configured through a [Vagrantfile][vagrantfile]
to get a generic GUI-less Ubuntu box and create a VirtualBox machine out
of it, set it up regarding the allocated RAM, CPU cores, and network
adapters, share the necessary directories from the host machine,
and then boot it up. As a last step, it will install Chef Solo in the
VM, and kick it running.

Next, Chef Solo will, using the provided recipe perform the necessary
operations on the VM to get it to the desired state. This encompass all
steps stated in the base post, in short - Package install, mount/served
directories creation, server configuration and startup, RPi image
retrieval/unpacking/deploying to served directories, and finally the
deployed RPi image configuration.

After these steps are performed, it would be sufficient just to plug in
RPi as in the previous post, and it should boot without issues.

# HW/SW Setup Outline

Setup from the base post is recreated here. Update SW versions are given
below.

## Concrete Versions

|Item                       |Value
|---                        |---
|Virtualization software    |VirtualBox 6.0.10r132072
|Vagrant                    |Vagrant 2.2.5
|Vagrant box                |Stated in the Vagrantfile
|Chef Solo                  |Most recent (Chef Infra Client: 15.1.36)
|RPi image                  |Stated in the Chef recipe 

## Network Setup

Setup is the same as in the base post, except for one difference -
192.168.100.0/24 address range will be used, guest having the address
192.168.100.1.

<!-- [TODO] Add a chapter on the infrastructure configuration files -->

# Setup Procedure

1.  Set up host VM - Install VirtualBox and Vagrant, and pick up
    infrastructure configuration files.
2.  Perform provisioning.
3.  Boot, try RPi.
4.  Stop the Vagrant machine.

## Set Up

Software installation should be straightforward, no issues encountered
there.

As for the infrastructure configuration files, they can be found in the
page's GitHub repo, [this directory][infra-config].

## Provisioning

In order to start the provisioning run the command below, with
`infra-config-dir` being the directory where files from the previous
step have been copied.

Also, in case the network adapter to be bridged by the VM is not used at
the moment (disconnected, down), it is needed to connect it to something
before running the command. Otherwise, during the machine bring-up
Vagrant will not offer it for bridging. There is [an PR on
GitHub][vagrant-if-check-pr] related to this behavior of Vagrant.

```
(infra-config-dir)$ vagrant up
```

With this, Vagrant should display in console the progress of
provisioning, with final message being something like -

```
==> default: Chef Infra Client finished, 26/31 resources updated in 06 minutes 53 seconds
```

## Boot RPi

Here, it is sufficient to (re)plug the RPi power source, and it will
boot successfully. For tracking the boot progress at the moment some
host serial console can be used.

<!-- [TODO] Modify Vagrantfile so that the serial adapter connects to
the VM; Update this chapter -->

## Stop The Vagrant Machine

To stop the machine, one of these two commands can be used:

```
(infra-config-dir)$ vagrant suspend
(infra-config-dir)$ vagrant halt
```

# Notes

Other observations made while working on this are -

*   Chef Infra Client need to have its licence accepted during setup. In
    order to automate this, configuration file has to be added. See the
    [GitHub issue][chef-infra-licence] on this.
*   There were issues with running the Canonical-provided [Ubuntu Server
    18.04 box][ubuntu-box]. It would stall during boot for some reason.
    After reverted to the generic box, everything worked fine. Good
    thing for troubleshooting is to enable `v.gui = true` in the
    Vagrantfile.
*   During the work on VM provisioning, it happened sometimes after
    running `$ vagrant up` that it does not acquire an IP address on the
    NAT adapter. Enabling the GUI, and from it running
    `(vagrant-machine):~$ sudo dhclient` solves the issue.
*   For RPi, Buster Lite image is used. That one has an issue with
    booting on RPi3. Fix from [this post][buster-boot-fail] is applied,
    and it works.

# Resources

*   [vagrant-intro] : Info on Vagrant.
*   [chef-solo-intro] : Info on Chef Solo.
*   [vagrantfile] : Info on Vagrantfile.
*   [vagrant-if-check-pr] : Vagrant PR to allow bridging the down host
    interfaces.
*   [chef-infra-licence] : Automatically accepting Chef Infra licence.
*   [ubuntu-box] : Ubuntu box with which I've had an issue.
*   [vagrant-tutorial] : Good intro tutorial on Vagrant/Chef Solo.
*   [chef-resources] : Info on Chef resources.
*   [vagrant-naming] : Info on how Vagrant forms a machine name in
    VirtualBox.
*   [buster-boot-fail] : Raspbian Buster boot freeze issue discussion.

[rpi-network-boot]: <{{ site.baseurl }}{% post_url 2019-07-12-rpi3-netboot %}>
[infra-config]: <https://github.com/kibihrchak/kibihrchak.github.io/tree/master/assets/files/posts/2019-07-27-rpi3-devenv-provisioning>

[vagrant-intro]: <https://www.vagrantup.com/intro/index.html>
[chef-solo-intro]: <https://docs.chef.io/chef_solo.html>
[vagrantfile]: <https://www.vagrantup.com/docs/vagrantfile/>
[vagrant-if-check-pr]: <https://github.com/hashicorp/vagrant/pull/10740>
[chef-infra-licence]: <https://github.com/swiftstack/vagrant-swift-all-in-one/issues/82>
[ubuntu-box]: <https://app.vagrantup.com/ubuntu/boxes/bionic64>
[vagrant-tutorial]: <https://medium.com/@Joachim8675309/vagrant-provisioning-with-chef-90a2bf724f>
[chef-resources]: <https://docs.chef.io/resource_reference.html>
[vagrant-naming]: <https://stackoverflow.com/questions/17845637>
[buster-boot-fail]: <https://www.raspberrypi.org/forums/viewtopic.php?p=1496972>
