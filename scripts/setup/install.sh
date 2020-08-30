#!/bin/bash

# internet connection and time
dhcpcd
ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` > /dev/null && echo "internet connection ok" || `echo "no internet connection"; exit 1`
timedatectl set-ntp true

# partitioning
lsblk
read -p "Path of device to partition (eg. /dev/sda): " device
fdisk $device

# creating filesystems
mkfs.fat -F32 "$device"1
mkswap "$device"2
mkfs.ext4 "$device"3

# mounting
mount "$device"3 /mnt
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount "$device"1 /mnt/boot/efi
swapon "$device"2

# base install
pacstrap /mnt base linux linux-firmware nvim

# filesystem table
genfstab -U /mnt >> /mnt/etc/fstab

# change root
arch-chroot /mnt

# timezone and local
ln -sf /usr/share/zoneinfo/Europe/Budapest /etc/localtime

# hardware clock
hwclock --systohc

# generate locale
echo "ech_US.UTF-8" > /etc/locale.gen
locale-gen

# set language
echo LANG=en_US.UTF-8 >> /etc/locale.conf

# network
read -p "Chose a hostname: " hostname
echo $hostname >> /etc/hostname
echo "127.0.0.1   localhost
::1         localhost
127.0.1.1   $hostname.localdomain    $hostname"

# installing some packages
pacman -S grub efibootmgr networkmanager network-manager-applet wireless_tools wpa_supplicant dhcpcd os-prober mtools dosfstools base-devel linux-headers

# grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# account settings
passwd
read -p "Chose a username: " username
useradd -m $username
passwd $username
usermod -aG wheel,audio,video,optical,storage,libvirt $username
EDITOR=nvim visudo
exit
umount -a
echo "Done. Reboot your computer!"

