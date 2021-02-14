# Using official alpine image as a parent image
FROM alpine:latest

# Getting the updates for alpine
RUN apk update

# Adding new packages
RUN apk add --no-cache wget

# Updating grafana version
ENV GRAFANA_VERSION 7.4.1

# Setting grafana executable path
ENV PATH=/usr/share/grafana/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Downloading grafana
RUN mkdir /usr/share/grafana
RUN wget -nv https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz
RUN tar -xf grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz --strip-components=1 -C /usr/share/grafana
RUN rm grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz

COPY srcs/start.sh .

# Default port for grafana
EXPOSE 3000

# Start program
CMD sh start.sh