#!/bin/bash

if [ ! -f /etc/wpa_supplicant/wpa_supplicant.conf ]; then
    
    sudo rm /etc/network/interfaces
    sudo cp /etc/network/interfaces_ap.dist /etc/network/interfaces

    sudo ifdown wlan0

    sudo service networking restart
    sudo service dnsmasq start
    sudo service hostapd start
fi
