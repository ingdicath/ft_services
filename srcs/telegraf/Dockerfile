# Using official alpine image as a parent image
FROM alpine:3.12

# Getting the updates for alpine
RUN apk update

# Adding new packages
RUN apk add --no-cache wget

# Updating telegraf version
ENV TELEGRAF_VERSION 1.17.2

# Downloading telegraf agent
RUN wget -nv https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz && \
    tar -xf telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz --strip-components=2 -C . && \
	rm telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz

COPY srcs/telegraf.conf /etc/telegraf/
COPY srcs/start.sh .

# Start program
CMD sh start.sh