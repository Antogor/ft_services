#!/bin/bash

GREEN='\033[32m'
BLUE='\033[34m'
RED='\033[91m'
K8S='\033[35m'
ENDLINE='\033[0m'

#Start minikube
#minikube profile services
#minikube start
minikube start -p ft-services --disk-size='10000mb' --vm-driver='virtualbox'

#Install MetalLb
echo -e "${K8S}INSTALLING METALLB${ENDLINE}" >srcs/logs/configure.log
echo -e "${K8S}INSTALLING METALLB${ENDLINE}" 
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system >> srcs/logs/configure.log
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system >> srcs/logs/configure.log
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/namespace.yaml >> srcs/logs/configure.log
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/metallb.yaml >> srcs/logs/configure.log
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" >> srcs/logs/configure.log
## Start metalLB
kubectl apply -f srcs/metalLB/metalLB.yaml >> srcs/logs/configure.log
echo -e "${GREEN}METALLB INSTALLED\n${ENDLINE}" 

#Delete all previous configuration and nodes, ports, services, etc...
echo -e "${K8S}\nDELETING PREVIOUS CONFIGURATION${ENDLINE}" >>srcs/logs/configure.log
echo -e "${K8S}DELETING PREVIOUS CONFIGURATION${ENDLINE}" 
kubectl delete deployments --all >> srcs/logs/configure.log
kubectl delete svc --all >> srcs/logs/configure.log
echo -e "${GREEN}K8S PREVIUS CLEAN\n${ENDLINE}" 

#Building images
echo -e "${BLUE}\nPREPARING DOCKER AND IMAGES${ENDLINE}" >>srcs/logs/configure.log
echo -e "${BLUE}PREPARING DOCKER AND IMAGES${ENDLINE}"
eval $(minikube docker-env)
docker system prune -af >> srcs/logs/configure.log
docker build -t my_nginx srcs/nginx/ >> srcs/logs/configure.log
docker build -t my_ftps srcs/ftps/ >> srcs/logs/configure.log
docker build -t my_sql srcs/mysql/ >> srcs/logs/configure.log
docker build -t my_wordpress srcs/wordpress/ >> srcs/logs/configure.log
docker build -t my_php srcs/phpMyadmin/ >> srcs/logs/configure.log
echo -e "${GREEN}CONTAINERS READY\n${ENDLINE}"

#Start services
echo -e "${K8S}STARTING SERVICES"
kubectl apply -f srcs/configmaps/
kubectl apply -f srcs/secrets/
kubectl apply -f srcs/nginx/nginx_service.yaml
kubectl apply -f srcs/ftps/ftps.yaml
kubectl apply -f srcs/mysql/mysql_service.yaml
kubectl apply -f srcs/wordpress/wordpress_service.yaml
kubectl apply -f srcs/phpMyadmin/php_service.yaml
echo -e "${ENDLINE}${GREEN}\nFT_SERVICES READY${ENDLINE}"

#Dashboard
#minikube dashboard


