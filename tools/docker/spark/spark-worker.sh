#!/bin/bash

. /common.sh

getent hosts sparkmaster

if ! getent hosts sparkmaster; then
  sleep 5
  exit 0
fi

/usr/local/spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://sparkmaster:7077 --webui-port 8081

echo "org.apache.spark.deploy.worker.Worker set"

os.environ["PYSPARK_SUBMIT_ARGS"] = "--driver-memory 10g pyspark-shell"
