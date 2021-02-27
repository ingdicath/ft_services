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
minikube start --driver=virtualbox

# ---- for windows 10 Home -----
# minikube start --driver=virtualbox --cpus=2 --memory 3000 --no-vtx-check
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
# 					BUILDING METALLLB 						#
# -----------------------------------------	---------------	#
echo -e "$PURPLE Setting up METALLLB and secrets..🐖..🐖..🐖..$RESET"
## On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metallb.yaml
kubectl apply -f srcs/secrets.yaml


# ---------------------------------------------------------	#
# 					SERVICES DEPLOYMENTS					#
# -----------------------------------------	---------------	#

# ************************* NGINX ***************************
echo -e "$PURPLE Setting up NGINX..🐷..🐷..🐷..$RESET"
docker build -t my_nginx srcs/nginx
kubectl apply -f srcs/nginx/srcs/nginx.yaml

# ************************* MYSQL ***************************
echo -e "$PURPLE Setting up MYSQL..🐷..🐷..🐷..$RESET"
docker build -t my_mysql srcs/mysql
kubectl apply -f srcs/mysql/srcs/mysql.yaml

# ********************** PHPMYADMIN *************************
echo -e "$PURPLE Setting up PHPMYADMIN..🐷..🐷..🐷..$RESET"
docker build -t my_phpmyadmin srcs/phpmyadmin
kubectl apply -f srcs/phpmyadmin/srcs/phpmyadmin.yaml

# ********************** INFLUXDB *************************
echo -e "$PURPLE Setting up INFLUXDB & TELEGRAF..🐷..🐷..🐷..$RESET"
docker build -t my_influxdb srcs/influxdb
kubectl apply -f srcs/influxdb/srcs/influxdb.yaml
docker build -t my_telegraf srcs/telegraf
kubectl apply -f srcs/telegraf/srcs/telegraf.yaml

# ********************** WORDPRESS *************************
echo -e "$PURPLE Setting up WORDPRESS..🐷..🐷..🐷..$RESET"
docker build -t my_wordpress srcs/wordpress
kubectl apply -f srcs/wordpress/srcs/wordpress.yaml

# ********************** GRAFANA *************************
echo -e "$PURPLE Setting up GRAFANA..🐷..🐷..🐷..$RESET"
docker build -t my_grafana srcs/grafana
kubectl apply -f srcs/grafana/srcs/grafana.yaml

# ************************* FTPS ****************************
echo -e "$PURPLE Setting up FTPS..🐷..🐷..🐷..$RESET"
docker build -t my_ftps srcs/ftps
kubectl apply -f srcs/ftps/srcs/ftps.yaml

echo -e "$GREEN Deployments completed 👍$RESET"


# ---------------------------------------------------------	#
# 						DISPLAY DASHBOARD					#
# ---------------------------------------------------------	#

echo -e "$PURPLE Starting Dashboard 😃..😃..😃.$RESET"
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