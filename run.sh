#/bin/bash
make all
qemu-system-i386 -drive format=raw,file=bin/boot.bin
