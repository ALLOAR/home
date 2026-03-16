#usr/env/bin bash
echo Hello world
 parted -m /dev/sda unit GiB print free | awk '{printf "%d:%s\n", ++n,$0}' | awk -F: '$1>3 {$1=$1-3; printf "%s\n", $0}'
Показывает свободное место и еще пиздато пронумеровано
