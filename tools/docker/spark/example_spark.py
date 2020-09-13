"""Example script to test spark functionality within the K8S cluster"""
from pyspark import SparkContext

# Extract SparkContext
sc = SparkContext()

# Perform some basic data operations
words = 'this is an example to run!'

sc.setLogLevel("INFO")
log4jLogger = sc._jvm.org.apache.log4j
LOGGER = log4jLogger.LogManager.getLogger(__name__)

seq = words.split()
data = sc.parallelize(seq)
collected_data = data.collect()
counts = data.map(lambda word: (word, 1)).reduceByKey(lambda a, b: a + b).collect()
counts = dict(counts)

LOGGER.info(
    f"\n\n~~~~~~~~~~~~~~~\n"
    f"EXAMPLE SPARK SCRIPT FOR DEITEO\n"
    f"SEQ={seq}\n"
    f"COLLECTED DATA = {collected_data}\n"
    f"COUNTS={counts}\n"
    f"~~~~~~~~~~~~~~~\n"
)

# Stop SparkSession
sc.stop()
