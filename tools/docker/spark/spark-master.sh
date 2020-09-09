#!/bin/bash

. /common.sh

echo "~~~~~~~~~~~~"
echo "$(hostname -i) spark-master" >> /etc/hosts
echo cat /etc/hosts
echo "~~~~~~~~~~~~"

/usr/local/spark/bin/spark-class org.apache.spark.deploy.master.Master --ip spark-master --port 7077 --webui-port 8080
