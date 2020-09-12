"""Example script to test spark functionality within the K8S cluster"""
import logging
from pyspark import SparkContext

# Create logger
LOGGER = logging.getLogger(__name__)

# Perform some basic data operations
words = 'this is an example to run!'
sc = SparkContext()
seq = words.split()
data = sc.parallelize(seq)
collected_data = data.collect()
counts = data.map(lambda word: (word, 1)).reduceByKey(lambda a, b: a + b).collect()
counts = dict(counts)

LOGGER.info(
    f"~~~~~~~~~~~~~~~\n"
    f"EXAMPLE SPARK SCRIPT FOR DEITEO\n"
    f"SEQ={seq}\n"
    f"COLLECTED DATA = {collected_data}\n"
    f"COUNTS={counts}\n"
    f"~~~~~~~~~~~~~~~\n"
)

# Stop SparkSession
sc.stop()