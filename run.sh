#!/bin/bash
cd $(dirname "$0")

qemu-system-x86_64 \
    -smp 2 \
    -m 64 \
    -nographic \
    -nodefaults \
    -enable-kvm \
    -kernel bzImage \
    -append "root=/dev/vda console=ttyS0 batmantestbedid=${ID:=1}" \
    -net nic,vlan=0,model=virtio,macaddr=ca:fe:42:00:00:$(printf "%02x" ${ID:=1}) \
    -net bridge,vlan=0,br=batmantestbr0 \
    -object rng-random,filename=/dev/random,id=rng0 \
    -drive file=rootfs.squashfs,if=virtio,format=raw,readonly \
    ${OVERLAY:+-virtfs local,path="$OVERLAY",security_model=none,mount_tag=overlay} \
    -serial ${SERIAL:-telnet:localhost:$((55000+${ID:=1})),server,nowait} \
    $@
