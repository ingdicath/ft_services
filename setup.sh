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

echo -e "\n\n$BLUE ..🍒..🍒..🍒 WELCOME TO FT_SERVICES 🍒..🍒..🍒.. \n$RESET"

# ---------------------------------------------------------	#
# 						INICIAL SET UP						#
# -----------------------------------------	---------------	#

# Clean previous minikube instance
echo -e "\n$PURPLE Deleting prior minikube instance..🦢..🦢..🦢..\n$RESET"
minikube delete
echo -e "$GREEN Prior minikube deleted 👍\n$RESET"

# Start the cluster using the docker driver
echo -e "\n$PURPLE Creating minikube instance..🐇..🐇..🐇..\n$RESET" 
# ---- for mac -----
minikube start --driver=virtualbox

# ---- for windows 10 Home -----
# minikube start --driver=virtualbox --cpus=2 --memory 3000 --no-vtx-check
echo -e "\n$GREEN Minikube instance creation completed 😃\n$RESET"

# ********** INSTALL ADDONS **********

echo -e "\n$PURPLE Installing minikube addons..⏳..⏳..⏳..\n$RESET" 
minikube addons enable metallb
minikube addons enable dashboard
minikube addons enable metrics-server
echo -e "\n$GREEN Minikube addons installed 😃 $RESET\n"

# ********** CONNECT MINIKUBE TO DOCKER **********

# Set up environment to use minikube’s Docker daemon
# ---- linux, mac or cygwin64 -----
eval $(minikube docker-env)

# ---- for windows 10 Home in powershell -----
# minikube docker-env
# minikube -p minikube docker-env | Invoke-Expression

# ---------------------------------------------------------	#
# 					BUILDING METALLLB 						#
# -----------------------------------------	---------------	#
echo -e "\n$PURPLE Setting up METALLLB and secrets..🐖..🐖..🐖..$RESET\n"
## On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metallb.yaml
kubectl apply -f srcs/secrets.yaml


# ---------------------------------------------------------	#
# 					SERVICES DEPLOYMENTS					#
# -----------------------------------------	---------------	#

# ************************* NGINX ***************************
echo -e "\n$PURPLE Setting up NGINX..🐷..🐷..🐷..\n$RESET"
docker build -t my_nginx srcs/nginx
kubectl apply -f srcs/nginx/srcs/nginx.yaml

# ************************* MYSQL ***************************
echo -e "\n$PURPLE Setting up MYSQL..🐷..🐷..🐷..\n$RESET"
docker build -t my_mysql srcs/mysql
kubectl apply -f srcs/mysql/srcs/mysql.yaml

# ********************** PHPMYADMIN *************************
echo -e "\n$PURPLE Setting up PHPMYADMIN..🐷..🐷..🐷..\n$RESET"
docker build -t my_phpmyadmin srcs/phpmyadmin
kubectl apply -f srcs/phpmyadmin/srcs/phpmyadmin.yaml

# ********************** INFLUXDB *************************
echo -e "\n$PURPLE Setting up INFLUXDB & TELEGRAF..🐷..🐷..🐷..\n$RESET"
docker build -t my_influxdb srcs/influxdb
kubectl apply -f srcs/influxdb/srcs/influxdb.yaml
docker build -t my_telegraf srcs/telegraf
kubectl apply -f srcs/telegraf/srcs/telegraf.yaml

# ********************** WORDPRESS *************************
echo -e "\n$PURPLE Setting up WORDPRESS..🐷..🐷..🐷..\n$RESET"
docker build -t my_wordpress srcs/wordpress
kubectl apply -f srcs/wordpress/srcs/wordpress.yaml

# ********************** GRAFANA *************************
echo -e "\n$PURPLE Setting up GRAFANA..🐷..🐷..🐷..\n$RESET"
docker build -t my_grafana srcs/grafana
kubectl apply -f srcs/grafana/srcs/grafana.yaml

# ************************* FTPS ****************************
echo -e "\n$PURPLE Setting up FTPS..🐷..🐷..🐷..\n$RESET"
docker build -t my_ftps srcs/ftps
kubectl apply -f srcs/ftps/srcs/ftps.yaml

echo -e "\n$GREEN Deployments completed 👍\n$RESET"


# ---------------------------------------------------------	#
# 						DISPLAY DASHBOARD					#
# ---------------------------------------------------------	#

echo -e "\n$PURPLE Starting Dashboard 😃..😃..😃.\n$RESET"
minikube dashboard

# ---------------------------------------------------------	#
# 						HOW TO LOGIN 						#
# ---------------------------------------------------------	#

# --- For phpmyadmin, worpress, mysql -- 
# user: grogu
# password: go to secrets, it is encrypted!!!

# --- For grafana -- 
# user: admin
# password: go to secrets, it is encrypted!!!

# http://192.168.99.36:80 --> Nginx
# http://192.168.99.36:5050 --> Wordpress
# http://192.168.99.36:5000 --> PhpMyadmin
# http://192.168.99.36:3000 --> Grafana