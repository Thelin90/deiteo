#!/bin/bash

echo "Create the deployments and services:"
kubectl create -f ./tools/k8s/spark/spark-master-deployment.yaml
kubectl create -f ./tools/k8s/spark/spark-master-service.yaml

sleep 10
kubectl create -f ./tools/k8s/spark/spark-worker-deployment.yaml

minikube addons enable ingress
