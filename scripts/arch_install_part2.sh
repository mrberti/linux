# set timezone
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock --systohc

# Set locale
nano /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
echo 'KEYMAP=de-latin1-nodeadkeys' > /etc/vconsole.conf
echo 'FONT=Lat2-Terminus16' >> /etc/vconsole.conf
echo 'simon-arch' > /etc/hostname
echo "127.0.1.1\tsimon-arch.localdomain\tsimon-arch" >> /etc/hosts

# Enable DHCP
systemctl enable dhcpcd

## CONFIGURE BOOTLOADER ##
# install grub
pacman -S grub os-prober

grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

## RETURN TO LIVE SYSTEM
exit

reboot