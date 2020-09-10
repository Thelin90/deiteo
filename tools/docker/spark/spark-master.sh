#!/bin/bash

. /common.sh

echo "~~~~~~~~~~~~"
cat /etc/hosts
echo "$(hostname -i) sparkmaster" >> /etc/hosts
cat /etc/hosts
echo "~~~~~~~~~~~~"

/usr/local/spark/bin/spark-class org.apache.spark.deploy.master.Master --host sparkmaster --port 7077 --webui-port 8080
