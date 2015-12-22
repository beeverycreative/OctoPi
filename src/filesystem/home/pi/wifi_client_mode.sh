#!/bin/bash

sudo rm /etc/wpa_supplicant/wpa_supplicant.conf
sudo cp /etc/wpa_supplicant/wpa_supplicant.conf.dist /etc/wpa_supplicant/wpa_supplicant.conf

sudo rm /etc/network/interfaces
sudo cp /etc/network/interfaces_normal.dist /etc/network/interfaces

sudo service hostapd stop
sudo service networking restart

sudo ifdown wlan0
sudo ifup wlan0
