#!/bin/bash

. /common.sh

echo "~~~~~~~~~~~~"
echo getent hosts spark-master

if ! getent hosts spark-master; then
  echo "sleep"
  sleep 5
  exit 0
fi
echo "~~~~~~~~~~~~"

/usr/local/spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://spark-master:7077 --webui-port 8081

os.environ["PYSPARK_SUBMIT_ARGS"] = "--driver-memory 10g pyspark-shell"
