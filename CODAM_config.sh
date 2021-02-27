# Colors
RESET='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[0;35m'
CYAN='\033[1;36m'
WHITE='\033[0;37m'

# ********** CHECK FOR DOCKER DESKTOP & VM  **********

# In Manage Software Center, install VirtualBoxfrom and Docker icons


# ********** CHECK HOMEBREW **********

echo -e "$BLUE Checking for Homebrew version... $RESET"
command -v brew
if [ $? == 1 ]; then
	echo "I require Homebrew but it's not installed. Install and restart the terminal"
	echo "Aborting"
	exit 1
else
	echo "Brew is already installed"
fi
# In case is not installed, follow this link (brew without sudo)
# https://stackoverflow.com/questions/35775102/how-to-install-homebrew-packages-locally


# ********** CHECK KUBECTL **********

echo -e "$BLUE Checking for kubectl version... $RESET"
command -v kubectl
if [ $? == 1 ]; then
	echo "I require kubectl but it's not installed. Installing..."
	brew install kubectl
else
	echo "kubectl is already installed"
fi

# ********** CHECK MINIKUBE **********

echo -e "$BLUE Creating a link in goinfre for Minikube... $RESET"
command -v minikube
if [ $? == 1 ]; then
	echo "I require minikube but it's not installed. Installing.."
	brew install minikube
else
	echo "minikube is already installed"
fi

# rm -rf ~/.minikube
# mkdir -p ~/goinfre/.minikube
# ln -s ~/goinfre/.minikube ~/.minikube
# # export MINIKUBE_HOME=/Volumes/Storage/goinfre/<INTRANAME>/.minikube


# ********** CHECK DOCKER  **********

echo -e "$BLUE Creating a link in goinfre for Docker... $RESET"
# rm -rf ~/Library/Containers/com.docker.docker
# mkdir -p ~/goinfre/docker
# ln -s ~/goinfre/docker ~/Library/Containers/com.docker.docker

# ********** TEST FTPS WITHOUT FILEZILLA  **********

# brew install lftp