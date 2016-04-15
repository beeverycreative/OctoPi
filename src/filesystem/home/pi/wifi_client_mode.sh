#!/bin/bash

# kill any of these, if running
sudo pkill hostapd
sudo pkill dhcpcd
sudo pkill wpa_supplicant
sudo systemctl stop dnsmasq

# reset wlan0 interface
sudo ip link set wlan0 down
sudo ip addr flush dev wlan0
sudo ip link set wlan0 up

# copy the generated wpa_supplicant.conf to it's proper place and run 
# wpa_supplicant afterwards
sudo cp $HOME/wpa_supplicant_update.conf /etc/wpa_supplicant/wpa_supplicant.conf
sudo wpa_supplicant -B -D nl80211,wext -c /etc/wpa_supplicant/wpa_supplicant.conf -i wlan0

# wait for wpa_supplicant to associate to AP successfully
# couldn't find a better way to do this, like the handy -w option in dhcpcd
while [[ -z `iwconfig wlan0 | grep ESSID` ]]; do
    echo "waiting for AP to associate..."
    sleep 1
done

# finally, acquire IP. fork when successfully acquired
sudo dhcpcd -w wlan0

