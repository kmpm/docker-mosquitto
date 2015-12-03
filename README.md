docker-mosquitto
================

Docker image for mosquitto


## Quick one for you that just want to make it happen

    git clone https://github.com/kmpm/docker-mosquitto.git
    cd docker-mosquitto
    make

## Setup for Data Persistence
Quick

    make volume
    
Verbose...

Create two directories on your host:

    sudo mkdir -p /srv/mqtt/var
    sudo mkdir -p /srv/mqtt/config

copy files from local config folder

    sudo cp -R config /srv/mqtt/

Change /srv/mqtt/config as needed for your particular needs.


Create a container hosting the volume mappings.
This one is named mqtt-data
```
docker run --name mqtt-data \
    -v /srv/mqtt/config:/mqtt/config \
    -v /srv/mqtt/var:/mqtt/var \
    busybox
```


## Build
Quick

    make build
   
Verbose

    git clone https://github.com/kmpm/docker-mosquitto.git
    cd docker-mosquitto
    docker build -t kmpm/mosquitto .
    

## Run
Quick

    make run

Verbose

Use volumes from previously created container.

    docker run -d -p 1883:1883 -p 9001:9001 --volumes-from mqtt-data kmpm/mosquitto
Exposes Port 1883 (MQTT) 9001 (Websocket MQTT)


## Test
Run these commands in two separate consoles.

    mosquitto_sub -t /# -v
    mosquitto_pub -t /hello -m world
    
In the first one you should now se the message "world" on topic "/hello".
