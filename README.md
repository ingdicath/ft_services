# **ft_services**
CODAM project Curriculum 2019

- **Project type**: System Administration and Networking.
- **Objective**: Setting up an infrastructure of different services using **Kubernetes**.

----
## Requirements

 This proyect is aimed to set up a multi-service cluster. It must meet the following requirements:

- You must use Kubernetes
- Each service will have to _run in a dedicated container_.
- For performance reasons, containers have to be build using **Alpine Linux**.
- Containers will need to have a Dockerfile which is called in the *setup.sh* script.
- Build by yourself the images that the project will use.

Mandatory set ups:
- The _Kubernetes web dashboard_.
- The **Load Balancer(MetalLB)**.  It will be the only entry point to your cluster. Load Balancer will have a single ip.
- A **WordPress** website listening on port 5050, which will work with a MySQL database.
- **phpMyAdmin**, listening on port 5000 and linked with the **MySQL database (MariaDB)**.
- A container with an **nginx** server listening on ports 80 and 443.
- A **FTPS** server listening on port 21.
- A **Grafana** platform, listening on port 3000, linked with an _InfluxDB database_.

#### Restriccions

- It is forbidden to take already build images or use services like DockerHub.
- Usage of Node Port services, Ingress Controller object or kubectl port-forward command is prohibited.
----

## Prerequisites

:warning: For Windows, if you are using powershell, be sure to run as Administrator.

1. For Kubernetes commands: [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
2. For Kubernetes cluster:[Install minikube](https://minikube.sigs.k8s.io/docs/start/)
3. For Virtual Machine: [Install virtualBox](https://www.virtualbox.org/)
4. For testing FTP server is highly recommended: [Install FileZilla](https://filezilla-project.org/)

:wink: For testing in CODAM pcs, you can use _CODAM_config.sh_ script.

## Outputs

- VirtualBox
<p align="center"><img src="https://github.com/ingdicath/images_md/blob/main/VM_minikube.png" width="60%" height="60%"></p>

- Dashboard 
<p align="center"><img src="https://github.com/ingdicath/images_md/blob/main/deployments.png" width="60%" height="60%"></p>
<p align="center"><img src="https://github.com/ingdicath/images_md/blob/main/dash_services.png" width="60%" height="60%"></p>

- Nginx
<p align="center"><img src="https://github.com/ingdicath/images_md/blob/main/nginx.png" width="60%" height="60%"></p>

- Wordpress
<p align="center"><img src="https://github.com/ingdicath/images_md/blob/main/wordpress.png" width="60%" height="60%"></p>

- Phpmyadmin
<p align="center"><img src="https://github.com/ingdicath/images_md/blob/main/phpmyadmin.png" width="60%" height="60%"></p>

- Grafana
<p align="center"><img src="https://github.com/ingdicath/images_md/blob/main/grafana.png" width="60%" height="60%"></p>

- Filezilla
<p align="center"><img src="https://github.com/ingdicath/images_md/blob/main/filezilla.png" width="60%" height="60%"></p>

- Certificate - Filezila
<p align="center"><img src="https://github.com/ingdicath/images_md/blob/main/ft_services_certificate.png" width="50%" height="50%"></p>





