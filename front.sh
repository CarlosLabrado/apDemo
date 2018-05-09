#!/bin/bash

echo trying to export address
export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket

echo try to change the hosts name
DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket \
  dbus-send \
  --system \
  --print-reply \
  --reply-timeout=2000 \
  --type=method_call \
  --dest=org.freedesktop.hostname1 \
  /org/freedesktop/hostname1 \
  org.freedesktop.hostname1.SetStaticHostname \
  string:"petrolog" boolean:true

echo activate connection first
python /usr/src/app/activate_connection.py

echo iptables
iptables -A FORWARD -i br0 -s 192.168.1.0/255.255.255.0 -j ACCEPT
iptables -A FORWARD -i eth0 -d 192.168.1.0/255.255.255.0 -j ACCEPT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

echo ..... start.sh: Running main app ....
python /usr/src/app/front.py