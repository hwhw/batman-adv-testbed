#!/bin/sh
cd $(dirname "$0")
source ./config

cp linux/.config "$LINUX_CONFIG".config
cp buildroot/.config buildroot.config

