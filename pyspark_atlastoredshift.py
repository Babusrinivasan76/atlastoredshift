###import the lib
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
#update the SRV connection details with correct user , password and server details.
#update the database name and collection name
rdd=(spark.read.format("mongodb")
        .option('spark.mongodb.connection.uri', 'mongodb+srv://<user>:<password>@XXXXX.XXXXXX.mongodb.net/?retryWrites=true&w=majority') \
        .option('spark.mongodb.database', '<Database name>') \
        .option('spark.mongodb.collection', '<collection name>') \
.option('spark.mongodb.change.stream.publish.full.document.only','true') \
        .option("forceDeleteTempCheckpointLocation", "true") \
        .load())

## write the dataframe to Redshift
#update the Redshift endpoint or IP Address , ensure its having adequate permission to access. 
#update the database name , user and password
rdd.write.format('jdbc').options(
        url='jdbc:redshift://<Redshift endpoint (or) IP Address> :5439/dev',
        driver='com.amazon.redshift.jdbc42.Driver',
        dbtable='<Domain.tablename>',
        user='<username>',
        password='<Password>').mode('append').save()
