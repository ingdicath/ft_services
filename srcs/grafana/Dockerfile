# Using official alpine image as a parent image
FROM alpine:latest

# Getting the updates for alpine
RUN apk update

# Adding new packages
RUN apk add --no-cache wget libc6-compat

# Updating grafana version
ENV GRAFANA_VERSION 7.4.1

# Set env variables
ENV PATH=/usr/share/grafana/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    GF_PATHS_HOME="/usr/share/grafana"

# Installing grafana
# '--strip-components=NUMBER' is for modifying the filenames of extracted files, '-C' change to directory DIR
RUN mkdir /usr/share/grafana
RUN wget -nv https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz && \
	tar -xf grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz --strip-components=1 -C /usr/share/grafana && \
	rm grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz

WORKDIR $GF_PATHS_HOME

COPY srcs/datasource.yaml conf/provisioning/datasources/
COPY srcs/dashboards/ conf/provisioning/dashboards

# Default port for grafana
EXPOSE 3000

# Start program
CMD grafana-server