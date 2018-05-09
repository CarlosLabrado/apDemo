#!/bin/bash

echo trying to export address
export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket

echo activate connection first
python /usr/src/app/activate_connection.py

echo port forward
sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"

echo ..... start.sh: Running main app ....
python /usr/src/app/front.py