1. install minikube https://minikube.sigs.k8s.io/docs/start/
2. install terraform  https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
3. install minikube nginx controller https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/
4. install helm https://helm.sh/docs/intro/install/

Rulare:
1. Creare cluster
    minikube start --driver=docker --nodes 3 
2. install minikube nginx controller https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/
3. adauga in /etc/hosts
    127.0.0.1    adminer.k8s.com
    127.0.0.1    frontend.k8s.com
    127.0.0.1    portainer.k8s.com
    127.0.0.1    prometheus.k8s.com
    127.0.0.1    grafana.k8s.com
4. Dockerfile din frontend contine Dockerfile-prod 
5. Creezi imaginile de docker si pe push-uiesti in dockerhub, exemplu:
   docker build -t pashadigori2000/cloud-computing:auth-image-v1 ./authentification
   docker push pashadigori2000/cloud-computing:auth-image-v1
5. Vezi sa ai imagini in docker hub pentru authentification, backend si frontend 
6. In terraform.tfvars vezi sa ai path-ul la imaginile de docker corecte 
   frontend_iamge = "pashadigori2000/cloud-computing:frontend-image-v1.0"
   backend_image  = "pashadigori2000/cloud-computing:backend-image-v1.0"
   auth_image     = "pashadigori2000/cloud-computing:auth-image-v1.0"
7. Pentru deployment cu terraform
    cd terraform
    terraform init
    terraform apply --auto-approve
8. Porneste minikube tunnel dintr-un terminal
    minikube tunnel
9. Expose Prometheus, Intr-un terminal separat ruleaza https://getbetterdevops.io/terraform-with-helm/
    kubectl port-forward --namespace monitoring svc/prometheus-server 8080:80 
10. Go to http://localhost:8080 to access the Prometheus UI
11. 
    