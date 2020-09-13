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

## Spark

I was inspired by this repository: https://github.com/testdrivenio/spark-kubernetes
However I have continued on the structure and made my own improvements.

### Docker

The container is available under `tools/docker/spark/Dockerfile.local.spark`.

It contains:

* python3.7
* spark 3.0.0

The command `minikube docker-env` returns a set of bash environment variable exports to configure
your local environment to re-use the Docker daemon inside the Minikube instance.
```bash
eval $(minikube docker-env)
```

```bash
docker build -t spark-hadoop:3.0.0 -f tools/docker/spark/Dockerfile.local.spark .
```

Tear up:
```bash
./tools/k8s/spark/create_local.sh
```

To tear down run:
```bash
./tools/k8s/spark/delete_local.sh
```

### Verify K8S Cluster

`Example`

```bash
  |  ~/c/deiteo | on   DEITEO-001-F…To-Worker(s) !1 ▓▒░ kubectl get pods
NAME                           READY   STATUS    RESTARTS   AGE
spark-worker-cb4fc9c8d-fhsxh   1/1     Running   0          53m
sparkmaster-cccbbdfcd-qktwq    1/1     Running   0          54m
>>
```

```bash
kubectl exec sparkmaster-cccbbdfcd-b7g2d -it -- spark-submit example_spark.py
```
