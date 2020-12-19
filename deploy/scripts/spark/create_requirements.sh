#!/bin/bash

poetry export -f requirements.txt --dev --output tools/docker/spark/requirements.txt
