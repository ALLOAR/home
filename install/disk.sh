#/usr/bin/env bash
set -ex

# Функция выбора диска, отображает пользователю все диски и раздели после чего
# После чего еще раз показывает только диски пронумерованые с помощью awk
# Пользователь вводит номер которым подписан его диск и функция запоминает это
# Формат - nvme0n1 or sda
function select_disk() {
lsblk -f
p=""
echo -e " --- \n --- \n"
lsblk -dnf | awk '{print FNR, $1}'
read -ep " --- what disk you will use? (1/2/3...) --- " disk_choise
DISK=$(lsblk -dnf | awk -v n="${disk_choise}" 'NR==n {print $1}')
echo " --- you selected "${DISK}" --- "
[[ "${DISK}" == nvme0n1 ]] && p="p" || true
[[ "${DISK}" == loop0 ]] && p="p" || true

}

# Функция запоминаея количества свободного места на диске
# Нуждаеться в доработке ибо свободных мест может быть несколько и пользователю нужно дать возможность выбора
# Формат - 100 (единици в GiB)
# НЕ Нуждаеться в доработке - я посчитал что подобный функционал должен быть реализован в других функциях
function free_disksize() {
  free_disksize_raw=$(parted -m /dev/$DISK unit GiB print free | awk -F: '$5=="free;" && $4!="0.00GiB" {print $4}')
  free_disksize=${free_disksize_raw%GiB}
	if [[ "${free_disksize}" -lt "15" ]]; then
		low_space
	fi
}

# Функция проверки пустой диск или же нет сравнивает количество строк с диском 
# И если диск пуст то будет лишь 1 строка - его название без разделов
# Диск чиститься при помощи пересоздание таблици разделов в parted 
function if_disk_clear() {
  partition_count=$(lsblk | grep $DISK | wc -l)
  if [[ "${partition_count}" == 1 ]]; then
	disk_clear="0"
  else
	disk_clear="1"
  fi
}

# Функция удаляет разделы диска, работает просто, нечего говорить
function delete_partition() {
	lsblk | grep "${DISK}"
	read -p $' --- what partition you wanna delete 1/2/3... --- ' delete_partition
	parted /dev/"${DISK}" rm "${delete_partition}"
	echo " --- succed --- \n"
}

# Функция удаляет всю  информацию в диске по ср
# едство пересоздания таблици разделов
function erase_disk() {
	wipefs --all /dev/"$DISK"
	parted /dev/"${DISK}" mklabel gpt
}

# функция выбирает на какой разддел vfat (boot) будет установлена система 
# Сначала проверяет количество таких разделов, если один то функция его запоминает 
# Если разделов больше 1 то функция справшивает на какой из них будет установленна система 
# Трогать первую строку с переменной vfat не стоит, ибо она пусть и тупо однако считает общее количество  vfat разделов, в пользователь можно установть
# свою систему на раздел другого диска (пусть это и не всегда хорошо, свои применения имеет)
# НЕ Нуждаеться в доработке, все в целом то работает хорошо, vfat_end необходим для создания других разделов если диск пуст или сразу после vfat есть пустое место
function vfat() { 
	vfat=$(lsblk -n -o FSTYPE | grep vfat | awk '{print $1}' | awk '{print NR}') | xargs
	if [[ "${vfat}" -eq 1 ]]; then  
		lsblk -f
		read -p $' --- You have vfat partition, do you want install you OS on that (recomendet) --- \n  --- (handwritin) yes/no ---  ' vfat_choise
		if [[ "${vfat_choise}" == "no" ]]; then
			vfat_partition="new"
			return
		else
		vfat_partition=$(lsblk -n -l -o NAME,FSTYPE,TYPE | awk '$3=="part" && $2=="vfat" {print $1}') | xargs # - output like nvme0n1p1 
		fi
	fi
	if [[ "${vfat}" -gt 1 ]]; then
		lsblk -n -l -o NAME,FSTYPE,TYPE | awk '$3=="part" && $2=="vfat" {print ++n,$1,$2}'	| xargs
		read -p $' --- you have more than 1 vfat on which of them you want install OS 1/2/3... --- ' vfat_partition_choise
		vfat_partition=$(lsblk -n -l -o NAME,FSTYPE,TYPE | awk '$3=="part" && $2=="vfat" {print ++n,$1,$2}' | awk '$1="${vfat_partition_choise}" {print $2}') | xargs
	fi
	vfat_end=$(parted -m /dev/"${vfat_partition}" print | awk -F: '$1=="1" {print $3}') | xargs
}

# Функция проверят достаточно ли места на диске
# Если места недостаточно то предлагает один из 3 вариантов
# Удалить раздел, очистить полностью диск, выбрать другой диск 
# НЕ Нуждается в доработке
function low_space() {
	read -p " --- You dont have enought place for instalation (less than 15GiB) you sure to continue? \n --- yes/no (handwriting) --- " low_space  
	if [[ "${low_space}" == "yes" ]]; then echo " --- ok, good luck) --- ";
	elif [[ "${low_space}" == "no" ]]; then
		echo " --- we can delete partition, erase entire disk or change disk --- "
		read -p " --- 1 - delete partition --- \n --- 2 - erase entire disk --- \n --- 3 - change disk --- \n --- (write 1/2/3) --- " new_begining
		if [[ "${new_begining}" -eq 1 ]]; then delete_partition disk_space; fi
		if [[ "${new_begining}" -eq 2 ]]; then erase_disk disk_space; fi
		if [[ "${new_begining}" -eq 3 ]]; then select_disk disk_space; fi
	fi
}

function clear_install() {

  start_disk=$last_sector_raw
  end_disk="100%"
  echo $start_disk $end_disk 
  echo "[1/5] Разметка /dev/$DISK..."
  # Создание таблицы разделов GPT
  parted /dev/$DISK mklabel gpt
  # EFI-раздел (ESP)
  parted /dev/$DISK mkpart ESP fat32 "$start_disk" 1024MiB
  parted /dev/$DISK set 1 boot on
  # Основной раздел ext4
  parted /dev/$DISK mkpart primary ext4 1024MiB "$end_disk"
  echo "[2/5] Форматирование разделов..."
  # Форматирование EFI
  mkfs.fat -F32 -n boot /dev/${DISK}${p}1
  # Форматирование ext4
  mkfs.ext4 -L nixos /dev/${DISK}${p}2

  echo "[3.5/5] Монтирование разделов..."
  mount /dev/${DISK}${p}$(( first_partition + 1 )) /mnt
  mkdir -p /mnt/boot
  mount /dev/${DISK}${p}"$first_partition" /mnt/boot
}

function define_disk_border() {
	first_partition=$(( $(lsblk -o NAME | grep sda | wc -l) - 1 ))

	last_sector_raw=$(parted -m /dev/"$DISK" unit MiB print free | tail -n 1 | awk -F: '{print $3}')
	echo $last_sector_raw
	last_sector=${last_sector_raw%MiB}

	read -p " --- How mush spcae you want for you system? --- \n --- (write like 20GiB or 40000MiB) --- " end_disk

}



# Черновой вариант функции для boot на чистом диске 
# Нуждается в доработке
function solo_boot() {
	select_disk
	free_disksize
	if_disk_clear
	echo "starting installation"
	if [[ ${disk_clear} = "0" ]]; then
		last_sector_raw="1MiB"
		clear_install
	else
		read -p $" --- you disk have some partitions, you wanna install near other partitions? --- \n --- yes/no (handwrite) --- " near_install

		if [[ "${near_install}" == "yes" ]]; then
			# Here i will install system just on free space
			define_disk_border
			clear_install

			
		else
			echo " --- so me should remove some partitions or entire disk ---"
			read -p $" --- remove partition - 1, erase disk - 2 --- " decidion
		fi
	fi
}

solo_boot















