#!/bin/bash

LSUSB_RESULT=`lsusb`
WIFI_PEN_IDS=("7392:7811" "0bda:8176")
PEN_FOUND=false

sudo pkill dhcpcd
sudo systemctl stop dnsmasq

sudo ip addr flush dev wlan0
sudo ip link set wlan0 down
sudo ip addr add 10.0.0.1/24 dev wlan0
sudo ip link set wlan0 up

sudo systemctl start dnsmasq

sleep 3

for id in ${WIFI_PEN_IDS[@]}; do
    if [[ `echo $LSUSB_RESULT | grep $id` ]]; then
        PEN_FOUND=true
        sudo hostapd /etc/hostapd/hostapd.conf.external &
        break
    fi
done

if [ $PEN_FOUND = false ]; then
    sudo hostapd /etc/hostapd/hostapd.conf.internal &
fi

