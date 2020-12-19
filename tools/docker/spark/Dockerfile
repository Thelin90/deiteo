FROM python:3.9.1

# PATH
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Spark
ENV SPARK_VERSION 3.0.1
ENV SPARK_HOME /usr/local/spark
ENV SPARK_LOG_DIR /var/log/spark
ENV SPARK_PID_DIR /var/run/spark
ENV PYSPARK_PYTHON /usr/local/bin/python
ENV PYSPARK_DRIVER_PYTHON /usr/local/bin/python
ENV PYTHONUNBUFFERED 1
ENV HADOOP_COMMON org.apache.hadoop:hadoop-common:2.7.7
ENV HADOOP_AWS org.apache.hadoop:hadoop-aws:2.7.7

# Java
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

# Install curl
RUN apt-get update && \
    apt-get install --no-install-recommends -y curl=7.64.0-4+deb10u1 && \
    apt-get install --no-install-recommends -y procps=2:3.3.15-2 && \
    rm -rf /var/lib/apt/lists/*;

# Install properties common
RUN apt-get update && \
    apt-get install --no-install-recommends -y software-properties-common=0.96.20.2-2 && \
    rm -rf /var/lib/apt/lists/*;

# Add Java8
RUN apt-add-repository "deb http://security.debian.org/debian-security stretch/updates main" && \
    apt-get update && \
    apt-get install --no-install-recommends -y openjdk-8-jdk=8u272-b10-0+deb9u1 && \
    rm -rf /var/lib/apt/lists/*;

# Create man and clear java installer cache
RUN apt-get update && \
    mkdir -p /usr/share/man/man1 && \
    apt-get install --no-install-recommends -y ant=1.10.5-2 && apt-get clean && \
    rm -rf /var/cache/oracle-jdk8-installer && rm -rf /var/lib/apt/lists/*;

# Download Spark, enables full functionality for spark-submit against docker container
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl http://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz | \
        tar -zx -C /usr/local/ && \
        ln -s spark-${SPARK_VERSION}-bin-hadoop2.7 ${SPARK_HOME}

# add scripts and update spark default config
COPY tools/docker/spark/common.sh tools/docker/spark/spark-master.sh tools/docker/spark/spark-worker.sh /
COPY src/example_spark.py tools/docker/spark/requirements.txt /
COPY config/deiteo.yaml /

RUN chmod +x /common.sh /spark-master.sh /spark-worker.sh

COPY tools/docker/spark/spark-defaults.conf ${SPARK_HOME}/conf/spark-defaults.conf
ENV PATH $PATH:${SPARK_HOME}/bin

RUN python -m pip install pip==20.3.3 && \
    python -m pip install -r requirements.txt;

