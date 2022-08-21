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

### Step 1: One-Time Load
MongoDB Atlas has direct connectors with  Apache Spark. Using the spark connectors the data is migrated from MongoDB Atlas to Redshift at one time

### Step2: Real-Time Data Sync
With the help of the MongoDB Atlas triggers, the data changes in the database can be continuously written to S3 bucket.
From the S3 bucket data can be loaded into the Redshift either through schedule AWS Glue jobs or can be accessed as an external tables.

In this demonstration we attempt to provided step by step approach for each of these scenarios.




## One-Time Load

### Architecture diagram

![](https://github.com/Babusrinivasan76/atlastoredshift/blob/main/images/01.One-Time%20Data%20Load.png)

### Step by Step Instruction
Use the [Pyspark job](https://github.com/Babusrinivasan76/atlastoredshift/blob/main/Scripts/pyspark_atlastoredshift_customeractivity.py) template to move the data from Atlas to Redshift.

Once the data is loaded completely the real-time data sync is enabled.



##  Real-Time Data Sync 


The Change Data Capture feature of MongoDB Atlas is utilized to capture the real-time data. Utilizing the Atlas Application Services and Data Federation's $out feature to write to S3 bucket, we capture the change data to S3 continuously.


### Architecture diagram 


#### With Glue: 


![](https://github.com/Babusrinivasan76/atlastoredshift/blob/main/images/02.Data-Stream-with%20Glue.png)


#### with Redshift Spectrum (External Table)


![](https://github.com/Babusrinivasan76/atlastoredshift/blob/main/images/03.Data-Stream-with%20Redshift%20Spectrum.png)


### Step by Step Instruction for setting up Glue Job
1. The data from MongoDB Atlas can be continuously written to S3 bucket using the Data Federation and MongoDB Atlas triggers. 
 Please refer the [link](https://www.mongodb.com/developer/products/atlas/automated-continuous-data-copying-from-mongodb-to-s3/) for the step by step instructions to capture the data to S3.

 For any further reference , please follow the MongoDB documentation [link](https://www.mongodb.com/docs/atlas/data-federation/config/config-aws-s3/)

2. create a AWS Glue job to move the data from S3 bucket to AWS Redshift
      
a. Create the Glue Connections
![](https://github.com/Babusrinivasan76/atlastoredshift/blob/main/images/05.AWS%20Glue%20Redshift%20Connections%201.png)
![](https://github.com/Babusrinivasan76/atlastoredshift/blob/main/images/06.AWS%20Glue%20Redshift%20Connections%202.png)
![](https://github.com/Babusrinivasan76/atlastoredshift/blob/main/images/07.AWS%20Glue%20Redshift%20Connections%203.png)

b.Create the Crawler

c.Create the Job and run the job

d.Set up the triggers for the job


### Step by Step Instruction for setting up Redshift Spectrum - External Table

Redshift Spectrum host the S3 bucket data as an external table. Provided the reference and steps to create the extenal table in the following link

[Redshift Specturm - external table](https://github.com/Babusrinivasan76/atlastoredshift/blob/main/Scripts/RedshiftML_for_CustomerActivity.sql)

## Business Use Cases:
Enterprises like Retail, Banking & Finance and Manufacturing are in great demand for the operational analytics for it's various real-time analytics.
A few are captured below

![](https://github.com/Babusrinivasan76/atlastoredshift/blob/main/images/04.Key%20Business%20Use%20Cases.png)

## Summary: 
With the synergy it creates by having Atlas for its operational efficiency and Redshift for its DWH excellence, all the “Operational Analytics” use cases can be delivered in no time. The solution can be extended to integrate the AI/ML needs using the AWS SageMaker.

Hope you are able to setup the integration successfully. For any further reference pls reach out to partners@mongodb.com

