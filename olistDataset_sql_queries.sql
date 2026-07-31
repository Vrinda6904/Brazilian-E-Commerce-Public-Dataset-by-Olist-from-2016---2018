CREATE DATABASE olist_ecommerce;
USE olist_ecommerce;
-- Joining Tables
SELECT
o.order_id,
c.customer_city,
c.customer_state,
o.order_status,
o.order_purchase_timestamp,
p.payment_type,
p.payment_value
FROM olist_orders_dataset o
JOIN 
olist_customers_dataset c ON o.customer_id = c.customer_id
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
LIMIT 20;

-- AGREGATIONS
SELECT SUM(payment_value) AS Total_Revenue
FROM olist_order_payments_dataset;

-- TOTAL ORDERS AND UNIQUE CUSTOMERS
SELECT COUNT(DISTINCT o.order_id) AS Total_Orders,
COUNT(DISTINCT c.customer_unique_id) AS Unique_Customers
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id;

-- Order Status Breakdown
SELECT order_status, COUNT(*) AS Order_Count
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY Order_Count DESC;

-- Time Based
-- monthly revenue
SELECT 
date_format(o.order_purchase_timestamp, '%Y-%m') AS order_month,
sum(p.payment_value) AS monthly_revenue
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
group by order_month
order by order_month;

-- month over month growth(%)
with monthly as (
select 
date_format(o.order_purchase_timestamp,'%Y-%m') as order_month,
sum(p.payment_value) as revenue
from olist_orders_dataset o
join olist_order_payments_dataset p on o.order_id = p.order_id
group by order_month
)
SELECT 
order_month, revenue, lag(revenue) over (order by order_month) as prev_month_revenue,
round(((revenue- lag(revenue) over (order by order_month))/lag(revenue) over (order by order_month)) * 100,2) as mom_growth_pct
from monthly
order by order_month;
-- top 10 customers by lifetime spent
select
c.customer_unique_id,
c.customer_city,
c.customer_state,
sum(p.payment_value) as total_spend
from olist_customers_dataset c
join olist_orders_dataset o on c.customer_id = o.customer_id
join olist_order_payments_dataset p on o.order_id = p.order_id 
group by c.customer_unique_id, c.customer_city, c.customer_state
order by total_spend desc
limit 10;
-- rank customers within each state
select
c.customer_unique_id,
c.customer_state,
sum(p.payment_value) as total_spend,
rank() over (partition by c.customer_state order by sum(p.payment_value) desc) as state_rank
from olist_customers_dataset c
join olist_orders_dataset o on c.customer_id = o.customer_id
join olist_order_payments_dataset p on o.order_id = p.order_id 
group by  c.customer_state,c.customer_unique_id;

-- revenue by state
select
c.customer_state,
count(distinct o.order_id) as num_orders,
sum(p.payment_value) as total_revenue,
round(avg(p.payment_value),2) as avg_order_value
from olist_customers_dataset c
join olist_orders_dataset o on c.customer_id = o.customer_id
join olist_order_payments_dataset p  on o.order_id = p.order_id
group by customer_state
order by total_revenue desc;
-- payment type breakdown
select
payment_type,
count(*) as num_payments,
sum(payment_value) as total_value,
round(avg(payment_installments),1) as avg_installments
from olist_order_payments_dataset
group by payment_type
order by total_value desc;
-- delivery performance
select order_id, order_purchase_timestamp,order_delivered_customer_date,order_estimated_delivery_date,
datediff(order_delivered_customer_date,order_purchase_timestamp) as actual_delivery_days,
case
when order_delivered_customer_date > order_estimated_delivery_date then 'Late'
else 'On-Time'
end as delivery_status
from olist_orders_dataset
where order_delivered_customer_date is not null;