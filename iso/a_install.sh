#!/bin/bash
set -e
lsblk
read -p " --- if you use sata interface just press ENTER if nvme sdd pres 'p') --- " p
echo "[1/5] Разметка $DISK..."
DISK="/dev/sda"  # ❗ Измени только это

echo "[1/5] Разметка $DISK..."
# Создание таблицы разделов GPT
parted $DISK -- mklabel gpt
# EFI-раздел (ESP)
parted $DISK -- mkpart ESP fat32 1MiB 512MiB
parted $DISK -- set 1 boot on
# Swap-раздел — 8 ГБ
parted $DISK -- mkpart primary linux-swap 512MiB 8704MiB
# Основной раздел ext4
parted $DISK -- mkpart primary ext4 8704MiB 100%
echo "[2/5] Форматирование разделов..."
# Форматирование EFI
mkfs.fat -F32 -n boot ${DISK}${p}1
# Форматирование swap
mkswap -L swap ${DISK}${p}2
# Форматирование ext4
mkfs.ext4 -L nixos ${DISK}${p}3
echo "[3/5] Активация swap..."
swapon ${DISK}${p}2

echo "[3.5/5] Монтирование разделов..."
mount ${DISK}${p}3 /mnt
mkdir -p /mnt/boot
mount ${DISK}${p}1 /mnt/boot

pacstrap -K /mnt base linux linux-firmware nano networkmanager
genfstab -U /mnt >> /mnt/etc/fstab

curl https://raw.githubusercontent.com/ALLOAR/home/refs/heads/main/iso/2a_install.sh -o 2install.sh
cp 2install.sh /mnt/root
arch-chroot /mnt /root/2install.sh
