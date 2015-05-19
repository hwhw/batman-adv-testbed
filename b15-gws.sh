#!/bin/sh
#Secret: 4005257db4923494c8eed31378e69714e635842ac62f8146a1e9edda3239bc72
#Public: f307bcd35e9a8e309f51bae9a5923be42354799476d4203186ce9f1058bc7faf
MESH_BRIDGE=brgw15 \
    FFGOE_BRIDGE=brffgoe1 \
    MEM=48 \
    BAT_HOSTNAME="gw01" \
    ID=1 \
    FASTD_SECRET=4005257db4923494c8eed31378e69714e635842ac62f8146a1e9edda3239bc72 \
    ./run.sh simple-batman-15 &
#Secret: b8fd9777095550b78f594c2be9eaa9c208dae51478f4fd88dd9c346dcdb8b665
#Public: 1143d58df59ae5d20638cbf813eec7228a5ee594981990295cdb084af73f9a63
MESH_BRIDGE=brgw15 \
    FFGOE_BRIDGE=brffgoe1 \
    MEM=48 \
    BAT_HOSTNAME="gw02" \
    ID=2 \
    FASTD_SECRET=b8fd9777095550b78f594c2be9eaa9c208dae51478f4fd88dd9c346dcdb8b665 \
    ./run.sh simple-batman-15 &
#Secret: e84e2676fbd45eb94db1189f25fc90025b2bf39bbbfc5827167b7b7b4acadc65
#Public: d6079773080f74d2207627113ac56aa20321cd38f43e254d85a475fc6cb1b4ee
MESH_BRIDGE=brgw15 \
    FFGOE_BRIDGE=brffgoe1 \
    MEM=48 \
    BAT_HOSTNAME="gw03" \
    ID=3 \
    FASTD_SECRET=e84e2676fbd45eb94db1189f25fc90025b2bf39bbbfc5827167b7b7b4acadc65 \
    ./run.sh simple-batman-15 &

for n in $(seq 1 ${1:=1}); do
    BAT_HOSTNAME="client$n" \
        FASTD_LIMIT=1 \
        FASTD_PEERS="f307bcd35e9a8e309f51bae9a5923be42354799476d4203186ce9f1058bc7faf@ipv4@gw01.farm@12345,1143d58df59ae5d20638cbf813eec7228a5ee594981990295cdb084af73f9a63@ipv4@gw02.farm@12345,d6079773080f74d2207627113ac56aa20321cd38f43e254d85a475fc6cb1b4ee@ipv4@gw03.farm@12345" \
        ID=$(($n + 3)) MEM=32 ./run.sh simple-batman-15 &
done

wait
