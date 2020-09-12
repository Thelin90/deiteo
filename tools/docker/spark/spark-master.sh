#!/bin/bash

. /common.sh

echo "$(hostname -i) sparkmaster" >> /etc/hosts
# We must set the IP address to the executors of the master pod, othewerwise we wil get the error
# inside master:
#
# 20/09/12 15:56:55 WARN TaskSchedulerImpl: Initial job has not accepted any resources; check your
# cluster UI to ensure that workers are registered and have sufficient resources
#
# When investigating the worker we can see:
# Caused by: io.netty.channel.AbstractChannel$AnnotatedConnectException: Connection timed out: s
#   parkmaster/10.101.97.213:34881
# Caused by: java.net.ConnectException: Connection timed out
#
# This means that when the spark-class ran, it was able to create the connection at init stage, but
# when pushing the spark-submit, it failed.
echo "spark.driver.host $(hostname -i)" >> /usr/local/spark/conf/spark-defaults.conf
echo "spark.driver.bindAddress $(hostname -i)" >> /usr/local/spark/conf/spark-defaults.conf

/usr/local/spark/bin/spark-class org.apache.spark.deploy.master.Master --host "$(hostname -i)" --port 7077 --webui-port 8080
