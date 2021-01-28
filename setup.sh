#!/bin/bash

# Colors
CYAN='\e[0;32m'
GREEN= '\e[0;32m'
RESET= '\e[0;37m'

# ********** CHECK BEFORE START **********
# This applies for CODAM MacOS

# --- Install homebrew ---
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# --- Install Kubectl ---
# kubectl version
# brew install kubectl

# --- Install Minikube ---
# brew install minikube
# mkdir -p ~/goinfre/minikube
# chmod +x ~/goinfre/minikube
# export MINIKUBE_HOME=/Volumes/Storage/goinfre/<--intraname-->/minikube

# --- Install Docker and VirtualBox ---
# In Manage Software Center, install from icons

# --- Create a link in goinfre for Docker ---
# mkdir -p ~/goinfre/docker
# rm -rf ~/Library/Containers/com.docker.docker
# ln -s ~/goinfre/docker ~/Library/Containers/com.docker.docker


# --- Create link in goinfre to save memory minikube ---
# mkdir -p ~/goinfre/machines
# rm -rf ~/.minikube/machines
# ln -s ~/goinfre/machines ~/.minikube/machines

# ********** INICIAL SET UP **********

# Clean previous minikube instance
minikube delete

# Start the cluster using the docker driver
minikube start --driver=docker
# minikube start --vm-driver=virtualbox ???

# Install addons
minikube addons enable metallb
minikube addons enable dashboard

# Set up environment to use minikube’s Docker daemon
eval $(minikube docker-env)

# Build docker images
echo "${CYAN}Starting build docker images...${RESET}"
docker build -t my_nginx srcs/nginx
docker build -t my_wordpress srcs/wordpress
docker build -t my_mysql srcs/mysql
docker build -t my_phpmyadmin srcs/phpmyadmin
docker build -t my_ftps srcs/ftps
docker build -t my_grafana srcs/grafana
docker build -t my_influxdb srcs/influxdb
echo "${GREEN}Build docker images completed${RESET}"

# Deployments
echo "${CYAN}Starting Deployments...${RESET}"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
kubectl apply -f srcs/metallb.yaml
kubectl apply -f srcs/nginx/nginx.yaml
kubectl apply -f srcs/wordpress/wordpress.yaml
kubectl apply -f srcs/mysql/mysql.yaml
kubectl apply -f srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f srcs/grafana/grafana.yaml
kubectl apply -f srcs/influxdb/influxdb.yaml
echo "${GREEN}Deployments completed${RESET}"

# Set up MetalLB secret, On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# Display dashboard
minikube dashboard
