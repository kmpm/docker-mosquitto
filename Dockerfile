FROM debian:jessie

MAINTAINER Peter Magnusson <peter@birchroad.net>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get install -y wget

RUN wget -q -O - http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key | apt-key add -
RUN wget -q -O /etc/apt/sources.list.d/mosquitto-jessie.list http://repo.mosquitto.org/debian/mosquitto-jessie.list

RUN apt-get update && \
	apt-get install -y mosquitto

RUN adduser --system --disabled-password --disabled-login mosquitto

COPY config /mqtt/config

VOLUME ["/mqtt/config", "/mqtt/var"]

ADD docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 1883 9001

CMD ["/docker-entrypoint.sh"]