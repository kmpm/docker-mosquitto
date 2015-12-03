
CONTAINER?=mqtt
IMAGE_NAME?="kmpm/mosquitto"
STORAGE_ROOT?=/srv/mqtt
STORAGE_CONTAINER?=mqtt-data



.PHONY: build storage volume run

all: volume build run

build:
	docker build -t $(IMAGE_NAME) .
	

storage:
	sudo mkdir -p $(STORAGE_ROOT)/var
	sudo mkdir -p $(STORAGE_ROOT)/config
	#copy files from local config folder
	sudo cp -R config $(STORAGE_ROOT)/

volume: storage
	docker run --name $(STORAGE_CONTAINER) \
    -v $(STORAGE_ROOT)/config:/mqtt/config \
    -v $(STORAGE_ROOT)/var:/mqtt/var \
    busybox
	
run:
	docker run -d -p 1883:1883 -p 9001:9001 --name $(CONTAINER) --volumes-from $(STORAGE_CONTAINER) $(IMAGE_NAME)
	docker logs $(CONTAINER)
	