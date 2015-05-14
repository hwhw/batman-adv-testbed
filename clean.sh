#!/bin/sh
cd $(dirname "$0")/buildroot
make $MAKE_OPTS BR2_EXTERNAL=$(pwd)/../buildroot-external clean
