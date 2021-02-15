#!/bin/bash

GREEN='\033[32m'
BLUE='\033[34m'
RED='\033[91m'
K8S='\033[35m'
ENDLINE='\033[0m'

#Start minikube
#minikube profile services
#minikube start
minikube start --disk-size='10000mb' --vm-driver='virtualbox'
#minikube start -p ft-services --disk-size='10000mb' --vm-driver='virtualbox'
#minikube start --vm-driver=docker

#Install MetalLb
echo -e "${K8S}METALLB${ENDLINE}" >srcs/logs/configure.log

echo -e "${K8S}INSTALLING METALLB${ENDLINE}" 
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system > srcs/logs/configure.log 2>&1
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system > srcs/logs/configure.log 2>&1
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/namespace.yaml> srcs/logs/configure.log 2>&1
status=$?
if [ $status -ne 0 ]; then
	echo -e "${RED}Failed downloading namespace.yaml: $status ${ENDLINE}"
	exit $status
fi

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/metallb.yaml >srcs/logs/configure.log 2>&1
status=$?
if [ $status -ne 0 ]; then
	echo -e "${RED}Failed downloading metallb.yaml: $status ${ENDLINE}"
	exit $status
fi

kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" >srcs/logs/configure.log 2>&1
## Start metalLB
kubectl apply -f srcs/metalLB/metalLB.yaml
status=$?
if [ $status = 0 ]; then
	echo -e "${GREEN}METALLB INSTALLED\n${ENDLINE}" 
else
	echo -e "${RED}Failed appliying metallb: $status ${ENDLINE}"
	exit $status
fi

#Delete all previous configuration and nodes, ports, services, etc...
echo -e "${K8S}\nK8S CONFIGURATION${ENDLINE}">srcs/logs/configure.log 2>&1
echo -e "${K8S}DELETING PREVIOUS CONFIGURATION${ENDLINE}" 
kubectl delete -k srcs/ >srcs/logs/configure.log 2>&1
echo -e "${GREEN}K8S PREVIOUS CLEAN\n${ENDLINE}" 

#Building images
echo -e "${BLUE}\nDOCKER${ENDLINE}" >srcs/logs/configure.log 2>&1 
echo -e "${BLUE}PREPARING DOCKER AND IMAGES${ENDLINE}"
eval $(minikube docker-env)
docker system prune -af >srcs/logs/configure.log 2>&1
docker build -t my_nginx srcs/nginx/ >srcs/logs/configure.log 2>&1
status=$?
if [ $status -ne 0 ]; then
	echo -e "${RED}Failed creating nginx container: $status ${ENDLINE}"
	exit $status
fi
docker build -t my_ftps srcs/ftps/ >srcs/logs/configure.log 2>&1
status=$?
if [ $status -ne 0 ]; then
	echo -e "${RED}Failed creating ftps container: $status ${ENDLINE}"
	exit $status
fi
docker build -t my_sql srcs/mysql/ >srcs/logs/configure.log 2>&1
status=$?
if [ $status -ne 0 ]; then
	echo -e "${RED}Failed creating sql container: $status ${ENDLINE}"
	exit $status
fi
docker build -t my_wordpress srcs/wordpress/ >srcs/logs/configure.log 2>&1
status=$?
if [ $status -ne 0 ]; then
	echo -e "${RED}Failed creating wordpress container: $status ${ENDLINE}"
	exit $status
fi
docker build -t my_php srcs/phpMyadmin/ >srcs/logs/configure.log 2>&1
status=$?
if [ $status -ne 0 ]; then
	echo -e "${RED}Error creating php container: $status ${ENDLINE}"
	exit $status
fi
docker build -t my_influxdb srcs/influxDB/ >srcs/logs/configure.log 2>&1
status=$?
if [ $status -ne 0 ]; then
	echo -e "${RED}Error creating influxDB container: $status ${ENDLINE}"
	exit $status
fi
docker build -t my_telegraf srcs/telegraf/ >srcs/logs/configure.log 2>&1
status=$?
if [ $status -ne 0 ]; then
	echo -e "${RED}Error creating telegraf container: $status ${ENDLINE}"
	exit $status
fi
docker build -t my_grafana srcs/grafana/ >srcs/logs/configure.log 2>&1
status=$?
if [ $status -ne 0 ]; then
	echo -e "${RED}Error creating grafana container: $status ${ENDLINE}"
	exit $status
fi
echo -e "${GREEN}CONTAINERS READY\n${ENDLINE}"

#Start services
echo -e "${K8S}STARTING SERVICES"
kubectl apply -k srcs/
kubectl apply -f srcs/influxDB/influx_service.yaml
kubectl apply -f srcs/telegraf/telegraf_service.yaml
kubectl apply -f srcs/grafana/grafana_service.yaml
status=$?
if [ $status -eq 0 ]; then
	echo -e "${ENDLINE}${GREEN}\nFT_SERVICES READY${ENDLINE}"
else
	echo -e "${RED}Failed appliying yamls: $status ${ENDLINE}"
	exit $status
fi

/usr/bin/firefox 192.168.99.101

