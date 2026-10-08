{{ config(materialized='semantic_view') }}

TABLES (
    orders AS {{ ref('orders') }}
        PRIMARY KEY (order_detail_id)
)

RELATIONSHIPS ()

DIMENSIONS (
    orders.order_date AS DATE(orders.order_ts)
        WITH SYNONYMS = ('date', 'day'),
    orders.truck_brand_name AS orders.truck_brand_name
        WITH SYNONYMS = ('brand', 'truck brand'),
    orders.menu_type AS orders.menu_type
        WITH SYNONYMS = ('cuisine', 'food type'),
    orders.menu_item_name AS orders.menu_item_name
        WITH SYNONYMS = ('item', 'product', 'dish'),
    orders.primary_city AS orders.primary_city
        WITH SYNONYMS = ('city'),
    orders.region AS orders.region,
    orders.country AS orders.country,
    orders.customer_id AS orders.customer_id,
    orders.first_name AS orders.first_name
        WITH SYNONYMS = ('customer first name'),
    orders.last_name AS orders.last_name
        WITH SYNONYMS = ('customer last name'),
    orders.gender AS orders.gender,
    orders.marital_status AS orders.marital_status,
    orders.franchise_flag AS orders.franchise_flag
        WITH SYNONYMS = ('is franchise')
)

METRICS (
    orders.total_revenue AS SUM(orders.price)
        WITH SYNONYMS = ('total sales', 'gross revenue', 'revenue'),
    orders.total_orders AS COUNT(DISTINCT orders.order_id)
        WITH SYNONYMS = ('order count', 'number of orders'),
    orders.total_items_sold AS SUM(orders.quantity)
        WITH SYNONYMS = ('units sold', 'quantity sold'),
    orders.average_order_value AS AVG(orders.order_total)
        WITH SYNONYMS = ('AOV', 'avg order'),
    orders.average_unit_price AS AVG(orders.unit_price)
        WITH SYNONYMS = ('avg price')
)

COMMENT = 'Tasty Bytes order analytics — revenue, order volume, and menu performance by customer, location, and brand'
