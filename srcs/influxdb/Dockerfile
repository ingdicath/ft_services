# Using official alpine image as a parent image
FROM alpine:latest

# Getting the updates for alpine
RUN apk update

# Adding new packages
RUN apk add --no-cache wget influxdb 

COPY srcs/start.sh .

# The default port that runs the InfluxDB HTTP service
EXPOSE 8086

# Start program
CMD sh start.sh