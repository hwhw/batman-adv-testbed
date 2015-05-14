#!/bin/sh
cd $(dirname "$0")
git clone --depth=1 git://git.buildroot.net/buildroot
cp buildroot.config buildroot/.config
