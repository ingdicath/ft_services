#!/bin/sh

# Colors
RESET='\e[0m'
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'
PURPLE='\e[0;35m'
CYAN='\e[1;36m'
RESET='\e[1;37m'

# ********** CHECK BEFORE START **********

# --- Install Kubectl ---
# kubectl version
# brew install kubectl

# --- Install Minikube ---
# brew install minikube
# mkdir -p ~/goinfre/minikube
# chmod +x ~/goinfre/minikube
# export MINIKUBE_HOME=/Volumes/Storage/goinfre/<INTRANAME>/minikube

# --- Install VirtualBox ---
# In Manage Software Center, install from icons

# --- Create a link in goinfre for Docker ---
# mkdir -p ~/goinfre/docker
# rm -rf ~/Library/Containers/com.docker.docker
# ln -s ~/goinfre/docker ~/Library/Containers/com.docker.docker

# --- Create link in goinfre to save memory minikube ---
# mkdir -p ~/goinfre/machines
# rm -rf ~/.minikube/machines
# ln -s ~/goinfre/machines ~/.minikube/machines

echo -e "$BLUE ..🍒..🍒..🍒 WELCOME TO FT_SERVICES 🍒..🍒..🍒.. $RESET"

# ********** INICIAL SET UP **********

# Clean previous minikube instance
echo -e "$PURPLE Deleting prior minikube instance..🦢..🦢..🦢..$RESET" 
# minikube delete
echo -e "$GREEN Prior minikube deleted 👍$RESET"

# Start the cluster using the docker driver
echo -e "$PURPLE Creating minikube instance..🐇..🐇..🐇..$RESET" 
# minikube start --driver=docker
# minikube start --vm-driver=virtualbox
echo -e "$GREEN Minikube instance creation completed 😃$RESET"

# Install addons
echo -e "$PURPLE Installing minikube addons..⏳..⏳..⏳..$RESET" 
# minikube addons enable metallb
# minikube addons enable dashboard
# minikube addons enable metrics-server
echo -e "$GREEN Minikube addons installed 😃 $RESET"

# Set up environment to use minikube’s Docker daemon
# eval $(minikube docker-env)

# Build docker images
echo -e "$PURPLE Starting build docker images..🐷..🐷..🐷..$RESET"
# docker build -t my_nginx srcs/nginx
# docker build -t my_wordpress srcs/wordpress
# docker build -t my_mysql srcs/mysql
# docker build -t my_phpmyadmin srcs/phpmyadmin
# docker build -t my_ftps srcs/ftps
# docker build -t my_grafana srcs/grafana
# docker build -t my_influxdb srcs/influxdb
echo -e "$GREEN Build docker images completed 😃$RESET"

# Deployments
echo -e "$PURPLE Starting Deployments 🐖..🐖..🐖.$RESET"
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
# kubectl apply -f srcs/metallb.yaml
# kubectl apply -f srcs/nginx/srcs/nginx.yaml
# kubectl apply -f srcs/wordpress/srcs/wordpress.yaml
# kubectl apply -f srcs/mysql/srcs/mysql.yaml
# kubectl apply -f srcs/phpmyadmin/srcs/phpmyadmin.yaml
# kubectl apply -f srcs/grafana/srcs/grafana.yaml
# kubectl apply -f srcs/influxdb/srcs/influxdb.yaml
echo -e "$GREEN Deployments completed 👍$RESET"

# Set up MetalLB secret, On first install only
# kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# Display dashboard
# minikube dashboard


# How to login:
# phpmyadmin: mysql:mysql
# Worpress: :
# Grafana: admin:admin




# http://192.168.99.202:5050">Wordpress
# http://192.168.99.203:5000">PhpMyadmin
# http://192.168.99.100:3000">Grafana
# 192.168.99.201 ftps
# 192.168.99.200 ngnix