#!/bin/sh
cd $(dirname "$0")
sudo \
qemu-system-x86_64 \
    -smp 2 \
    -m 128 \
    -nographic \
    -kernel bzImage \
    -initrd initramfs.cpio.xz \
    -append "console=ttyS0 batmantestbedid=${ID:=1}" \
    -enable-kvm \
    -netdev tap,id=vmnic,ifname=battest${ID:=1},script=no,downscript=no \
    -device virtio-net,netdev=vmnic,mac=ca:fe:42:00:00:$(printf "%02x" ${ID:=1}) \
    -object rng-random,filename=/dev/random,id=rng0
