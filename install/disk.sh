#/usr/bin/env bash
set -e
function select_disk() {
lsblk -f
p=""
echo -e " --- \n --- \n"
lsblk -dnf | awk '{print FNR, $1}'
read -ep " --- what disk you will use? (1/2/3...) --- " disk_choise
DISK=$(lsblk -dnf | awk -v n="${disk_choise}" 'NR==n')
echo " --- you selected "${DISK}" --- "
[[ "${DISK}" == nvme0n1 ]] && p="p"
}

function free_disksize() {
  free_disksize_raw=$(parted -m /dev/$DISK unit GiB print free | awk -F: '$5=="free;" && $4!="0.00GiB" {print $4}';)
  free_disksize=${free_disksize_raw%GiB}
}

function if_disk_clear() {
  partition_count=$(lsblk | grep $DISK | wc -l)
  if [[ "${partition_count}" == 2 ]]; then
	disk_clear="0"
  else
	disk_clear="1"
  fi
}
function delete_partition() {
	lsblk | grep "${DISK}"
	read -p $' --- what partition you wanna delete 1/2/3... --- ' delete_partition
	parted /dev/"${DISK}" rm "${delete_partition}"
	echo " --- succed --- "
}
function erase_disk() {
	parted /dev/"${DISK}" mklabel gpt
}
function vfat() {
	vfat=$(lsblk -n -o FSTYPE | grep vfat | awk '{print $1}' | awk '{print NR}')
	if [[ "${vfat}" -eq 1 ]]; then  
		lsblk -f
		read -p $' --- You have vfat partition, do you want install you OS on one of them? (recomendet) --- \n  --- (handwritin) yes/no ---  ' vfat_choise
		vfat_partition=$(lsblk -n -l -o NAME,FSTYPE,TYPE | awk '$3=="part" && $2=="vfat" {print $1}')
	fi
	if [[ "${vfat}" -gt 1 ]]; then
		lsblk -n -l -o NAME,FSTYPE,TYPE | awk '$3=="part" && $2=="vfat" {print ++n,$1,$2}'	
		read -p $' --- you have more than 1 vfat on which of them you want install OS 1/2/3... --- ' vfat_partition_choise
		vfat_partition=$(lsblk -n -l -o NAME,FSTYPE,TYPE | awk '$3=="part" && $2=="vfat" {print ++n,$1,$2}' | awk '$1="${vfat_partition_choise}" {print $2}')
	fi
	vfat_end=$(parted -m /dev/"${vfat_partition}" print | awk -F: '$1=="1" {print $3}')
}
function low_space() {
	read -p " --- You dont have enought place for instalation (less than 15GiB) you sure to continue? \n --- yes/no (handwriting) --- " low_space  
	if [[ "${low_space}" == "yes" ]]; then echo " --- ok, good luck) --- "; fi
	elif [[ "${low_space}" == "no" ]]; then
		echo " --- we can delete partition erase entire disk or change disk --- "
		read -p " --- 1 - delete partition --- \n --- 2 - erase entire disk --- \n --- 3 - change disk --- \n (write 1/2/3) --- " new_begining
		if [[ "${new_begining}" -eq 1 ]]; then delete_partition; fi
		if [[ "${new_begining}" -eq 2 ]]; then erase_disk; fi
		if [[ "${new_begining}" -eq 3 ]]; then select_disk disk_space; fi
	fi
}
function disk_space() {
	if [[ "${free_disksize}"-gt 15 ]]; then echo " --- we have enought place for instaling --- ";
	else low_space; fi
}
function solo_boot() {
	vfat
	disk_end_start=$(parted -m /dev/"${DISK}" print | awk 'END {print}' | awk -F: '{print $3}')
	if [[ "${vfat_choise}" == "yes" ]]; then
		parted /dev/"${DISK}" mkpart "${disk_end_start}" 100%
		disk_end_end=$(parted -m /dev/"${DISK}" print | awk 'END {print}' | awk -F: '{print $3}')
		mkfs.ext4 /dev/"${DISK}" 
# Необходимо решить проблему возможности алокации разделов, когда свободное место окружено двумя другими разделами, или же свободных мест несколько

 
}

















