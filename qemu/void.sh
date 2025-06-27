qemu-system-x86_64 \
  -enable-kvm \
  -cpu host \
  -smp 2 \
  -m 4096 \
  -drive file=void.qcow2,format=qcow2 \
  -boot c \
  -vga virtio -device virtio-gpu-pci
