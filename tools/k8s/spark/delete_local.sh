#!/bin/bash

kubectl delete -f ./tools/k8s/spark/spark-master-deployment.yaml
kubectl delete -f ./tools/k8s/spark/spark-master-service.yaml
kubectl delete -f ./tools/k8s/spark/spark-worker-deployment.yaml
kubectl delete -f ./tools/k8s/spark/minikube-ingress.yaml
