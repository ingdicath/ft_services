#!/bin/bash

# Colors
RESET='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[0;35m'
CYAN='\033[1;36m'
WHITE='\033[0;37m'

echo -e "\n$BLUE Starting Cleaning\n$RESET"

# ********** REMOVING K8S OBJECTS **********

echo -e "$PURPLE Deleting k8s deployments...$RESET"
# kubectl delete -f srcs/secrets.yaml
# kubectl delete -f srcs/metallb.yaml
# kubectl delete -f srcs/nginx/srcs/nginx.yaml
# kubectl delete -f srcs/wordpress/srcs/wordpress.yaml
# kubectl delete -f srcs/mysql/srcs/mysql.yaml
# kubectl delete -f srcs/phpmyadmin/srcs/phpmyadmin.yaml
# kubectl delete -f srcs/grafana/srcs/grafana.yaml
# kubectl delete -f srcs/influxdb/srcs/influxdb.yaml
# kubectl delete -f srcs/telegraf/srcs/telegraf.yaml
# kubectl delete secret -n metallb-system memberlist


# ********** REMOVING DOCKER PROPERTIES  **********

echo -e "\n$PURPLE Deleting docker images & containers...$RESET"
# docker container prune -f
# docker image prune -a --force

echo -e "\n$GREEN Cleaning completed 👍$RESET"