export APP := deiteo

build: clean install install-pre-commit

build-docker: create_docker_spark_requirements build_spark_docker

.PHONY: install
install:
	poetry env use 3.9.1
	poetry install

.PHONY: update
update:
	poetry update

.PHONY: clean
clean:
	rm -rf build dist .eggs *.egg-info
	rm -rf .benchmarks .coverage coverage.xml htmlcov report.xml .tox
	find . -type d -name '.mypy_cache' -exec rm -rf {} +
	find . -type d -name '__pycache__' -exec rm -rf {} +
	find . -type d -name '*pytest_cache*' -exec rm -rf {} +
	find . -type f -name "*.py[co]" -exec rm -rf {} +

.PHONY: poetry-info
poetry-info:
	poetry env info
	poetry show --tree

.PHONY: install-pre-commit
install-pre-commit:
	poetry run pre-commit clean
	poetry run pre-commit install

.PHONY: pre-commit
pre-commit:
	poetry run pre-commit run --all-files

.PHONY: run-example-pyspark
run-example-pyspark:
	poetry run python src/example_spark.py --local $(local)

.PHONY: test
test:
	poetry run python -m pytest tests/$(type)/ --cov-config=tests/coverage/$(type)/.coveragerc --cov=. --quiet $(test_argument)

.PHONY: create_docker_spark_requirements
create_docker_spark_requirements:
	./deploy/scripts/spark/create_requirements.sh

.PHONY: build_spark_docker
build_spark_docker:
	 eval ./deploy/scripts/spark/build_spark_docker.sh $(APP)

.PHONY: run-example-pyspark-docker
run-example-pyspark-docker:
	docker run -it spark-hadoop-deiteo:3.0.1 /bin/bash -c "spark-submit --master local example_spark.py --config deiteo.yaml --local False"

.PHONY: deploy_spark_k8s_cluster
deploy_spark_k8s_cluster:
	 ./deploy/scripts/k8s/create_local_spark.sh

.PHONY: delete_spark_k8s_cluster
delete_spark_k8s_cluster:
	 ./deploy/scripts/k8s/delete_local_spark.sh
