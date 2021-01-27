# **ft_services**
CODAM project Curriculum 2019

Topic: System Administration and Networking project.

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

- minikube start
- minikube dashboard
- minikube stop
- minikube profile <"profile's name">
- minikube delete -p <"profile's name">
- minikube config: displays a list of all params we can change
- minikube options:  displays a list of global command-line options (applies to all commands)
- minikube <"command"> --help
- minikube ip: show current ip.

### kubectl

:warning: Before start using this commands, be sure minikube is running.

To display all (namespaces, pods, etc)
```
kubectl get all
```
To list the current namespaces in a cluster
```
kubectl get namespaces
```
List the current pods:
```
kubectl get pods
```
List all pods in ps output format with more information (such as node name):
```
kubectl get pods -o wide
```

To list the current deployments:
```
kubectl get deployments
```
To list the current services:
```
kubectl get services
```
To list ingress:
```
kubectl get ingress
```
To display events with changes
```
kubectl get events -w
```
To allow to change between namespaces. Without the name, it will list all namespaces available.
```
kubens <"namespace's name">
```

#### Create Namespace / POD / Deployment / Service / Ingress

1. Using command line (for namespace)
```
kubectl create namespace <"namespace's name">
```

2. Using YALM or JSON file
```
kubectl apply -f <"file name">
```

3. From Dashboard on webpage (Except Ingress)

:warning: For Ingress, it's important to allow an addon
```
minikube addons enable ingress
```

#### Delete Namespace / Pod / Deployment / Service

1. Using command line (namespace/ pod)
```
kubectl delete namespace <"namespace's name">
```
```
kubectl delete namespace <"pod's name">
```

2. Using YALM or JSON file and command line
```
kubectl delete -f <"file name">
```

3. From Dashboard on webpage


#### PODs/ Deployment details

- To list the current pods in a cluster:
```
kubectl get pods
```
- To list the current deployment:
```
kubectl get deployments
```
- To list the deployment apps:
```
kubectl get deployments.apps
```
- To see details about a pod/ service:
```
kubectl describe pod <"pod name">
```
```
kubectl describe service <"service name">
```
- To see pod's logs:
```
kubectl logs -f <"file name">
```

#### Access to PODs

1.  Using command line
```
kubectl exec -it <"pod's name"> -- /bin/bash
```
Inside the pod, we can check which the Operating System is: cat /etc/*release
2. From Dashboard on webpage with 'Exec' option

##### Inside the pod

- To list the available hosts inside a pod:
```
cat /etc/hosts
```
- To see conexion between two pods (before you had to create a service)
```
ping mariadb-service
```
Kubernetes has a intern DNS, for that reason is able to resolve conexion between pods.

#### Create a Service

1. Using YALM or JSON file
```
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

## Useful links


- [Kubernetes overview](https://www.youtube.com/watch?v=7bA0gTroJjw)
- Kubernetes tutorial (in Spanish) - [Curso de Kubernetes Gratis -  Iñigo Serrano](https://www.youtube.com/playlist?list=PLrb1e2Mp6N_uJSNsV-7SqLFaBdImJsI5x)
- https://github.com/parismart/ft_services#ft_services
- [Readness and liveness in Kubernetes](https://medium.com/@AADota/kubernetes-liveness-and-readiness-probes-difference-1b659c369e17)


----

## General info

### Namespaces
Kubernetes supports multiple virtual clusters backed by the same physical cluster. These virtual clusters are called namespaces

#### When to Use Multiple Namespaces 
Namespaces are intended for use in environments with many users spread across multiple teams, or projects. For clusters with a few to tens of users, you should not need to create or think about namespaces at all.


### POD
Pods are the smallest deployable units of computing that you can create and manage in Kubernetes.

Pod is like a container.
Pod is the minimun unit of work.

A Pod is a group of one or more containers, with shared storage and network resources, and a specification for how to run the containers.

### DEPLOYMENT
A Deployment provides declarative updates for Pods and ReplicaSets.

### Services

Kubernetes Pods are mortal. They are born and when they die, they are not resurrected.
Kubernetes Pods are created and destroyed to match the state of your cluster. Pods are nonpermanent resources.
**ReplicaSets** create and destroy **Pods** dynamically 

A Service is an abstraction which defines a logical set of Pods and a policy by which to access them (sometimes this pattern is called a micro-service). The set of Pods targeted by a Service is usually determined by a selector.
Es el punto de entrada, siempre es fijo.

### Ingress

Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster. Traffic routing is controlled by rules defined on the Ingress resource.

							Internet
								|
							[Ingress]
							----|----
							[Services]

### Kubernetes Liveness and Readiness Probes

**Readiness** probes are designed to let Kubernetes know when the app is ready to serve traffic. Kubernetes makes sure the readiness probe passes before allowing a service to send traffic to the pod. If a readiness probe starts to fail, Kubernetes stops sending traffic to the pod until it passes.

Kubernetes uses **readiness probes** to decide when the container is available for accepting traffic. The readiness probe is used to control which pods are used as the backends for a service. A pod is considered ready when all of its containers are ready. If a pod is not ready, it is removed from service load balancers. For example, if a container loads a large cache at startup and takes minutes to start, you do not want to send requests to this container until it is ready, or the requests will fail—you want to route requests to other pods, which are capable of servicing requests.
_Una vez levantado el servicio, si esta en disposicion de aceptar o no peticiones._

Kubernetes uses **liveness probes** to know when to restart a container. If a container is unresponsive—perhaps the application is deadlocked due to a multi-threading defect—restarting the container can make the application more available, despite the defect. It certainly beats paging someone in the middle of the night to restart a container.
_Para saber si esta levantado el servicio_

### Configmap and secrets



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
