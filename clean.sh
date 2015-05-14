#!/bin/sh
cd $(dirname "$0")
source ./config

rm -rf root
cp -a root-overlay root

rm -f linux
rm -rf linux-$LINUX_VERSION
tar xJf linux-$LINUX_VERSION.tar.xz &&
    ln -sf linux-$LINUX_VERSION linux &&
    cp "$LINUX_CONFIG".config linux/.config

pushd buildroot
git reset --hard master
git clean -dfx
cp ../buildroot.config .config
popd

pushd batman-adv-legacy
git reset --hard master
git clean -dfx
patch -p1 < ../batman-adv-legacy.patch
popd
