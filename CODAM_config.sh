# Colors
RESET='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[0;35m'
CYAN='\033[1;36m'
WHITE='\033[0;37m'

# ---------------------------------------------------------	#
# 					PRELIMINARY CHECKS 						#
# -----------------------------------------	---------------	#

# ********** CHECK FOR VM  ************

# In Manage Software Center, install VirtualBox from icon


# ********** CHECK HOMEBREW **********

echo -e "\n$BLUE Checking for Homebrew version... $RESET"
command -v brew
if [ $? == 1 ]; then
	echo "I require Homebrew but it's not installed. Install and restart the terminal"
	echo "Aborting"
	exit 1
else
	echo "Brew is already installed\n"
fi
# In case is not installed, follow this link (brew without sudo)
# https://stackoverflow.com/questions/35775102/how-to-install-homebrew-packages-locally


# ********** CHECK KUBECTL **********

echo -e "\n$BLUE Checking for kubectl version... $RESET"
command -v kubectl
if [ $? == 1 ]; then
	echo "I require kubectl but it's not installed. Installing..."
	brew install kubectl
else
	echo "kubectl is already installed\n"
fi

# ********** CHECK MINIKUBE **********

echo -e "\n$BLUE Creating a link in goinfre for Minikube... $RESET"
command -v minikube
if [ $? == 1 ]; then
	echo "I require minikube but it's not installed. Installing..\n"
	brew install minikube
else
	echo "minikube is already installed\n"
fi

echo -e "\n$BLUE Creating a link in goinfre for minikube... $RESET"
rm -rf ~/.minikube
mkdir -p ~/goinfre/.minikube
ln -s ~/goinfre/.minikube ~/.minikube
echo -e "$GREEN minikube linking completed 👍\n$RESET"

# ********** CHECK DOCKER  **********

echo -e "\n$BLUE Creating a link in goinfre for Docker... $RESET"
rm -rf ~/Library/Containers/com.docker.docker
mkdir -p ~/goinfre/docker
ln -s ~/goinfre/docker ~/Library/Containers/com.docker.docker
echo -e "$GREEN docker linking completed 👍\n$RESET"
# ********** TEST FTPS WITHOUT FILEZILLA  **********

# ----- Install lftp ----
# brew install lftp

# ------ Run lftp ----
# 1. Go to your file location /Users/<INTRANAME>/Downloads

# 2. Type: 
# lftp ftp://grogu@192.168.99.36 -e "set ssl:verify-certificate false"

# 3. Type your password
# password: <type your password>

# 4. use 'put' command for to transfer your files
# lftp grogu@192.168.99.36 ~> put <your file>

# 5. use 'ls' command to list your transfered files
# lftp grogu@192.168.99.36 ~> ls


# ---------------------------------------------------------	#
# 							CLEANING 						#
# -----------------------------------------	---------------	#

# echo -e "\n$BLUE Starting Cleaning\n$RESET"

# # ********** REMOVING K8S OBJECTS **********

# echo -e "$PURPLE Deleting k8s deployments...$RESET"
# kubectl delete -f srcs/secrets.yaml
# kubectl delete -f srcs/metallb.yaml
# kubectl delete -f srcs/nginx/srcs/nginx.yaml
# kubectl delete -f srcs/wordpress/srcs/wordpress.yaml
# kubectl delete -f srcs/mysql/srcs/mysql.yaml
# kubectl delete -f srcs/phpmyadmin/srcs/phpmyadmin.yaml
# kubectl delete -f srcs/grafana/srcs/grafana.yaml
# kubectl delete -f srcs/influxdb/srcs/influxdb.yaml
# kubectl delete -f srcs/telegraf/srcs/telegraf.yaml

# # ********** REMOVING DOCKER OBJECTS **********
# docker container prune -f
# docker image prune -a --force

# # ********** REMOVING MINIKUBE **********
# minikube delete

# echo -e "\n$GREEN Cleaning completed 👍$RESET"
