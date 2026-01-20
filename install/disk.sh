#/usr/env/bin bash
set -e
function clean_disk_no_swap() {
	echo " --- disk partitioning ---"
	parted /dev/$DISK -- mkalbel gpt
	parted /dev/$DiSK -- mkpart ESP fat32 1MiB 5GiB
	parted /dev/$DISK -- set 1 boot on
	parted /dev/$DISK -- mkpart primary ext4 5GiB 100%
	echo "formatting partitions"
	if [[ "$DISK" -eq "nvme0n1" ]]; then
		mkfs.fat -F32 -n boot /dev/${DISK}p1
		mkfs.ext4 /dev/${DISK}p2
		mount ${DISK}p2 /mnt
		mkdir -p /mnt/boot
		mount ${DISK}p1 /mnt/boot
	elif [[ "$DISK" -eq "sda" ]]; then
		mkfs.fat -F32 -n boot /dev/${DISK}1
                mkfs.ext4 /dev/${DISK}2
		mount /dev/${DISK}2 /mnt
		mkdir -p /mnt/boot
		mount /dev/${DISK}1 /mnt/boot
	else
		echo " --- I dont know what disk you use (... --- "
		exit 1
	fi
}
function clean_disk_with_swap() {
	echo " --- disk partitioning ---"
        parted /dev/$DISK -- mkalbel gpt
        parted /dev/$DiSK -- mkpart ESP fat32 1MiB 5GiB
        parted /dev/$DISK -- set 1 boot on
	parted /dev/$DISK -- mkpart linux-swap 5GiB 8GiB
        parted /dev/$DISK -- mkpart primary ext4 8GiB 100%
        echo "formatting partitions"
        if [[ "$DISK" -eq "nvme0n1" ]]; then
                mkfs.fat -F32 -n boot /dev/${DISK}p1
		mkswap -L swap /dev/${DISK}p2
                mkfs.ext4 /dev/${DISK}p3
		swapon /dev/${DISK}p2
		mount ${DISK}p3 /mnt
		mkdir -p /mnt/boot
		mount ${DISK}p1 /mnt/boot
        elif [[ "$DISK" -eq "sda" ]]; then
                mkfs.fat -F32 -n boot /dev/${DISK}1
                mkswap -L swap /dev/${DISK}2
		mkfs.ext4 /dev/${DISK}3
		swapon /dev/${DISK}2
		mount /dev/${DISK}3 /mnt
		mkdir -p /mnt/boot
		mount /dev/${DISK}1 /mnt/boot
        else
                echo " --- I dont know what disk you use (... --- "
                exit 1
        fi
}
function dualboot_win_efi_no_swap () {
	echo " --- disk partitioning ---"
	count=$(lsblk | grep $DISK | wc -l)
	b=1
	(( primary_partition = count - b))
	parted_start=${free_diskspace}GiB
        parted /dev/$DISK -- mkalbel gpt
        parted /dev/$DISK -- mkpart primary ext4 ${parted_start} 100%
        echo "formatting partitions"
        if [[ "$DISK" -eq "nvme0n1" ]]; then
                mkfs.ext4 /dev/${DISK}p${primary_partition}
                mount ${DISK}p${primary_partition} /mnt
                mkdir -p /mnt/boot
                mount ${DISK}p1 /mnt/boot
        elif [[ "$DISK" -eq "sda" ]]; then
		mkfs.ext4 /dev/${DISK}${primary_partition}
                mount ${DISK}${primary_partition} /mnt
                mkdir -p /mnt/boot
                mount ${DISK}1 /mnt/boot
	else
                echo " --- I dont know what disk you use (... --- "
                exit 1
        fi
}

lsblk
read -p " --- what disk you will use? (1/2/3...) --- " disk_choise
DISK=$(lsblk -dno NAME | awk -v n="$disk_choise" 'NR==n')
echo " --- you selected $DISK --- "
free_disksize_raw=$(sudo parted /dev/$DISK unit GiB print free | grep "Free Space" | tail -n1 | awk '{print $3}')
free_disksize=${free_disksize_raw%GiB}
efi_size=$(lsblk -nb -o NAME,FSTYPE,FSSIZE,FSAVAIL /dev/$DISK | awk '$2 == "vfat" {print $4}')
efi_size_echo=$(lsblk -n -o NAME,FSTYPE,FSSIZE,FSAVAIL /dev/$DISK | awk '$2 == "vfat" {print $4}')
echo "$efi_size_echo"
read -p " --- do you wanna dual boot with windows? yes/no (handwrite) --- " dualboot
echo "$free_disksize_raw"
if [[ "$free_disksize" -lt 10 ]]; then
	read -p " --- you have less than 10GiB free space, you sure to continue installing? yes/no (handwriting) " free_space
	if [[ "$free_space" -eq "yes" ]]; then
		echo " -- ok, good luck ))) --- "
	elif [[ "$free_space" -eq "no" ]]; then
		echo " --- ok we stop and wait until you create mote space --- "
		exit 1
	fi
fi

if [[ "dualboot" -eq "yes" ]]; then
	read -p " --- windows already installed (on this disk)? yes/no (handwrite) --- " win
	if [[ "$win" -eq "yes" ]]; then
		echo " --- you must have unallocated space --- "
		if [[ "$efi_size" -gt 2357166592 ]]; then
			echo " --- we have enought place for native dualboot --- "
		else
			echo " --- we must create new boot partition --- "
		fi
	elif [[ "$win" -eq "no" ]]; then
		echo " --- so we erase all disk (print \"no\" if you dont want)" erase
			if [[ "$erase" -eq "no" ]]; then
				echo " --- so we stop installing --- "
				exit 1
			else
				echo " --- erasing disk ... --- "
			fi
	fi

fi
