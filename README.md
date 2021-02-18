# deiteo

Deiteo (데이터) means `data` in korean. This project builds up an environment consisting of, spark,
kubernetes.

This project sets up a `k8s` cluster and deploys a `spark` docker container within the cluster with a `master` and 
a configurable amount of `workers`.

[Official spark doc](https://spark.apache.org/docs/latest/running-on-kubernetes.html)

The project has an example application that can be run locally and from within the cluster.

The main idea however with this repository, is to create a `k8s` `spark` cluster which you can deploy `spark` applications against, either `pyspark` or `scala` applications.

# Requirements

* poetry
    * curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
    * `source $HOME/.poetry/env`
* docker
* python3.9.1
* kubectl
* minikube

## Sonarcloud

Project uses `sonarcloud` to measure quality.

## Setup

For a fresh initial install, depending on the `pyproject.lock`:

```bash
make build
```

If a new dependency is added, or removed, the `pyproject.lock` needs to be updated:

```bash
make update
```

### Kubectl

Install `kubectl`:
```bash
brew install kubectl
```

Test to ensure the version you installed is up-to-date:
```bash
kubectl version --client
```

### Minikube

Install `minikube`:
```bash
brew install minikube
```

### PyCharm

Note that you will need at least `PyCharm` version `2020.3`.

[Install Plugin to IDE Here!](https://plugins.jetbrains.com/plugin/14307-poetry)

Enter:

```bash
Preferences -> Python Interpreter -> Add -> Poetry Environment -> Existing Environment (`if you ran make build it will automatically find it`)
```

## Tests

### coverage

To see what specific configuration that has been made to the `pytest` test, please look at:

`.coveragec` and `pytest.ini`, for more info read:

* [pytest](https://readthedocs.org/projects/pytest-cov/downloads/pdf/latest/)
* [pytest-cov with .coveragec](https://pytest-cov.readthedocs.io/en/latest/config.html)

Example output:
```json
Name                                                    Stmts   Miss  Cover   Missing
-------------------------------------------------------------------------------------
test_0                                                   43      3    93%   34-35, 39
. . .
test_N                                                   51     39    24%   21-30
-------------------------------------------------------------------------------------
TOTAL                                                    94     43    51%
```

* Stmts - Total lines of code in a specific file
* Miss - Total number of lines that are not covered
* Cover - Percentage of all line of code that are covered, or (Stmts - Miss) / 100
* Missing - Lines of codes that are not covered

### .coverage config

To modify the `.coverage` file for `unit` then modify `tests/coverage/unit/.coveragerc` or
`tests/coverage/integration/.coveragerc`.

They are separated because you might wanna exclude specific code via the `omit` based on if `unit` is `integration`
are running.

### Unit

```bash
make test type=unit
```

### Integration

```bash
make test type=integration
```

#### ipdb

If you want to run with `debug mode with ipdb` directly from the console:

Example:
```bash
make test type=unit test_argument=-s
```

```python
class Something:
    def __init__(self):
        import ipdb
        ipdb.set_trace()
        self.foo = "foo"
```

* `n to step forward`
* `s to step into`
* `type any variable name while stepping to inspect it`

# Deployment

## Spark

Please enter the link here: [spark deployment on k8s](deploy/README.md) to proceed with
setting up `spark` on `k8s` needed for this project.
