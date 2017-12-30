#!/bin/bash

## CONFIGURE ARCH LINUX AFTER FRESH INSTALL
# some standard stuff
pacman -S python wget

# install some stuff used by me often
pacman -S sudo
pacman -S vim
pacman -S git
#pacman -S openssh

# download some fonts
#pacman -S terminus-font
#pacman -S 

# install some useful stuff
#pacman -S net-tools pkgfile base-devel

# install graphics driver (be careful!)
#pacman -S xf86-video-vesa

# install xorg
#pacman -S xorg-server xorg-server-utils xorg-apps
#pacman -S terminus-font ttf-dejavu ttf-droid ttf-inconsolata

# install xfce desktop environment
#pacman -S xfce4 xfce4-goodies
#startxfce4

# some gui stuff
#pacman -S xarchiver gthumb gvim gimp

# INSTALL BROWSERS
# install firefox
#pacman -S firefox
#pacman -S w3m
#pacman -S elinks


# VIRTUAL BOX ADDONS
#pacman -S virtualbox-guest-utils
#pacman -S virtualbox-guest-modules
#pacman -S virtualbox-guest-modules-lts
#pacman -S virtualbox-guest-dkms
#echo vboxguest > /etc/modules-load.d/virtualbox.conf
#echo vboxsf >> /etc/modules-load.d/virtualbox.conf
#echo vboxvideo >> /etc/modules-load.d/virtualbox.conf

# run a full system upgrade
pacman -Syu

