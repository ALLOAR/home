#!/bin/bash
echo "arch" > /etc/hostname
pacman -S --noconfirm grub efibootmgr
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
echo "Dont forgot locales"
echo "root:root" | chpasswd
pacman -S --noconfirm sudo
echo " system installed reboot after 3 sec "
sleep 3
exit
reboot
