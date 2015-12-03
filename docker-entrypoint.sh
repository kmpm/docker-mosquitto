#!/bin/bash
set -e

if [ ! -d "/mqtt/var/log" ]; then 
	mkdir -p /mqtt/var/log
fi

if [ ! -d "/mqtt/var/data" ]; then
	mkdir -p /mqtt/var/data
fi

chown -R mosquitto /mqtt/var

# start mosquitto
exec /usr/sbin/mosquitto -c /mqtt/config/mosquitto.conf
