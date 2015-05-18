#!/bin/bash
cd $(dirname "$0")

if [ -n "$1" -a -d "instances/$1" ]; then
    cp bzImage "instances/$1/bzImage${2:+.$2}"
    cp rootfs.squashfs "instances/$1/rootfs.squashfs${2:+.$2}"
fi
