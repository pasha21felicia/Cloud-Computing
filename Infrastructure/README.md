# Cloud-Computing
- Digori Parascovia
- Hirt Andrei-Cristian
- Piele Bogdan-Gabriel
## Application
Simple news application that allows to register a user/ login the user, add/delete/update articles.
In total 5 microservices build from the app:
- authentification
- backend
- frontend
- mysql
- adminer

### The Database
Is mysql, simple with 2 tables, Articles and Users, both authentification and backend services connect to the same mysql db.

-----
## Infrastructure

### Prerequsites for MacOS
1. install docker desktop
2. install minikube https://minikube.sigs.k8s.io/docs/start/
3. install terraform  https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
4. install minikube nginx controller https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/
5. install helm https://helm.sh/docs/intro/install/
6. Licence and account on portainer https://docs.portainer.io/start/install-ce/server/kubernetes/baremetal

-----
## Project setup

### Create Cluster Minikube:
```
minikube start --driver=docker --nodes 3 
```
### Install minikube nginx controller https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/
```
minikube addons enable ingress
minikube addons enable ingress-dns
```
### Add in /etc/hosts
```
    127.0.0.1    adminer.k8s.com
    127.0.0.1    frontend.k8s.com
    127.0.0.1    portainer.k8s.com
    127.0.0.1    prometheus.k8s.com
    127.0.0.1    grafana.k8s.com
```
### For deployment with terraform
```
    cd Infrastructure/terraform
    terraform init
    terraform apply --auto-approve
```
### Check optional: In terraform.tfvars the application images are taken from public dockerhub repository
```
   frontend_iamge = "pashadigori2000/cloud-computing:frontend-image-v1.0"
   backend_image  = "pashadigori2000/cloud-computing:backend-image-v1.0"
   auth_image     = "pashadigori2000/cloud-computing:auth-image-v1.0"
```
### Start minikube tunnel in a separate terminal
```
    minikube tunnel
```

## Access the application in the browser
### Access the frontend
```
    http://frontend.k8s.com 
```
### Access adminer
```
    http://adminer.k8s.com 
    # To login into database enter
    username: admin
    password: adminpass
    database: app_news
```

## Setup UI for cluster management

### Setup Portainer in a separate terminal
```
kubectl apply -n portainer -f https://downloads.portainer.io/ce2-19/portainer.yaml
minikube service portainer --url -n portainer
```
### Take one of the urls provided in the terminal and put it in the browser
```
## example of output
http://127.0.0.1:56324
http://127.0.0.1:56325
http://127.0.0.1:56326
❗  Because you are using a Docker driver on darwin, the terminal needs to be open to run it.
^C%
```
### Login in Portainer using credentials
```
username: admin
password: Adminpass123
```

## Setup Logging and monitoring for cluster

### Expose Prometheus in a separate terminal using port-forwarding
```
kubectl port-forward --namespace monitoring svc/prometheus-server 8080:80
```
### Access it from browser using:
```
http://prometheus.k8s.com/
or
127.0.0.1:8080
```

### Expose Grafana in a separate terminal using port-forwarding
```
kubectl port-forward --namespace monitoring svc/grafana 3000:80
```
### In a clean terminal run the command to find the username and password for grafana UI
```
# get username
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-user}" | base64 --decode 
# get password
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode
```
### Get the passwords and input them in the browser, normally the username is 'admin'
### Access it from browser using:
```
http://grafana.k8s.com/
or
127.0.0.1:3000
```
