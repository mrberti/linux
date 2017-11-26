#!/bin/bash

## CONFIGURE USING LIVE IMAGE ##
# set german keyboard layout
loadkeys de-latin-nodeadkeys

# update the system clock
timedatectl set-net true

# partition the disk
cfdisk

mkfs.ext4 /dev/sda1

mount /dev/sda1 /mnt

# edit mirrorlist so that closest server is at top
vim /etc/pacman.d/mirrorlist

# bootstrap arch linux
pacstrap /mnt base base-devel

# Generate fstab file
genfstab -U /mnt >> /mnt/etc/fstab

wget http://raw.githubusercontent.com/mrberti/linux/master/scripts/arch_install_part2.sh /mnt/root/arch_install_part2.sh

## CONFIGURE USING NEW FILESYSTEM
# Change into the new system as root
arch-chroot /mnt
