#!/bin/sh
# Colors
RESET='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[0;35m'
CYAN='\033[1;36m'
WHITE='\033[0;37m'

echo -e "$BLUE ..🍒..🍒..🍒 WELCOME TO FT_SERVICES 🍒..🍒..🍒.. $RESET"

# ---------------------------------------------------------	#
# 						INICIAL SET UP						#
# -----------------------------------------	---------------	#

# Clean previous minikube instance
echo -e "$PURPLE Deleting prior minikube instance..🦢..🦢..🦢..$RESET"
minikube delete
echo -e "$GREEN Prior minikube deleted 👍$RESET"

# Start the cluster using the docker driver
echo -e "$PURPLE Creating minikube instance..🐇..🐇..🐇..$RESET" 
# ---- for mac -----
# minikube start --driver=virtualbox

# ---- for windows 10 Home -----
minikube start --driver=virtualbox --cpus=2 --memory 3000 --no-vtx-check
echo -e "$GREEN Minikube instance creation completed 😃$RESET"

# ********** INSTALL ADDONS **********

echo -e "$PURPLE Installing minikube addons..⏳..⏳..⏳..$RESET" 
minikube addons enable metallb
minikube addons enable dashboard
minikube addons enable metrics-server
echo -e "$GREEN Minikube addons installed 😃 $RESET"

# ********** CONNECT MINIKUBE TO DOCKER **********

# Set up environment to use minikube’s Docker daemon
# ---- linux or mac -----
eval $(minikube docker-env)

# ---- for windows 10 Home -----
# minikube docker-env
# minikube -p minikube docker-env | Invoke-Expression


# ---------------------------------------------------------	#
# 					BUILDING DOCKER IMAGES					#
# -----------------------------------------	---------------	#

echo -e "$PURPLE Starting build docker images..🐷..🐷..🐷..$RESET"
docker build -t my_nginx srcs/nginx
docker build -t my_mysql srcs/mysql
docker build -t my_wordpress srcs/wordpress
docker build -t my_phpmyadmin srcs/phpmyadmin
docker build -t my_ftps srcs/ftps
docker build -t my_influxdb srcs/influxdb
docker build -t my_telegraf srcs/telegraf
docker build -t my_grafana srcs/grafana
echo -e "$GREEN Build docker images completed 😃$RESET"


# ---------------------------------------------------------	#
# 					BUILDING K8S DEPLOYMENTS				#
# -----------------------------------------	---------------	#

echo -e "$PURPLE Starting Deployments & secrets 🐖..🐖..🐖.$RESET"
kubectl apply -f srcs/secrets.yaml
kubectl apply -f srcs/metallb.yaml
kubectl apply -f srcs/mysql/srcs/mysql.yaml
kubectl apply -f srcs/nginx/srcs/nginx.yaml
kubectl apply -f srcs/influxdb/srcs/influxdb.yaml
kubectl apply -f srcs/telegraf/srcs/telegraf.yaml
kubectl apply -f srcs/ftps/srcs/ftps.yaml
kubectl apply -f srcs/grafana/srcs/grafana.yaml
kubectl apply -f srcs/wordpress/srcs/wordpress.yaml
kubectl apply -f srcs/phpmyadmin/srcs/phpmyadmin.yaml
echo -e "$GREEN Deployments completed 👍$RESET"

# ********** SET UP METALLB SECRET **********
## On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# ---------------------------------------------------------	#
# 						DISPLAY DASHBOARD					#
# ---------------------------------------------------------	#

echo -e "$PURPLE Starting Dashboard 🐖..🐖..🐖.$RESET"
minikube dashboard

# ---------------------------------------------------------	#
# 						HOW TO LOGIN 						#
# ---------------------------------------------------------	#

# --- For phpmyadmin, Worpress, mysql, influxdb, telegraf -- 
# user: grogu
# password: go to secret, it is encrypted!!!

# --- For grafana -- 
# user: admin
# password: go to secret, it is encrypted!!!

# http://192.168.99.36:80 --> Nginx
# http://192.168.99.36:5050 --> Wordpress
# http://192.168.99.36:5000 --> PhpMyadmin
# http://192.168.99.36:3000 --> Grafana