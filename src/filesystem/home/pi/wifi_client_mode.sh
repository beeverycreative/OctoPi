#!/bin/bash

MODULE=`readlink /sys/class/net/wlan0/device/driver/module | grep -o '[^/]*$'`

# kill any of these, if running
echo "Killing hostapd..."
sudo pkill hostapd

echo "Killing dhcpcd..."
sudo pkill dhcpcd

echo "Killing wpa_supplicant..."
sudo pkill wpa_supplicant

if [[ -f /var/run/wpa_supplicant/wlan0 ]]; then
	sudo rm /var/run/wpa_supplicant/wlan0
fi

echo "Stopping dnsmasq..."
sudo systemctl stop dnsmasq

# this helps in transitioning from AP to client, seems to fail way less times
echo "Removing and inserting $MODULE"
sudo modprobe -r $MODULE
sudo modprobe $MODULE
sleep 3

# reset wlan0 interface
echo "Resetting wlan0 interface..."
sudo ip link set wlan0 down
sudo ip addr flush dev wlan0
sudo ip link set wlan0 up

# copy the generated wpa_supplicant.conf to it's proper place and run 
# wpa_supplicant afterwards
echo "Copying wpa_supplicant_update.conf..."
sudo cp -v $HOME/wpa_supplicant_update.conf /etc/wpa_supplicant/wpa_supplicant.conf
echo "Starting wpa_supplicant..."
sudo wpa_supplicant -B -D nl80211,wext -c /etc/wpa_supplicant/wpa_supplicant.conf -i wlan0

# wait for wpa_supplicant to associate to AP successfully
# couldn't find a better way to do this, like the handy -w option in dhcpcd
while [[ -z `iwgetid wlan0 -r` ]]; do
    echo "Waiting for AP to associate..."
    sleep 1
done

# finally, acquire IP. fork when successfully acquired
echo "Acquiring IP..."
sudo dhcpcd -w wlan0 -t 0

