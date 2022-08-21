--REFERENCE: https://docs.aws.amazon.com/redshift/latest/dg/tutorial_customer_churn.html

The below step can be ommitted, if the table is already created throught one-time load process.

-- CUSTOMER ACTIVITY TABLE CREATION
CREATE TABLE customer_activity (
state varchar(2), 
account_length int, 
area_code int,
phone varchar(8), 
intl_plan varchar(3), 
vMail_plan varchar(3),
vMail_message int, 
day_mins float, 
day_calls int, 
day_charge float,
total_charge float,
eve_mins float, 
eve_calls int, 
eve_charge float, 
night_mins float,
night_calls int, 
night_charge float, 
intl_mins float, 
intl_calls int,
intl_charge float, 
cust_serv_calls int, 
churn varchar(6),
record_date date);

-- CHECK THE TABLE STRUCTURE AND ENSURE NO DATA IS AVAILABLE.
select * from customer_activity;

-- COPY THE DATA FROM S3 BUCKET
COPY customer_activity
FROM 's3://partner-demo/glue/customer-activity/data/customer_activity.json' -- change it with your bucket 
REGION 'us-east-1' IAM_ROLE default -- replace with your role name.
format as json 'auto';

