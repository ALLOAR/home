#/usr/env/bin bash
set -e
free_disksize_raw=$(parted /dev/$DISK unit GiB print free | grep "Free Space" | tail -n1 | awk '{print $3}')
free_disksize=${free_disksize_raw%GiB}

efi_size=$(lsblk -nb -o NAME,FSTYPE,FSSIZE,FSAVAIL /dev/$DISK | awk '$2 == "vfat" {print $4}')
efi_size_echo=$(lsblk -n -o NAME,FSTYPE,FSSIZE,FSAVAIL /dev/$DISK | awk '$2 == "vfat" {print $4}'

function last_part() {
	echo $(( $(lsblk | grep $DISK | wc -l) - 1 ))
}
function swap_part() {
	echo $(( $(lsblk | grep $DISK | wc -l) - 2 ))
}
# usr/env/bin bash

function clear_disk() {
        local efi_end_raw
        local efi_start
        local efi_end
        local swap_start
        local swap_end
        local last_partition
        local swap_partition
        local p=""

	local free_disksize_raw
	local efi_size

	free_disksize_raw=$(parted /dev/$DISK unit GiB print free | grep "Free Space" | tail -n1 | awk '{print $3}')
	free_disksize=${free_disksize_raw%GiB}
	efi_size=$(lsblk -nb -o NAME,FSTYPE,FSSIZE,FSAVAIL /dev/$DISK | awk '$2 == "vfat" {print $4}')


	read -p " --- we will erase all data yes/no (handwrite) --- \n --- " erase

	[[ "$erase" == "no" ]] && echo " --- so try yourself --- " & exit 1

        efi_start="1MiB"
	read -p " --- how mush space you wanna for efi? (recomendet >2)--- \n --- you write only numer this will be in GiB --- \n --- " efi_end_raw
        efi_end=${efi_end_raw}GiB

	last_partition=$(last_part)
        (( swap_partition=$(lsblk | grep $DISK | wc -l) - 2 ))

        [[ "$DISK" == nvme* ]] && p="p"

        parted /dev/$DISK -- mkpart ESP fat32 ${efi_start} ${efi_end}
        efi_num=$(( $(lsblk | grep $DISK | wc -l) - 1) ))
	parted -- set ${efi_num} boot on
        mkfs.fat -F32 /dev/${DISK}${p}${efi_num}


        if [[ "${swap}" -ne 0 ]]; then
                swap_start=${efi_end}
                swap_end=$(( ${swap} + ${efi_end_raw} ))
                parted /dev/$DISK -- mkpart linux-swap ${swap_start} ${swap_end}
                parted /dev/$DISK -- mkpart primary ext4 ${swap_end} 100%
	        last_partition=$(last_part)
                mkswap /dev/${DISK}${p}${last_partition}
	        last_partition=$(last_part)
                mkfs.ext4 /dev/${DISK}${p}${last_partition}
		swap_partition=$(swap_part)
		mkswap /dev/${DISK}${p}${swap_partition}
                mount /dev/${DISK}${p}${last_partition} /mnt
                mkdir -p /mnt/boot
                mount /dev/${DISK}${p}${efi_num} /mnt/boot

        elif [[ "{$swap}"' -eq 0 ]]; then
                parted /dev/$DISK -- mkpart primary ext4 ${efi_end} 100%
	        last_partition=$(last_part)
                mkfs.ext4 /dev/${DISK}${p}${last_partition}
                mount /dev/${DISK}${p}${last_partition} /mnt
                mkdir -p /mnt/boot
                mount /dev/${DISK}${p}${efi_num} /mnt/boot
                echo " --- swap will not created --- "
        fi
}

function dualboot() {
        echo " --- disk partitioning ---"
	local efi_start_raw
	local efi_end_raw
	local efi_start
	local efi_end
	local swap_start
	local swap_end
	local last_partition
	local swap_partition
        local p=""


        read -p " --- how mush space you wanna for efi? (recomendet >2)--- \n --- you write only numer this will be in GiB --- \n --- " efi_end_raw_raw

	efi_start_raw=${free_disksize}
	(( efi_end_raw=${efi_start_raw} + ${efi_end_raw_raw} ))
	efi_start=${efi_start_raw}GiB
	efi_end=${efi_end_raw}GiB
	(( last_partition=$(lsblk | grep $DISK | wc -l) - 1 ))
	(( swap_partition=$(lsblk | grep $DISK | wc -l) - 2 ))

	[[ "$DISK" == nvme* ]] && p="p"

	if [[ "$efi_size" -gt 2357166592 ]]; then
                echo " --- we have enought place for native dualboot --- "

        	parted /dev/$DISK -- set 1 boot on
        else
               echo " --- we must create new boot partition --- "
		parted /dev/$DISK -- mkpart ESP fat32 ${efi_start} ${efi_end}
		efi_num=$(( $(lsblk | grep $DISK | wc -l) - 1 ))
		parted -- set ${efi_num} boot on
		mkfs.fat -F32 /dev/${DISK}${p}${efi_num}
        fi

	if [[ "${swap}" -ne 0 ]]; then
        	swap_start=${efi_end}
                swap_end=$(( ${swap} + ${efi_end_raw} ))
		parted /dev/$DISK -- mkpart linux-swap ${swap_start} ${swap_end}
		parted /dev/$DISK -- mkpart primary ext4 ${swap_end} 100%
		mkswap /dev/${DISK}${p}${swap_partition}
		mkfs.ext4 /dev/${DISK}${p}${last_partition}
		mount /dev/${DISK}${p}${last_partition} /mnt
		mkdir -p /mnt/boot
		mount /dev/${DISK}${p}${efi_num} /mnt/boot

        elif [[ "${swap}"' -eq 0 ]]; then
                parted /dev/$DISK -- mkpart primary ext4 ${efi_end} 100%
		mkfs.ext4 /dev/${DISK}${p}${last_partition}
		mount /dev/${DISK}${p}${last_partition} /mnt
		mkdir -p /mnt/boot
		mount /dev/${DISK}${p}${efi_num} /mnt/boot
                echo " --- swap will not created --- "
	fi


}

lsblk -f
read -p " --- what disk you will use? (1/2/3...) --- \n --- " disk_choise
DISK=$(lsblk -dno NAME | awk -v n="$disk_choise" 'NR==n')
echo " --- you selected $DISK --- "

(( efi_partition_size_raw = free_disksize + 1 ))

parted_start=${free_disksize}GiB
echo " --- parted_start - ${parted_start}"

echo "$efi_size_echo"
read -p " --- do you wanna dual boot with windows? yes/no (handwrite) --- \n --- " dualboot
read -p " -- how mush swap you want 0-20 (in GiB) --- \n --- write only number --- \n --- if you dont want swap, then press 0 \n --- " swap
echo "$free_disksize_raw"
if [[ "$free_disksize" -lt 10 ]]; then
	read -p " --- you have less than 10GiB free space, you sure to continue installing? yes/no (handwriting) --- \n --- " free_space
	if [[ "$free_space" -eq "yes" ]]; then
		echo " -- ok, good luck ))) --- "
	elif [[ "$free_space" -eq "no" ]]; then
		echo " --- ok we stop and wait until you create mote space --- "
		exit 1
	fi
fi

if [[ "$dualboot" == "yes" ]]; then
	echo " --- you selected dualboot --- "
	#dualboot()
elif [[ "$dualboot" == "no" ]]; then
	echo " --- so we will erase all disk --- \n if you dont want erase disk write \"no\" --- \n --- " erase
	[[ "$erase" == "no" ]] && exit 1
	#clear_disk()
else
	echo " --- you writed wrong --- \n --- example input \"yes\" or \"no\" "
fi
