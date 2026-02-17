#/usr/bin/env bash
set -e
lsblk -f
echo -e " --- \n --- \n"
lsblk -dnf | awk '{print FNR, $1}'
read -ep " --- what disk you will use? (1/2/3...) --- " disk_choise
DISK=$(lsblk -dnf | awk -v n="$disk_choise" 'NR==n')
echo " --- you selected $DISK --- "

function free_disksize() {
  free_disksize=$(parted -m /dev/$DISK unit GiB print free | awk -F: '$5=="free;" && $4!="0.00GiB" {print $4}';)
}

function if_disk_clear() {
  partition_count=$(sblk | grep $DISK | wc -l)
  if [[ "$partition_count" == 2 ]]; then
	disk_clear="0"
  else
	disk_clear="1"
  fi
}

function solo_boot() {
  if [[ $free_disksize -gt ""
}
