#!/bin/bash

docker build -t spark-hadoop-"$*":3.0.1 -f tools/docker/spark/Dockerfile .
