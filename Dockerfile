FROM debian:stable

MAINTAINER Zack YL Shih <zackyl.shih@moxa.com>

# Add mosquitto key and apt-get install
RUN apt-get update && apt-get upgrade -y && apt-get install -y wget

RUN wget -O - http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key | \
    apt-key add -
RUN wget -O /etc/apt/sources.list.d/mosquitto-repo.list \
    http://repo.mosquitto.org/debian/mosquitto-repo.list

RUN apt-get update && apt-get install -y mosquitto

# Copy configs
COPY config /mqtt/config

VOLUME ["/mqtt/config", "/mqtt/data", "/mqtt/log"]

# Expose default mqtt port
EXPOSE 1883

CMD /usr/sbin/mosquitto -c /mqtt/config/mosquitto.conf