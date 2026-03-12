--1. FACT TABLE : ALL ORDER ITEMS
--Purpose : Cleaned transaction - level base table used for downstream analysis

CREATE OR REPLACE TABLE analytics.fact_order_items_all AS
SELECT
 oi.user_id,
 oi.product_id,
 oi.order_id,
 DATE(oi.created_at) AS order_date,
 oi.sale_price AS revenue,
 oi.status
FROM
`bigquery-public-data.thelook_ecommerce.order_items` oi;

--2.PRODUCT DIMENSION 

CREATE OR REPLACE TABLE analytics.dim_product AS
SELECT
  id AS product_id,
  category AS product_category,
  brand,
  name AS product_name,
  retail_price
FROM `bigquery-public-data.thelook_ecommerce.products`;




--3.CATEGORY PERFORMANCE TABLE
--Purpose : Category - level revenue, orders, users, AOV, revenue share, cancellation rate

CREATE OR REPLACE TABLE analytics.final_category_performance AS

WITH order_level AS(
  SELECT
   order_id,
   user_id,
   product_id,
   status,
   SUM(revenue) AS order_revenue
  FROM analytics.fact_order_items_all
  GROUP BY order_id, user_id, product_id, status 
),
category_base AS(
  SELECT
   p.product_category,
   COUNT(DISTINCT o.order_id)AS total_orders,
   COUNT(DISTINCT IF(o.status = 'Cancelled',o.order_id,NULL))AS cancelled_orders,
   SUM(
    IF(o.status IN ('Processing','Shipped', 'Complete'),o.order_revenue,0)
   )AS total_revenue,
   COUNT(DISTINCT IF(
    o.status IN ('Processing', 'Shipped', 'Complete'),o.user_id,NULL))AS purchasing_users
  FROM order_level o
  LEFT JOIN analytics.dim_product p
   ON o.product_id = p.product_id
  GROUP BY p.product_category   
),

company_totals AS(
  SELECT
   SUM(total_revenue) AS company_revenue,
   SUM(total_orders) AS company_orders
  FROM category_base 
)
SELECT
 cb.product_category,
 cb.total_orders,
 cb.cancelled_orders,
 cb.total_revenue,
 cb.purchasing_users,

 SAFE_DIVIDE(cb.total_revenue, cb.total_orders) AS AOV,
 SAFE_DIVIDE(cb.total_revenue, cb.purchasing_users)AS revenue_per_user,
 SAFE_DIVIDE(cb.cancelled_orders, cb.total_orders)AS cancellation_rate,
 SAFE_DIVIDE(cb.total_revenue, ct.company_revenue) AS revenue_share,
 SAFE_DIVIDE(cb.total_orders, ct.company_orders) AS order_share

FROM category_base cb
CROSS JOIN company_totals ct;
