import argparse
import os
import sys
from typing import Any, Dict

import py4j
from pyspark import SparkContext
from yaml import safe_load


def create_configuration(arguments: argparse.Namespace) -> Dict[str, Any]:
    with open(arguments.config, "r") as stream:
        return safe_load(stream=stream)


def create_logger(spark_context: SparkContext, log_level: str):
    spark_context.setLogLevel(log_level)
    log4j_logger = spark_context._jvm.org.apache.log4j
    return log4j_logger.LogManager.getLogger(__name__)


def get_spark_context() -> SparkContext:
    return SparkContext()


def word_split(logger: py4j.java_gateway.JavaObject, words: str):
    logger.info(f"LOGGER TYPE: {type(logger)}")

    seq = words.split()
    data = sc.parallelize(seq)
    collected_data = data.collect()
    counts = data.map(lambda word: (word, 1)).reduceByKey(lambda a, b: a + b).collect()
    counts = dict(counts)

    logger.info(
        f"\n\n~~~~~~~~~~~~~~~\n"
        f"EXAMPLE SPARK SCRIPT FOR DEITEO\n"
        f"SEQ={seq}\n"
        f"COLLECTED DATA = {collected_data}\n"
        f"COUNTS={counts}\n"
        f"~~~~~~~~~~~~~~~\n"
    )


if __name__ == "__main__":
    """Main file to start application under src"""
    parser = argparse.ArgumentParser("Deiteo Example Application")
    parser.add_argument(
        "--config",
        type=str,
        help="Location of the config YAML",
        required=False,
        default=f"{os.getcwd()}/config/deiteo.yaml",
    )
    parser.add_argument(
        "--local",
        type=bool,
        help="Running on local or k8s",
        required=True,
        default=False,
    )

    args = parser.parse_args()

    config = create_configuration(arguments=args)
    local = args.local

    if local:
        os.environ["PYSPARK_PYTHON"] = sys.executable
        os.environ["PYSPARK_DRIVER_PYTHON"] = sys.executable

    sc = get_spark_context()

    log = create_logger(spark_context=sc, log_level=config["log_level"])

    log.info(f"LOCAL RUN: {local}")

    word_split(logger=log, words=config["words"])

    sc.stop()
