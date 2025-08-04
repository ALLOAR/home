#!/usr/bin/env bash
qemu-system-x86_64 \
  -enable-kvm \
  -cpu host \
  -smp 2 \
  -m 4096 \
  -machine q35 \
  -boot order=c \
  -drive file=../disk/win.qcow2,format=qcow2 \
  -cdrom ../iso/Windows_10.iso* \

