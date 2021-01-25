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

### kubectl

Before start using this commands, be sure minikube is running.

To list the current namespaces in a cluster
```
kubectl get namespace
```
To list the current pods:
```
kubectl get pod
```
To list the current deployments:
```
kubectl get deployment
```
To list the current services:
```
kubectl get service
```

#### Create Namespace / POD / Deployment / Service


1. Using command line (for namespace)
```
kubectl create namespace <"namespace's name">
```

2. Using YALM or JSON file
```
kubectl apply -f <"file name">
```

3. From Dashboard on webpage


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





----




## Useful links

- Kubernetes tutorial (in Spanish) - [Curso de Kubernetes Gratis -  Iñigo Serrano](https://www.youtube.com/playlist?list=PLrb1e2Mp6N_uJSNsV-7SqLFaBdImJsI5x)
- https://github.com/parismart/ft_services#ft_services

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

### Selectors

### Ingress

Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster. Traffic routing is controlled by rules defined on the Ingress resource.

							Internet
								|
							[Ingress]
							----|----
							[Services]




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
- Don't run user workloads on Master
- API server:  It's our front‑end into the master or the control plane. In fact, it's the only master component that we should be talking to. For example, it's the only one with a proper external facing interface. And you know what? Like all good things these days, it exposes a RESTful API, and it consumes JSON. Now how that looks in the real world is, right? We send it our manifest files, which we mentioned already. These declare the state of our app like a record of intent. The master validates it, and it attempts to deploy it on the cluster. Then there's the cluster store. Now if the API serves as the brains of the cluster, then the store is definitely its memory. So the config and the state of the cluster gets persistently stored in here. Right now it's etcd. Yes, there's been talk like forever about there being other options, but right now, etcd is where it's at. It's battle hardened and you know what? In my opinion, it is pretty production ready. Oh, hang on. This is, this is bad of me, actually. Apologies. If you don't know what etcd is, that's fine. So etcd is an open source distributed key value store. It's developed by the guys at CoreOS, and if key value stores aren't your things, it's a NoSQL database, but it's distributed, consistent, and watchable. And when I say consistent, right, I mean, yes, all copies can be written to, what they talk to each other and they work out consistency. But I'm getting sidetracked. Kubernetes uses etcd as the source of truth for the cluster. So it is vital with a capital everything right? No etcd or cluster store? No cluster. It'd be a bit like taking a person and like entirely wiping their memory, alright? They might be pretty to look at and full of potential, but they're not a lot of use right here and now. So make sure you protect this store and you've got a solid backup plan for it. Alright, so what have we got under here? Yes, the controller manager. This is a bit like a controller of controllers, if you will. And I don't know, dare I say a bit of a mini monolith? But I don't want to get hung up on detail like this, because this is the kind of thing that could easily change, especially with something like Kubernetes that's evolving and improving at a rate that only software can. But right now, this component implements a few features and functions that I wouldn't be surprised if at some point in the near future they get split out into separate and even plugable services. But right now, today okay, we've got a bunch of controllers: node controller, endpoints controller, names‑based controller. There's practically a controller for everything. And these guys all sit in a loop and they watch for changes, the aim of the game being to make sure that the current state of the cluster matches our desired state. But like we said, right now they are all managed by the controller manager. Ah! Okay, we've got the scheduler. This is a biggie, okay? It watches for new pods, and it assigns them to workers. And yes, that's the high level, right? But it's doing it a huge disservice, because it's got a ton of things to think about. So things like affinity and anti‑affinity, constraints, resource management. There's loads more, but I think that's probably enough for us. Now then, because the API server is our front end into the master and it's the only component in the master that we really deal directly with, well sometimes we fall into just calling this the master. So when we say things like, I don't know, maybe issue commands to the master or whatever, we actually mean issue commands to the API server. We just mix and much master and API server quite a lot in our lingo. I think the important thing to remember though is no other master components expose an endpoint for us. Just the API server, and by default that does it on port 443. So the master is the brains of Kubernetes. Commands and queries come into the API server component of the master, we can stick authentication on at this point; that's beyond the scope of this course though. We've not covered this yet, but commands come in usually via the kubectl command line utility, but they're formatted as JSON. Then there's a bit of chatter that goes on between all these components here, and depending on what's going on, commands and action items make their way to nodes over here. Speaking of which, nodes.

### NODES

#### Kubelet -> Main Kubernetes agent
- the main Kubernets agent. The kubelet is the node
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
