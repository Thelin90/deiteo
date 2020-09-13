include .env

build: clean pythonpath deps

.PHONY: clean
clean:
	-find . -type f -name "*.pyc" -delete
	-find . -type f -name "*.cover" -delete

.PHONY: deps
deps:
	pipenv sync --dev --python 3.7

.PHONY: pythonpath
pythonpath:
	 echo "PYTHONPATH=${PWD}/src/" >> .env

.PHONY: update_spark_docker_python_requirements
update_spark_docker_python_requirements:
	 ./tools/scripts/spark/create_requirements.sh

.PHONY: update
update:
	pipenv update --dev --python 3.7

.PHONY: pre_commit_py37
pre_commit_py37:
	pipenv run pre-commit

.PHONY: test_ipdb
test-ipdb:
	pipenv run python -m pytest $(pytest_test_args) --cov-config=.coveragerc --cov=src tests/$(pytest_test_type) -s -v

.PHONY: test
test:
	pipenv run python -m pytest $(pytest_test_args) --cov-config=.coveragerc --cov=src tests/$(pytest_test_type) -v

.PHONY: build_spark_docker
build_spark_docker:
	 ./tools/scripts/spark/build_spark_docker.sh

.PHONY: deploy_spark_k8s_cluster
deploy_spark_k8s_cluster:
	 ./tools/scripts/k8s/create_local.sh

.PHONY: delete_spark_k8s_cluster
delete_spark_k8s_cluster:
	 ./tools/scripts/k8s/delete_local.sh
