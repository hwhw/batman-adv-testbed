#!/bin/sh
brctl addbr batmantestbr0
ip address add 10.111.111.254/24 dev batmantestbr0
ip link set dev batmantestbr0 up
