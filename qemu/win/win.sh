#!/usr/bin/env bash
qemu-system-x86_64 \
  -enable-kvm \
  -cpu host \
  -smp 2 \
  -m 4096 \
  -machine q35 \
  -boot order=c \
  -drive file=./disk.qcow2,format=qcow2 \
  -cdrom ./win_pl_10.iso* \
  -usb -device usb-host,vendorid=0x1d6b,productid=0x0003
