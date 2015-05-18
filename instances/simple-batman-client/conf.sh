QEMU_FLAGS="
    -net nic,vlan=0,model=virtio,macaddr=ca:fe:42:00:00:$(printf "%02x" ${ID:=1})
    -net bridge,vlan=0,br=batmantestbr0
    "
