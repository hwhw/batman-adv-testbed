#!/bin/sh
logger "updating alfred data"

ALFRED=/usr/sbin/alfred

source /proc/cmdline

MAC=$(cat /sys/class/net/br-client/address)
NODE_ID=$(echo $MAC|sed 's/://')

NODEINFO='{"node_id":"'$NODE_ID'","network":{"mac":"'$MAC'","addresses":['
NODEINFO=$NODEINFO$(ip addr show dev br-client | awk '/ *inet6 / {sub("/.*","",$2); printf(KOMMA "\"" $2 "\""); KOMMA=","}')
NODEINFO=$NODEINFO'],"mesh_interfaces":['
KOMMA=""
for i in mesh-vpn; do
    NODEINFO=$NODEINFO'"'$(cat /sys/class/net/$i/address)'"'$KOMMA
    KOMMA=","
done
NODEINFO=$NODEINFO']},"hostname":"'$(hostname)'","hardware":{"model":"'${node_model:=Nimbus 2000}
NODEINFO=$NODEINFO'"},"owner":{"contact":"'${node_contact:=hedwig@owlery.hw}'"},'
NODEINFO=$NODEINFO'"software":{"fastd":{"enabled":true,"version":"'$(fastd --version|awk '{print $2}')
NODEINFO=$NODEINFO'"},"batman-adv":{"compat":14,"version":"2013.4.0"},'
NODEINFO=$NODEINFO'"firmware":{"base":"lucy","release":"'${node_release:=My Milkshake is better than yours}'"}},"system":[]}'

echo $NODEINFO | gzip | $ALFRED -s 158

STATS='{"node_id":"'$NODE_ID'","clients":{"wifi":0,"total":0},"rootfs_usage":0.070075757575758,'
STATS=$STATS'"traffic":{"tx":{"packets":'$(cat /sys/class/net/bat0/statistics/tx_packets)','
STATS=$STATS'"dropped":'$(cat /sys/class/net/bat0/statistics/tx_dropped)',"bytes":'$(cat /sys/class/net/bat0/statistics/tx_bytes)'},'
STATS=$STATS'"rx":{"bytes":'$(cat /sys/class/net/bat0/statistics/rx_bytes)',"packets":'$(cat /sys/class/net/bat0/statistics/rx_packets)'},'
STATS=$STATS'"forward":{"bytes":0,"packets":0},'
STATS=$STATS'"mgmt_tx":{"bytes":0,"packets":0},'
STATS=$STATS'"mgmt_rx":{"bytes":0,"packets":0}},'
STATS=$STATS'"memory":{"cached":0,"total":1024,"buffers":0,"free":1024},'
STATS=$STATS$(awk '{print "\"uptime\":" $1 ",\"idletime\":" $2}' /proc/uptime)
STATS=$STATS$(awk '/^=>/ {print ",\"gateway\":\"" $2 "\""}' /sys/kernel/debug/batman_adv/bat0/gateways)
STATS=$STATS',"mesh_vpn":{"vpn2":{"established":100},"vpn1":{"established":100},"vpn3":{"established":100}}'
STATS=$STATS',"processes":{"total":42,"running":1},'
STATS=$STATS'"loadavg":'$(awk '{print $2}' /proc/loadavg)'}'

echo $STATS | gzip | $ALFRED -s 159
