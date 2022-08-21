--REFERENCE: https://docs.aws.amazon.com/redshift/latest/dg/tutorial_customer_churn.html

--QUERIES FOR REDSHIFT ML

--GROUP CREATION
create group retention_analyst_grp;

Create group marketing_analyst_grp;

-- PERMISSION
GRANT CREATE MODEL TO GROUP retention_analyst_grp;

GRANT CREATE, USAGE ON SCHEMA public TO GROUP retention_analyst_grp;

GRANT USAGE ON SCHEMA public TO GROUP marketing_analyst_grp;

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

--CREATE AND TRAIN THE MODEL
drop model customer_churn_auto_model ;

CREATE MODEL customer_churn_auto_model FROM (SELECT state,
             account_length,
             area_code,
             total_charge/account_length AS average_daily_spend, 
             cust_serv_calls/account_length AS average_daily_cases,
             churn 
      FROM customer_activity
     WHERE  record_date < '2020-01-01' -- add your custom filter conditions to restrict the number of records
     )
TARGET churn FUNCTION ml_fn_customer_churn_auto
IAM_ROLE 'arn:aws:iam::979559056307:role/partner-redshiftml'SETTINGS (
  S3_BUCKET 'partner-demo'  -- change it with your bucket name
);


-- VALIDATE THE STATUS OF THE MODEL
select schema_name, model_name, model_state from stv_ml_model_info;

-- SHOW THE MODEL VALUE
SHOW MODEL customer_churn_auto_model;

-- GET THE INFERNCE OF CUSTOMER CHURNING FOR A GIVEN INPUT
SELECT  phone,state,
    ml_fn_customer_churn_auto(
        state,account_length,area_code,
        total_charge / account_length,
        cust_serv_calls / account_length
    ) AS active
FROM customer_activity
WHERE   state = 'SB'   -- customize with your value to be validated.

*********
