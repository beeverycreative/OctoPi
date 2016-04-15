#!/bin/bash

# kill any of these, if running
sudo pkill hostapd
sudo pkill dhcpcd
sudo pkill wpa_supplicant
sudo systemctl stop dnsmasq

# reset wlan0 interface, and add IP manually, for AP mode
sudo ip link set wlan0 down
sudo ip addr flush dev wlan0
sudo ip addr add 10.0.0.1/24 dev wlan0
sudo ip link set wlan0 up

sudo systemctl start dnsmasq

# search for any external USB pen
# it's a stupid method of determining if we should use
# the config file for external pen drives, on rpi2
# if you use an external wifi usb pen on rpi3, it will try
# to use the config file on wlan0 anyway, which is usually
# the internal adapter
if [[ `lsusb -v | grep WLAN` ]]; then
    sudo hostapd -B /etc/hostapd/hostapd.conf.external
else    
    sudo hostapd -B /etc/hostapd/hostapd.conf.internal
fi

