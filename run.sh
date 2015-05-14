#!/bin/sh
cd $(dirname "$0")
source ./config

qemu-system-x86_64 \
    -smp 2 \
    -m 128 \
    -nographic \
    -kernel bzImage \
    -append "console=ttyS0" \
    -enable-kvm \
    -netdev user,id=vmnic,hostname=batmantestbed1 \
    -device virtio-net,netdev=vmnic \
    -object rng-random,filename=/dev/random,id=rng0
