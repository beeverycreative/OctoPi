#!/bin/bash

sudo cp /home/pi/hosts_update /etc/hosts
sudo cp /home/pi/hostname_update /etc/hostname

sudo /etc/init.d/hostname.sh

sudo reboot
