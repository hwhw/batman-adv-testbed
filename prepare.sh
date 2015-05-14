#!/bin/sh
cd $(dirname "$0")
source ./config

wget $LINUX_URL
git clone --depth=1 git://git.buildroot.net/buildroot
git clone https://github.com/freifunk-gluon/batman-adv-legacy.git

./clean.sh
