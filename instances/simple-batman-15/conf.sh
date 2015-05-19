QEMU_FLAGS="
    -net nic,vlan=0,model=virtio,macaddr=c4:6f:f6:0e:00:$(printf "%02x" ${ID:=1})
    -net bridge,vlan=0,br=brvmnat
    "

if [ -n "$FFGOE_BRIDGE" ]; then
QEMU_FLAGS="$QEMU_FLAGS
    -net nic,vlan=1,model=virtio,macaddr=c4:6f:f6:0e:80:$(printf "%02x" ${ID:=1})
    -net bridge,vlan=1,br=$FFGOE_BRIDGE
    "
fi

if [ -n "$MESH_BRIDGE" ]; then
QEMU_FLAGS="$QEMU_FLAGS
    -net nic,vlan=2,model=virtio,macaddr=c4:6f:f6:0e:c0:$(printf "%02x" ${ID:=1})
    -net bridge,vlan=2,br=$MESH_BRIDGE
    "
fi

FASTD_MAC="${FASTD_MAC:=c4:6f:f6:0e:40:$(printf "%02x" ${ID:=1})}"
BATMAN_MAC="${FASTD_MAC:=c4:6f:f6:0f:00:$(printf "%02x" ${ID:=1})}"

FLAGS="$FLAGS${FASTD_MAC:+ fastd_mac=$FASTD_MAC}"
FLAGS="$FLAGS${FASTD_SECRET:+ fastd_secret=$FASTD_SECRET}"
FLAGS="$FLAGS${FASTD_PEERS:+ fastd_peers=$FASTD_PEERS}"
FLAGS="$FLAGS${FASTD_LIMIT:+ fastd_limit=$FASTD_LIMIT}"
FLAGS="$FLAGS${BATMAN_MAC:+ batman_mac=$BATMAN_MAC}"
FLAGS="$FLAGS${NODE_MODEL:+ node_model=$NODE_MODEL}"
FLAGS="$FLAGS${NODE_CONTACT:+ node_contact=$NODE_CONTACT}"
FLAGS="$FLAGS${NODE_RELEASE:+ node_release=$NODE_RELEASE}"
