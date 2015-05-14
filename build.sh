#!/bin/sh
cd $(dirname "$0")
source ./config

pushd linux
make oldconfig
make $MAKE_OPTS modules
make $MAKE_OPTS modules_install INSTALL_MOD_PATH=$(pwd)/../root
popd

pushd batman-adv-legacy
make KERNELPATH=../linux
make -C ../linux M=$(pwd) PWD=$(pwd) modules_install INSTALL_MOD_PATH=$(pwd)/../root
popd

pushd buildroot
make $MAKE_OPTS
popd

pushd linux
make $MAKE_OPTS
popd
cp linux/arch/x86/boot/bzImage bzImage-$LINUX_VERSION
ln -sf bzImage-$LINUX_VERSION bzImage
