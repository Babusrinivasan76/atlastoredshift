# Operational Analytics with Atlas and Redshift


## Introduction

The modern business world demands expedited decision-making, improved customer experience, and increased productivity. Gone are those days when business intelligence relied heavily on past data through batch processing. 
The order of the day is Operational analytics, which relies on measuring the existing or real-time operations of the business along with its data warehouse.

## Why Operational Analytics?
First and foremost there is an exponential increase in data volumes and their varieties. Traditional DW needs to evolve constantly to meet this demand of changing needs.
Most recent data are no more tabular in nature. Databases evolved into JSONs, Social logs, Images, Videos, and Time Series data.

Of late the Legacy relational database models are becoming showstoppers for programming and advanced analytics. With the legacy ways of Datastore, the performance becomes a big bottleneck as the data grows into Terabytes and petabytes.

So the need of the hour is to have a cohesive data model, which takes care of both the day-to-day operational data and its past.

Thus the coexistence of Atlas and Redshift evolves as the perfect fit for the business need.

## Integration Framework

The data from/to MongoDB Atlas can be migrated in two step approach

Step 1: One-Time Load
MongoDB Atlas has direct connectors with  Apache Spark. Using the spark connectors the data is migrated from MongoDB Atlas to Redshift at one time

Step2: Data Streaming or Real-Time Data
With the help of the MongoDB Atlas triggers, the data changes in the database can be continuously written to S3 bucket.
From the S3 bucket data can be loaded into the Redshift either through schedule AWS Glue jobs or can be accessed as an external tables.

In this demonstration we attempt to provided step by step approach for each of these scenarios.




## One-Time Load

### Architecture diagram

### Step by Step Instruction
      1. use the [Pyspark job](https://github.com/Babusrinivasan76/atlastoredshift/blob/main/Scripts/pyspark_atlastoredshift_customeractivity.py) to move the data from Atlas to Redshift.


##  Data Streaming


### Architecture diagram

### Step by Step Instruction
      1. Create a Atlas Federated Database using the Data Federation menu
      
      2. Create the Atlas functions to write to the S3 bucket
      
      3. Create a Trigger and attach the functions
      
    Data Streaming via AWS Glue jobs - Best suited for a high frequency streaming data
    
      1. create a AWS Glue job to move the data from S3 bucket to AWS Redshift
      
    S3 access to Redshift - Best suited for accessing reference data.
    
      1. Create an external table with the Redshift specturm feature 
     
## Summary: 
	With the synergy it creates by having Atlas for its operational efficiency and Redshift for its DWH excellence, all the “Operational Analytics” use cases can be delivered in no time. The solution can be extended to integrate the AI/ML needs using the AWS SageMaker.
  
 For any further reference pls reach out to partners@mongodb.com

