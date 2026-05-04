#usr/env/bin bash
parted -m /dev/nvme0n1 unit GiB print free | awk '{printf "%d:%s\n", ++n,$0}' | awk -F: '$1>3 {$1=$1-3; printf "%s\n", $0}'
