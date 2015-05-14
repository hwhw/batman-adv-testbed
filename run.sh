#!/bin/bash
cd $(dirname "$0")
ID=$1
qemu-system-x86_64 \
    -smp 2 \
    -m 64 \
    -nographic \
    -kernel bzImage \
    -initrd initramfs.cpio.xz \
    -append "console=ttyS0 batmantestbedid=${ID:=1}" \
    -enable-kvm \
    -netdev tap,id=vmnic,ifname=battest${ID:=1},script=no,downscript=no \
    -device virtio-net,netdev=vmnic,mac=ca:fe:42:00:00:$(printf "%02x" ${ID:=1}) \
    -serial telnet:localhost:$((55000+${ID:=1})),server,nowait \
    -object rng-random,filename=/dev/random,id=rng0 \
    -nodefaults \
    -daemonize

if [ ! -d /sys/class/net/battestbridge ]; then
    brctl addbr battestbridge
    ip a add 10.111.111.254/24 dev battestbridge
    ip l set dev battestbridge up
fi

brctl addif battestbridge battest${ID:=1}
ip l set dev battest${ID:=1} up
