#!/bin/bash

sudo pkill hostapd
sudo pkill dhcpcd

sudo ip link set wlan0 down
sudo ip addr flush dev wlan0
sudo ip link set wlan0 up

sudo wpa_supplicant -D nl80211,wext -c /etc/wpa_supplicant/wpa_supplicant.conf -i wlan0
sudo dhcpcd wlan0 &

