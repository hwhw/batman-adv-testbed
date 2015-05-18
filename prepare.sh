#!/bin/sh
cd $(dirname "$0")
git submodule init
git submodule update
cp buildroot.config buildroot/.config
