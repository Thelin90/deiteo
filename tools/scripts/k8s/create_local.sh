#!/bin/bash

echo "create -f ./tools/k8s/spark/spark-master-deployment.yaml"
kubectl create -f ./tools/k8s/spark/spark-master-deployment.yaml

echo "create -f ./tools/k8s/spark/spark-master-service.yaml"
sleep 3
kubectl create -f ./tools/k8s/spark/spark-master-service.yaml

echo "create -f ./tools/k8s/spark/spark-worker-deployment.yaml"
sleep 3
kubectl create -f ./tools/k8s/spark/spark-worker-deployment.yaml

echo "addons enable ingress"
sleep 1
minikube addons enable ingress
