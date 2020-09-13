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

## pipenv

This project utilises `pipenv`, due to its correctness, and nice features with dependency checks
via the `Pipfile.lock`. It also enables us to control the Python environment in a nice modular
way.

If a new `library` is added to the `Pipfile`, then run:

```bash
make update
```

Note:

`to update the spark docker container, if a new package is added to Pipefile and a new Pipfile.lock is created run:`

```bash
make update_spark_docker_python_requirements
```

This will install the packages from `packages` and not from `dev-packages`.

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
make build_spark_docker
```

Tear up:
```bash
make deploy_spark_k8s_cluster
```

`I have for some reason noticed that it does not work when I do this in the script, so run this
stand alone for now!`

```bash
kubectl apply -f ./tools/k8s/spark/minikube-ingress.yaml
```

Then run:

```bash
echo "$(minikube ip) sparkkubernetes" | sudo tee -a /etc/hosts
```

To tear down run:
```bash
make delete_spark_k8s_cluster
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
