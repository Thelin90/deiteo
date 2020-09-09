# deiteo

Deiteo (데이터) means `data` in korean. This project builds up an environment consisting of, spark,
kubernetes and kafka.

To enable a streaming platform utilising `spark structured streaming`.

# Requirements

* pipenv
* docker
* kubectl
* minikube

# Local Environment Setup

```bash
docker-desktop -> preferences -> Kubernetes -> Enable Kubernetes

Make sure to set memory above 8192, may need to restart docker-desktop
```

## Kubectl

Install `kubectl`:
```bash
brew install kubectl
```

Test to ensure the version you installed is up-to-date:
```bash
kubectl version --client
```

## Minikube

Install `minikube`:
```bash
brew install minikube
```

Start `minikube`:
```bash
minikube start --memory 8192 --cpus 4 --vm=true
```

Enable `minikube` `dashboard`:
```bash
minikube dashboard
```

# Deploy to local K8S

## Docker

The command `minikube docker-env` returns a set of bash environment variable exports to configure
your local environment to re-use the Docker daemon inside the Minikube instance.
```bash
eval $(minikube docker-env)
```

```bash
docker build -t spark-hadoop:3.0.0 -f tools/docker/spark/Dockerfile.local.spark .
```

Then
```bash
./tools/k8s/spark/create_local.sh
```
