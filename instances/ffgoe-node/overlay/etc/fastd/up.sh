#!/bin/sh
source /proc/cmdline
if [ -n "$fastd_mac" ]; then
    ip link set dev $INTERFACE address $fastd_mac
fi
ip link set dev $INTERFACE up
modprobe batman-adv
batctl if add $INTERFACE
ifup bat0
