apt_update 'update'


#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Install packages

#   [TODO] Specify package versions
apt_package 'netplan.io'
apt_package 'nfs-kernel-server'
apt_package 'dnsmasq'
apt_package 'picocom'
apt_package 'tcpdump'

#   [TODO] Verify that packages have been installed


#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Set user groups

#   Needed to use Picocom without a password
group 'dialout' do
    append true
    members 'vagrant'
    action :modify
end


#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Create directories

directory '/nfs/rpi' do
    owner 'root'
    group 'root'
    recursive true
end

directory '/tftpboot' do
    owner 'root'
    group 'root'
    mode '0777'
end

directory '/home/vagrant/rpi' do
    owner 'vagrant'
    group 'vagrant'
    recursive true
end

directory '/mnt/rpi/boot' do
    owner 'root'
    group 'root'
    recursive true
end

directory '/mnt/rpi/rfs' do
    owner 'root'
    group 'root'
    recursive true
end

#   [TODO] Verify dir creation


#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Copy config files
#   [TODO] Replace with `remote_directory`

cookbook_file '/etc/netplan/02-rpi-bridged-network.yaml' do
    source '/etc/netplan/02-rpi-bridged-network.yaml'
end

cookbook_file '/etc/dnsmasq.conf' do
    source '/etc/dnsmasq.conf'
end

cookbook_file '/etc/exports' do
    source '/etc/exports'
end

#   [TODO] Verify file copy


#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Restart needed services

execute 'netplan' do
    command 'netplan apply'
end

service 'nfs-kernel-server' do
    action [ :enable, :restart ]
end

service 'dnsmasq' do
    action [ :enable, :restart ]
end


#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Get, unpack RPi image

remote_file 'get rpi image' do
    path '/home/vagrant/rpi/2019-07-10-raspbian-buster-lite.zip'
    source 'http://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2019-07-12/2019-07-10-raspbian-buster-lite.zip'
    checksum '9e5cf24ce483bb96e7736ea75ca422e3560e7b455eee63dd28f66fa1825db70e'
    owner 'vagrant'
    group 'vagrant'
end

execute 'unpack rpi image' do
    command 'unzip -o 2019-07-10-raspbian-buster-lite.zip'
    user 'vagrant'
    cwd '/home/vagrant/rpi'
    not_if 'echo "cce3cdaa078597d0b2181f7e121a452346c72bca9095893e56e01c82e524c276 2019-07-10-raspbian-buster-lite.img" | sha256sum --check'
end

#   [TODO] Verify unpacked file


#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Mount partitions, copy files, unmount partitions

mount 'mount rpi boot partition' do
    device '/home/vagrant/rpi/2019-07-10-raspbian-buster-lite.img'
    mount_point '/mnt/rpi/boot'
    #   `sizelimit` added to allow for multiple mounts on a same image
    options ["ro", "offset=4194304", "sizelimit=268435968"]
    action :mount
end

mount 'mount rpi rfs partition' do
    device '/home/vagrant/rpi/2019-07-10-raspbian-buster-lite.img'
    mount_point '/mnt/rpi/rfs'
    #   `sizelimit` added to allow for multiple mounts on a same image
    options ["ro", "offset=276824064", "sizelimit=1920991232"]
    action :mount
end

execute 'copy boot' do
    command 'rsync -xa --delete ./ /tftpboot'
    cwd '/mnt/rpi/boot'
end

execute 'copy rfs' do
    command 'rsync -xa --delete ./ /nfs/rpi'
    cwd '/mnt/rpi/rfs'
end

#   [TODO] Run this always
mount 'umount rpi boot partition' do
    #   Device is a must here
    device '/home/vagrant/rpi/2019-07-10-raspbian-buster-lite.img'
    mount_point '/mnt/rpi/boot'
    action :umount
end

#   [TODO] Run this always
mount 'umount rpi rfs partition' do
    #   Device is a must here
    device '/home/vagrant/rpi/2019-07-10-raspbian-buster-lite.img'
    mount_point '/mnt/rpi/rfs'
    action :umount
end


#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   [TODO] RPi image - Update configuration

cookbook_file '/tftpboot/config.txt' do
    source '/tftpboot/config.txt'
end

cookbook_file '/tftpboot/cmdline.txt' do
    source '/tftpboot/cmdline.txt'
end

cookbook_file '/nfs/rpi/etc/fstab' do
    source '/nfs/rpi/etc/fstab'
end

