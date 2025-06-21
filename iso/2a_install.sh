#!/bin/bash
echo "arch" > /etc/hostname
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
echo "Dont forgot locales"
passwd
