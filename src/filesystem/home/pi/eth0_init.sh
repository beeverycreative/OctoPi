#!/usr/bin/env bash

sudo ifconfig eth0 down
sudo ifconfig eth0 up

ipAssigned=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')

if [ "$ipAssigned" == "" ]
then
    sudo dhcpcd -w eth0 -t 0 &
else
    echo "Ip already assigned"
fi