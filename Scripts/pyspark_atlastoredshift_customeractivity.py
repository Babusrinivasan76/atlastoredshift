# This script is used to migrate data from MongoDB Atlas to AWS Redshift using the Spark connectors
###import the lib
#import psycopg2

from pyspark import SparkContext
from pyspark.streaming import StreamingContext
from pyspark.sql import SparkSession
from pyspark.sql.functions import *

# create a local SparkSession
spark = SparkSession.\
        builder.\
        appName("streamingExampleRead").\
        config('spark.jars.packages', 'org.mongodb.spark:mongo-spark-connector:10.0.0').\
        getOrCreate()

#connection to the standar mongodb in atlas
rdd=(spark.read.format("mongodb")
        .option('spark.mongodb.connection.uri', 'mongodb+srv://<username>:<password>@<servername>/?retryWrites=true&w=majority') \
        .option('spark.mongodb.database', 'customer_activity') \
        .option('spark.mongodb.collection', 'source') \
.option('spark.mongodb.change.stream.publish.full.document.only','true') \
        .option("forceDeleteTempCheckpointLocation", "true") \
        .load())

## write the dataframe to Redshift
rdd.write.format('jdbc').options(
        url='jdbc:redshift://<redshift endpoint>:5439/<databasename>',
        driver='com.amazon.redshift.jdbc42.Driver',
        dbtable='public.customer_activity',
        user='<username>',
        password='<password>').mode('append').save()
