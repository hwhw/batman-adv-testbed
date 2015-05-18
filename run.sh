#!/bin/bash
cd $(dirname "$0")

if [ -n "$1" ]; then
    if [ -r "instances/$1/conf.sh" ]; then
        source "instances/$1/conf.sh"
    fi
    if [ -d "instances/$1/overlay" ]; then
        OVERLAY="instances/$1/overlay"
    fi
    if [ -r "instances/$1/bzImage${VERSION:+.$VERSION}" ]; then
        KERNEL="instances/$1/bzImage${VERSION:+.$VERSION}"
    fi
    if [ -r "instances/$1/rootfs.squashfs${VERSION:+.$VERSION}" ]; then
        ROOTDEV="instances/$1/rootfs.squashfs${VERSION:+.$VERSION}"
    fi
    shift 1
fi

FLAGS="$FLAGS init=/init root=/dev/vda console=ttyS0"
FLAGS="$FLAGS bat_id=${ID:=1}"
FLAGS="$FLAGS ${BAT_HOSTNAME:+ bat_hostname=$BAT_HOSTNAME}"
FLAGS="$FLAGS ${ROOTKEY:+ bat_rootkey=$(echo $ROOTKEY|sed 's/ /,/'|sed 's/ .*//')}"

exec qemu-system-x86_64 \
    -smp ${CPUS:=1} \
    -m ${MEM:=64} \
    -nographic \
    -nodefaults \
    -enable-kvm \
    -kernel ${KERNEL:=bzImage} \
    -append "$FLAGS" \
    -drive file=${ROOTDEV:=rootfs.squashfs},if=virtio,format=raw,readonly \
    -object rng-random,filename=/dev/random,id=rng0 \
    ${OVERLAY:+-virtfs local,path="$OVERLAY",security_model=none,mount_tag=overlay} \
    -serial ${SERIAL:-telnet:localhost:$((55000+${ID:=1})),server,nowait} \
    -balloon virtio \
    $QEMU_FLAGS \
    $@
