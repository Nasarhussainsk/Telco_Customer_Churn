-- ============================================================
-- Telco Customer Churn: SQL Analysis (MySQL)
-- Load Telco-Customer-Churn.csv into telco_customers before running the queries below
-- ============================================================

-- 1. DATABASE & TABLE SETUP
create database telco_churn_db;
use telco_churn_db;

create table telco_customers (
    customerID VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(30),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    Churn VARCHAR(5)
);

-- 2. DATA CHECKS
select count(*) as total_customers
from telco_customers; 

select * from telco_customers
limit 5;

describe telco_customers;

select count(*) as missing_total_charges
from telco_customers
where totalcharges is null;


-- 3. OVERALL CHURN RATE
select count(*) as total_customers,
sum(case when churn ='YES' then 1 else 0 end) as churned_customers,
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0/count(*),2)as churn_rate_percentage
from telco_customers;


-- 4. CHURN BY CONTRACT, TENURE, INTERNET SERVICE, CHARGES, PAYMENT, TECH SUPPORT
select contract,count(*),
sum(case when churn ='YES' then 1 else 0 end) as churned_customers,
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0/count(*),2)as churn_rate_percentage
from telco_customers
group by contract;

select
case when tenure <= 12 then "new customers"
when tenure <= 36 then "medium-term customers"
else "long-term customers"
end as tenure_group,
count(*) as total_customers,
sum(case when churn ='YES' then 1 else 0 end) as churned_customers,
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0/count(*),2)as churn_rate_percentage
from telco_customers
group by
case when tenure <= 12 then "new customers"
when tenure <= 36 then "medium-term customers"
else "long-term customers"
end;

select InternetService,count(*),
sum(case when churn ='YES' then 1 else 0 end) as churned_customers,
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0/count(*),2)as churn_rate_percentage
from telco_customers
group by InternetService;

select 
charges_group,
count(*) as customers_group,
sum(case when churn = 'yes' then 1 else 0 end) as churned_customers,
round(sum(case when churn='yes' then 1 else 0 end)*100.0/count(*),2) as churn_rate_percentage
from ( 
select 
churn,
case when MonthlyCharges<= 35 then 'lowcharges'
when MonthlyCharges > 35 and MonthlyCharges <= 70 then 'mediumcharges'
else 'highcharges'
end as charges_group
from telco_customers) as grouped
group by 
	charges_group;
    
select paymentmethod,count(*) as total_customers,
sum(case when churn = 'yes' then 1 else 0 end) as churned_customers,
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0/count(*),2) as churn_rate_percentage
from telco_customers
group by paymentmethod;

select techsupport,count(*) as total_customers,
sum(case when churn = 'yes' then 1 else 0 end) as churned_customers,
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0/count(*),2) as churn_rate_percentage
from telco_customers
group by TechSupport;



-- 5. COMBINED SEGMENTS
select Contract,PaymentMethod,count(*) as total_customers,
sum(case when churn = 'yes' then 1 else 0 end) as churned_customers,
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0/count(*),2) as churn_rate_percentage
from telco_customers
group by contract,paymentmethod
order by churn_rate_percentage desc;


-- 6. HIGH-RISK CUSTOMER SEGMENT
select customerid,Contract,tenure,monthlycharges,TechSupport,churn from telco_customers
where Contract = 'month-to-month' and tenure <= 12 and MonthlyCharges>70 and TechSupport='no';

select count(*) as high_risk_customers,
sum(case when churn = 'yes' then 1 else 0 end) as churned_high_risk_customers,
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0/count(*),2) as churn_rate_percentage
from telco_customers
where Contract = 'month-to-month' and tenure <= 12 and MonthlyCharges>70 and TechSupport='no';


-- 7. REVENUE ANALYSIS
select Contract,count(*) as total_customers,
sum(monthlycharges) as total_monthly_revenue,
avg(monthlycharges) as avg_monthly_revenue
from telco_customers
group by contract;

select
sum(monthlycharges) as total_monthly_revenue,
sum(case when churn = 'yes' then monthlycharges else 0 end) as churned_monthly_revenue,
round(sum(case when churn='yes' then monthlycharges else 0 end)*100/sum(monthlycharges),2) as percentage_of_revenue_at_risk
from telco_customers;


-- 8. CUSTOMER PROFILE
select SeniorCitizen,count(*) as total_customers,
sum(case when churn = 'yes' then 1 else 0 end) as churned_customers,
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0/count(*),2) as churn_rate_percentage
from telco_customers
group by SeniorCitizen;

select Partner,Dependents,count(*) as total_customers,
sum(case when churn = 'yes' then 1 else 0 end) as churned_customers,
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0/count(*),2) as churn_rate_percentage
from telco_customers
group by Partner,Dependents;


-- 9. CONTRACT x INTERNET SERVICE
select Contract,InternetService,count(*) as total_customers,
sum(case when churn = 'yes' then 1 else 0 end) as churned_customers,
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0/count(*),2) as churn_rate_percentage
from telco_customers
group by contract,InternetService
order by churn_rate_percentage desc;


-- 10. VIEW
create view contract_churn_summary as 
select Contract,count(*) as total_customers,
sum(case when churn = 'yes' then 1 else 0 end) as churned_customers,
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0/count(*),2) as churn_rate_percentage
from telco_customers
group by contract;

select * from contract_churn_summary;


-- 11. SUBQUERY: CUSTOMERS ABOVE AVERAGE MONTHLY CHARGES
select customerid,monthlycharges,contract,churn from telco_customers
where monthlycharges> (
	select avg(MonthlyCharges)
    from telco_customers);
    

-- 12. WINDOW FUNCTION: TOP 5 MONTHLY CHARGE LEVELS
WITH ranked AS (
    SELECT customerid, monthlycharges, contract, churn,
           DENSE_RANK() OVER (ORDER BY monthlycharges DESC) AS charge_rank
    FROM telco_customers
)
SELECT *
FROM ranked
WHERE charge_rank <= 5;