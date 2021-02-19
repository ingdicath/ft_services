# **ft_services**
CODAM project Curriculum 2019

- **Project type**: System Administration and Networking.
- **Objective**: Setting up an infrastructure of different services using **Kubernetes**.

----
## Requirements

 This proyect is aimed to set up a multi-service cluster. It must meet the following requirements:

- Each service will have to _run in a dedicated container_.
- Each container must bear the same name as the service concerned.
- For performance reasons, containers have to be build using **Alpine Linux**.
- Containers will need to have a Dockerfile which is called in the setup.sh
- Build by yourself the images that the project will use.

Mandatory set ups:
- The _Kubernetes web dashboard_.
- The **Load Balancer(MetalLB)**.  It will be the only entry point to your cluster. Load Balancer will have a single ip.
- A **WordPress** website listening on port 5050.
- **phpMyAdmin**, listening on port 5000 and linked with the **MySQL database (MariaDB)**.
- A container with an **nginx** server listening on ports 80 and 443.
- A **FTPS** server listening on port 21.
- A **Grafana** platform, listening on port 3000, linked with an _InfluxDB database_.

#### Restriccions

- It is forbidden to take already build images or use services like DockerHub.
- Usage of Node Port services, Ingress Controller object or kubectl port-forward command is prohibited.
----

## Prerequisites :warning:

For Windows and if you are using powershell, be sure to run as Administrator.

### 1. Install kubectl
- [Tutorial kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### 2. Install minikube
- [Tutorial minikube](https://minikube.sigs.k8s.io/docs/start/)

----
## Basic commands

### minikube

```
# Start
minikube start
# Display dashboard
minikube dashboard
# Stop minikube
minikube stop
# Display profile
minikube profile <"profile's name">
# Delete profile
minikube delete -p <"profile's name">
# List all params we can change
minikube config
# Display a list of global command-line options (applies to all commands)
minikube options
# List help options
minikube <"command"> --help
# Display current ip
minikube ip
# List available addons
minikube addons list
```

### kubectl

:warning: Before start using this commands, be sure minikube is running.
```
# Display all (namespaces, pods, etc)
kubectl get all
# List the current namespaces in a cluster
kubectl get namespaces
# List current pods:
kubectl get pods
# List all pods in ps output format with more information (such as node name):
kubectl get pods -o wide
# List the current deployments:
kubectl get deployments
# List the current services:
kubectl get services
# List ingress:
kubectl get ingress
# Display events with changes
kubectl get events -w
# Allow to change between namespaces. Without the name, it will list all namespaces available.
kubens <"namespace's name">
# Displays IPs
kubectl get pod -o wide
```

#### Create Namespace / POD / Deployment / Service / Ingress

```
# Using command line (for namespace)
kubectl create namespace <"namespace's name">
#Using YALM or JSON file
kubectl apply -f <"file name">
```
- From Dashboard on webpage (Except Ingress)

:warning: For Ingress, it's important to allow an addon
```
minikube addons enable ingress
```

#### Delete Namespace / Pod / Deployment / Service
```
# Using command line (namespace/ pod)
kubectl delete namespace <"namespace's name">
# Using YALM or JSON file and command line
kubectl delete -f <"file name">
```
- From Dashboard on webpage


#### PODs/ Deployment details

```
# List the current pods in a cluster
kubectl get pods
# List the current deployment
kubectl get deployments
# List the deployment apps
kubectl get deployments.apps
# Display details about a pod/ service
kubectl describe pod <"pod name">
kubectl describe service <"service name">
# Display pod's logs:
kubectl logs -f <"file name">
```

#### Access to PODs
```
# Using command line
kubectl exec -it <"pod's name"> -- /bin/bash
# Check which the Operating System is (inside the pod) 
cat /etc/*release
# List the available hosts(inside the pod)
cat /etc/hosts
# Display conexion between two pods (inside the pod; before you had to create a service)
ping mariadb-service
#Kubernetes has a intern DNS, for that reason is able to resolve conexion between pods.
```

#### Create a Service
```
#Using YALM or JSON file
kubectl apply -f <"file name">
```

### Run on Windows

Using the docker motor inside the minikube

1. Run in the terminal:
```
minikube docker-env
```
2. Check what do you need to run
```
# To point your shell to minikube's docker-daemon, run:
# & minikube -p minikube docker-env | Invoke-Expression
```
3. Then, run:
```
docker ps
```

#### Mount a volume, set working directory, execute command
```
 docker run -it --rm --name my-maven-project -v /c/Users/diani/kuber_practice/Bloque11Aplicacion/aplicacion:/usr/src/mymaven -w /usr/src/mymaven maven:3.3-jdk-8 mvn clean install
```

----
## How to start with this project

1. Start with the data bases MySQL, InfluDX (telegraf)
2. Wordpress, PHPmyadmin, Grafana
3. Ngnix, ftps

## Useful links

- [Kubernetes overview](https://www.youtube.com/watch?v=7bA0gTroJjw)
- [Kubernetes tutorial (in Spanish) -  Iñigo Serrano](https://www.youtube.com/playlist?list=PLrb1e2Mp6N_uJSNsV-7SqLFaBdImJsI5x)
- [Kubernetes explained in 15 min](https://www.youtube.com/watch?v=VnvRFRk_51k&amp%3Bindex=1)
- https://github.com/parismart/ft_services#ft_services
- [Readness and liveness in Kubernetes](https://medium.com/@AADota/kubernetes-liveness-and-readiness-probes-difference-1b659c369e17)
- [MetalLB installation](https://metallb.universe.tf/installation/)
- [MetalLB IP Address Sharing](https://metallb.universe.tf/usage/)
- [MetalLB yaml](https://metallb.universe.tf/configuration/)
- [Install brew without sudo](https://stackoverflow.com/questions/35775102/how-to-install-homebrew-packages-locally)
- [Setup profile](https://superuser.com/questions/187639/zsh-not-hitting-profile)
- [Adding username in Linux](https://linux.die.net/man/8/adduser)
- [Understanding how uid and gid work in Docker containers](https://medium.com/@mccode/understanding-how-uid-and-gid-work-in-docker-containers-c37a01d01cf)
- [Explanation about certificates](https://www.shellhacks.com/create-csr-openssl-without-prompt-non-interactive/)
- [About OpenSSH authentication - Needed for previous project versions](http://www.manpagez.com/man/1/ssh-keygen/)
- https://github.com/tishj/ft_services
- [How To Install Nginx web server on Alpine Linux](https://www.cyberciti.biz/faq/how-to-install-nginx-web-server-on-alpine-linux/)

- [Alpine packages](https://pkgs.alpinelinux.org/packages)
- [Advantages of --no cache](https://stackoverflow.com/questions/49118579/alpine-dockerfile-advantages-of-no-cache-vs-rm-var-cache-apk/49119046)

### yaml
- [yaml files examples](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/)


### VSFTPD (Very Secure File Transfer Protocol Daemon)
- [vsftpd.conf(5) - Linux man page](https://linux.die.net/man/5/vsftpd.conf)
- [vsftpd.conf parameters](http://vsftpd.beasts.org/vsftpd_conf.html)
- [vsftpd](https://security.appspot.com/vsftpd.html)
- [Build a FTP Server on GCP VM with vsftpd](https://medium.com/learn-or-die/build-a-ftp-server-on-gcp-vm-with-vsftpd-e140f81da575)
- [How To Set Up vsftpd](https://www.digitalocean.com/community/tutorials/how-to-set-up-vsftpd-for-a-user-s-directory-on-ubuntu-16-04)
- [vsftpd.conf reference](https://github.com/epoweripione/docker-vsftpd-alpine/blob/master/vsftpd.conf)
- [FTP over SSL Clients (FTPS)](https://studentclearinghouse.info/ftphelp/knowledge-base/configuring-your-firewall-settings/#ssl)

### telegraf
- [Download telegraf for Alpine](https://github.com/influxdata/telegraf/releases)
- [Configuring Telegraf](https://docs.influxdata.com/telegraf/v1.15/administration/configuration/)
- [Configuration github](https://github.com/influxdata/telegraf/blob/master/docs/CONFIGURATION.md)
- [Set Up Telegraf, InfluxDB, & Grafana on Kubernetes](https://blog.gojekengineering.com/diy-set-up-telegraf-influxdb-grafana-on-kubernetes-d55e32f8ce48)
- [telegraf for Alpine](https://dl-cdn.alpinelinux.org/alpine/edge/community/)
- [Downloads influxdb, telegraf](https://portal.influxdata.com/downloads/)

### Grafana
- [Configuration](https://grafana.com/docs/grafana/latest/administration/configuration/)
- [Dashboards](https://grafana.com/docs/grafana/latest/administration/provisioning/#dashboards)
- [Using InfluxDB in Grafana](https://grafana.com/docs/grafana/latest/datasources/influxdb/)
- [Download grafana](https://grafana.com/grafana/download?platform=linux)
- https://github.com/grafana/grafana/blob/master/packaging/docker/Dockerfile
- https://github.com/grafana/grafana/blob/master/Dockerfile
### 
- [Set up localhost windows](https://stackoverflow.com/questions/42866013/docker-toolbox-localhost-not-working/45822356#45822356)

### mysql
- [Expose port](https://kinsta.com/knowledgebase/mysql-port/)
- [MySQL Port Reference Tables](https://dev.mysql.com/doc/mysql-port-reference/en/mysql-ports-reference-tables.html)
- Docker windows local ip 192.168.99.100

### Others
- https://github.com/VictorTennekes/ft_services

### PHP
- [phpMyAdmin blowfish secret generator](https://phpsolved.com/phpmyadmin-blowfish-secret-generator/?g=[insert_php]echo%20$code;[/insert_php])

### Nginx
- [How To Configure Nginx to Use Custom Error Pages](https://www.digitalocean.com/community/tutorials/how-to-configure-nginx-to-use-custom-error-pages-on-ubuntu-14-04)

### Configmap and secrets
- [How to create a Secret with base64 encode values](https://dev4devs.com/2019/10/22/kubernetes-how-to-create-a-secret-with-base64-encode-values-is-it-safe-to-store-confidential-information/)
-----

## Concepts

### Namespaces
Kubernetes supports multiple virtual clusters backed by the same physical cluster. 
These virtual clusters are called namespaces.

##### When to Use Multiple Namespaces 
Namespaces are intended for use in environments with many users spread across multiple teams, or projects. 
For clusters with a few to tens of users, you should not need to create or think about namespaces at all.


### Pod

- Pods are the smallest deployable units of computing that you can create and manage in Kubernetes.
- Pod is like a container.
- Pod is the minimun unit of work.
- A Pod is a group of one or more containers, with shared storage and network resources, and a specification for how to run the containers.

### Deployment

A Deployment provides declarative updates for Pods and ReplicaSets.


### Services

- Kubernetes Pods are created and destroyed to match the state of your cluster. Pods are nonpermanent resources.
- **ReplicaSets** create and destroy **Pods** dynamically 

A Service is an abstraction which defines a logical set of Pods and a policy by which to access them (sometimes this pattern is called a micro-service). The set of Pods targeted by a Service is usually determined by a selector.
Es el punto de entrada, siempre es fijo.

### Ingress

Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster. Traffic routing is controlled by rules defined on the Ingress resource.

							Internet
							    |
							[Ingress]
							----|----
							[Services]

### Liveness and Readiness Probes

**Readiness** probes are designed to let Kubernetes know when the app is ready to serve traffic. Kubernetes makes sure the readiness probe passes before allowing a service to send traffic to the pod. If a readiness probe starts to fail, Kubernetes stops sending traffic to the pod until it passes.

Kubernetes uses **readiness probes** to decide when the container is available for accepting traffic. The readiness probe is used to control which pods are used as the backends for a service. A pod is considered ready when all of its containers are ready. If a pod is not ready, it is removed from service load balancers. For example, if a container loads a large cache at startup and takes minutes to start, you do not want to send requests to this container until it is ready, or the requests will fail—you want to route requests to other pods, which are capable of servicing requests.
_Una vez levantado el servicio, si esta en disposicion de aceptar o no peticiones._

Kubernetes uses **liveness probes** to know when to restart a container. If a container is unresponsive—perhaps the application is deadlocked due to a multi-threading defect—restarting the container can make the application more available, despite the defect. It certainly beats paging someone in the middle of the night to restart a container.
_Para saber si esta levantado el servicio_



----




Masters
Nodes
Pods
Services
Deployments

Kubernetes is an orchestrator for microservice apps

- **Masters**: there are in charge
- **Nodes**: are minions, they are doing the work
We've got the code, and we containerize it. And, we define it in an object call a deployment, then we write it up and define in a YAML file.

Then we give the file to K8s on the master, and the master looks at the file and deploys the app on the cluster. 

### MASTERS
- :warning: Don't run user workloads on Master
- API server:  It's our front‑end into the master or the control plane.
	Kubernetes API server: main part of Master.


### NODES

#### Kubelet -> Main Kubernetes agent
- The kubelet is the primary "node agent" that runs on each node.
- Registers node with cluster
- Watches apiserver
- Instantiates pods
- Reports back to master
- Exposes endpoint on :10255

If a pod fails on a node, the kubelet is not resposible for restarting it or finding another node  for it to run. It simply reports the state back to the master. 


#### Container Engine -> Docker or rocket
##### Does container management:
- pulling images
- starting/stopping containers

##### Pluggable
- Usually Docker
- Can be CoreOS rkt (rocket)


#### kube-proxy -> Kubernetes working
Is like the network brains of the node

##### Kubernetes networking
- Pod IP addresses
	- All containers in a pod share a single IP


### Declarative model & Desired State

Kubernetes operates in a declarative model. This means we give the API server manifest files that describe how we want the cluster to look and feel. YAML or JSON

### PODS

- Kubernetes run containers always inside of pods.
- A container without a pod in Kubernetes is a naked container.
- Pods can have multiple containers (advanced use-case)
- Pod is a ring-fenced (cercado) environment to run containers. Itself doesn't run anything. It can have 1) Network stack, 2) Kernel namespaces, etc,  n containers.
- All containerss in pod share the pod environment


## TIPS

### Fix error: nginx: [emerg] open() "/run/nginx/nginx.pid" failed (2: No such file or directory), running:
RUN mkdir -p /run/nginx

### To check to see what was running on port
```
netstat -tulpn
```