--REFERENCE: https://docs.aws.amazon.com/redshift/latest/dg/c-getting-started-using-spectrum.html

--Setup the required roles and permissions

create external schema myspectrum_schema 
from data catalog 
database 'myspectrum_db' 
iam_role 'arn:aws:iam::123456789012:role/<role name>'
create external database if not exists;

-- CUSTOMER ACTIVITY TABLE CREATION
create external table myspectrum_schema.customer_activity (
_id varchar(2),
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
record_date date)
stored as PARQUET
location 's3://partner-demo/glue/customer_activity/backup/customer_activity.json';


-- CHECK THE TABLE STRUCTURE AND ENSURE NO DATA IS AVAILABLE.
select * from myspectrum_schema.customer_activity;


-- Create a View combine  the customer_activity data from both the schema for further analytics.



