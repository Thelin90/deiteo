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

.PHONY: update
update:
	pipenv update --dev --python 3.7

.PHONY: pre_commit_py37
pre_commit_py37:
	pipenv run pre-commit

.PHONY: test-ipdb
test-ipdb:
	pipenv run python -m pytest $(pytest_test_args) --cov-config=.coveragerc --cov=src tests/$(pytest_test_type) -s -v

.PHONY: test
test:
	pipenv run python -m pytest $(pytest_test_args) --cov-config=.coveragerc --cov=src tests/$(pytest_test_type) -v
