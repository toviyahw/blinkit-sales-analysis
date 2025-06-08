-- BLINKIT DATABASE MASTER SCHEMA SETUP AND ANALYSIS QUERIES --




-- [CREATE TABLES] --

-- 1. Create Products Table
CREATE TABLE products (
    product_id TEXT PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    brand TEXT,
    price NUMERIC(10,2),
    mrp NUMERIC(10,2),
    margin_percentage NUMERIC(5,2),
    shelf_life_days INTEGER,
    min_stock_level INTEGER,
    max_stock_level INTEGER
);

-- 2. Create Customers Table
CREATE TABLE customers (
    customer_id TEXT PRIMARY KEY,
    customer_name TEXT,
    email TEXT,
    phone TEXT,
    address TEXT,
    area TEXT,
    pincode TEXT,
    registration_date DATE,
    customer_segment TEXT,
    total_orders INTEGER,
    avg_order_value NUMERIC(12,2)
);

-- 3. Create Order Items Table
CREATE TABLE order_items (
    order_id TEXT,
    product_id TEXT,
    quantity INTEGER,
    unit_price NUMERIC(10,2),
    PRIMARY KEY (order_id, product_id)
);

-- 4. Create Inventory Table
CREATE TABLE inventory (
    inventory_id SERIAL PRIMARY KEY,
    product_id TEXT,
    date DATE,
    stock_received INTEGER,
    damaged_stock INTEGER
);

-- 5. Create Orders Table
CREATE TABLE orders (
    order_id TEXT PRIMARY KEY,
    customer_id TEXT,
    order_date TIMESTAMP,
    promised_delivery_time TIMESTAMP,
    actual_delivery_time TIMESTAMP,
    delivery_status TEXT,
    order_total NUMERIC(10,2),
    payment_method TEXT,
    delivery_partner_id TEXT,
    store_id TEXT
);

-- 6. Create Delivery Performance Table
CREATE TABLE delivery_performance (
    order_id TEXT PRIMARY KEY,
    partner_id TEXT,
    promised_time TIMESTAMP,
    actual_time TIMESTAMP,
    delivery_time_minutes NUMERIC(6,2),
    distance_km NUMERIC(6,2),
    delivery_status TEXT,
    reasons_if_delayed TEXT
);

-- 7. Create Marketing Performance Table
CREATE TABLE marketing_performance (
    campaign_id TEXT PRIMARY KEY,
    campaign_name TEXT,
    date DATE,
    target_audience TEXT,
    channel TEXT,
    impressions INTEGER,
    clicks INTEGER,
    conversions INTEGER,
    spend NUMERIC(10,2),
    revenue_generated NUMERIC(10,2),
    roas NUMERIC(5,2)
);

-- 8. Create Customer Feedback Table
CREATE TABLE customer_feedback (
    feedback_id TEXT PRIMARY KEY,
    order_id TEXT,
    customer_id TEXT,
    rating INTEGER,
    feedback_text TEXT,
    feedback_category TEXT,
    sentiment TEXT,
    feedback_date DATE
);




-- [ADD FOREIGN KEYS] --

ALTER TABLE order_items
    ADD FOREIGN KEY (order_id) REFERENCES orders(order_id),
    ADD FOREIGN KEY (product_id) REFERENCES products(product_id);

ALTER TABLE inventory
    ADD FOREIGN KEY (product_id) REFERENCES products(product_id);

ALTER TABLE orders
    ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

ALTER TABLE delivery_performance
    ADD FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE customer_feedback
    ADD FOREIGN KEY (order_id) REFERENCES orders(order_id),
    ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id);




-- [ANALYSIS QUERIES] --

-- 1. Average Customer Order Value by Area
SELECT area,
       ROUND(AVG(order_total * 0.012), 2) AS avg_order_value_usd
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY area
ORDER BY avg_order_value_usd DESC;

-- 2. Average Rating by Sentiment Group
SELECT sentiment, ROUND(AVG(rating), 2) AS avg_rating
FROM customer_feedback
GROUP BY sentiment
ORDER BY avg_rating DESC;

-- 3. Average Delivery Delay by Store 
-- Note: due to limitations in the data, each store_id has only one single delivery tied to it
SELECT store_id,
       ROUND(AVG(EXTRACT(EPOCH FROM (actual_delivery_time - promised_delivery_time)) / 60), 2) AS avg_delay_minutes
FROM orders
GROUP BY store_id
ORDER BY avg_delay_minutes DESC;

-- 4. Average Delivery Time by Area
SELECT c.area,
       ROUND(AVG(EXTRACT(EPOCH FROM (o.actual_delivery_time - o.promised_delivery_time)) / 60), 2) AS avg_delivery_time_minutes
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.area
ORDER BY avg_delivery_time_minutes DESC;

-- 5. Average Spend by Customer Segment
SELECT customer_segment, 
       ROUND(AVG(avg_order_value * 0.012), 2) AS avg_spend_usd
FROM customers
GROUP BY customer_segment
ORDER BY avg_spend_usd DESC;

-- 6. Cost per Conversion by Audience
SELECT 
    target_audience,
    ROUND(SUM(spend * 0.012) / NULLIF(SUM(conversions), 0), 2) AS cost_per_conversion_usd
FROM marketing_performance
GROUP BY target_audience
ORDER BY cost_per_conversion_usd ASC;

-- 7. Cost per Conversion by Campaign Type
SELECT campaign_name,
       ROUND(SUM(spend * 0.012) / NULLIF(SUM(conversions), 0), 2) AS cost_per_conversion_usd
FROM marketing_performance
GROUP BY campaign_name
ORDER BY cost_per_conversion_usd ASC;

-- 8. Cost per Conversion by Marketing Channel
SELECT 
    channel,
    SUM(conversions) AS total_conversions,
    ROUND(SUM(spend * 0.012), 2) AS total_spend_usd,
    ROUND(SUM(spend * 0.012) / NULLIF(SUM(conversions), 0), 2) AS cost_per_conversion_usd
FROM marketing_performance
GROUP BY channel
ORDER BY cost_per_conversion_usd DESC;

-- 9. Click-through Rate (CTR) by Marketing Channel
SELECT channel, ROUND(100.0 * SUM(clicks) / NULLIF(SUM(impressions), 0), 2) AS ctr
FROM marketing_performance
GROUP BY channel
ORDER BY ctr DESC;

-- 10. Delivery Delay Count by Partner (Top 10) 
-- Note: Due to limitations in the data, there is only one value assigned to each parter_id. The result is a 1 or 0 for each partner. This query 
-- is included to demonstrate my ability to produce this information to identify employees with frequent or repeated delivery performance issues.
SELECT partner_id, COUNT(*) AS delay_count
FROM delivery_performance
WHERE delivery_status != 'on time'
GROUP BY partner_id
ORDER BY delay_count DESC
LIMIT 10;

-- 11. Marketing Performance by Channel (Impressions --> Conversions)
SELECT 
    channel,
    SUM(impressions) AS total_impressions,
    SUM(clicks) FILTER (WHERE clicks > 0) AS engaged_users,
    SUM(conversions) FILTER (WHERE conversions > 0) AS converted_users
FROM marketing_performance
GROUP BY channel;

-- 12. Marketing Effeciency by Campaign Type (CTR, Conversion Rate, ROAS)
SELECT campaign_name,
       ROUND(100.0 * SUM(clicks) / NULLIF(SUM(impressions), 0), 2) AS ctr,
       ROUND(100.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 2) AS conversion_rate,
       ROUND(SUM(revenue_generated) / NULLIF(SUM(spend), 0), 2) AS roas
FROM marketing_performance
GROUP BY campaign_name
ORDER BY roas DESC;

-- 13. Marketing Efficiency by Audience (CTR, Conversion Rate, ROAS)
SELECT target_audience,
       ROUND(100.0 * SUM(clicks) / NULLIF(SUM(impressions), 0), 2) AS ctr,
       ROUND(100.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 2) AS conversion_rate,
       ROUND(SUM(revenue_generated) / NULLIF(SUM(spend), 0), 2) AS roas
FROM marketing_performance
GROUP BY target_audience
ORDER BY roas DESC;

-- 14. Most Profitable Products (Top 10)
SELECT p.product_name,
       ROUND(SUM(oi.unit_price * oi.quantity * (p.margin_percentage / 100.0) * 0.012), 2) AS estimated_profit_usd
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY estimated_profit_usd DESC
LIMIT 10;

-- 15. Negative ROAS Campaigns
SELECT campaign_id, campaign_name, roas, spend, channel, date
FROM marketing_performance
WHERE roas < 1
ORDER BY roas ASC;

-- 16. Quarterly Order Volume
SELECT DATE_TRUNC('quarter', order_date) AS quarter_start, COUNT(*) AS total_orders
FROM orders
GROUP BY quarter_start
ORDER BY quarter_start;

-- 17. Weekly Order Volume
SELECT DATE_TRUNC('week', order_date) AS week_start, COUNT(*) AS total_orders
FROM orders
GROUP BY week_start
ORDER BY week_start;

-- 18. Yearly Order Volume
SELECT DATE_TRUNC('year', order_date) AS year_start, COUNT(*) AS total_orders
FROM orders
GROUP BY year_start
ORDER BY year_start;

-- 19. Product Complaint Counts (Top 10)
SELECT 
    p.product_name,
    COUNT(*) AS complaint_count
FROM customer_feedback cf
JOIN orders o ON cf.order_id = o.order_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE LOWER(cf.feedback_category) LIKE '%complaint%' 
   OR LOWER(cf.feedback_text) LIKE '%return%' 
   OR LOWER(cf.feedback_text) LIKE '%damaged%' 
GROUP BY p.product_name
ORDER BY complaint_count DESC
LIMIT 10;

-- 20. Customer Lifetime Value (LTV) Ranking (Top 10)
SELECT customer_id, lifetime_value_usd,
       RANK() OVER (ORDER BY lifetime_value_usd DESC) AS customer_rank
FROM (
    SELECT customer_id,
           ROUND(SUM(order_total * 0.012), 2) AS lifetime_value_usd
    FROM orders
    GROUP BY customer_id
) customer_lifetime_value_rank
ORDER BY customer_rank
LIMIT 10;

-- 21. Ranking Campaign Types across Marketing Channels
SELECT channel, campaign_name, roas,
       RANK() OVER (PARTITION BY channel ORDER BY roas DESC) AS roas_rank
FROM (
    SELECT channel, campaign_name,
           ROUND(SUM(revenue_generated) / NULLIF(SUM(spend), 0), 2) AS roas
    FROM marketing_performance
    GROUP BY channel, campaign_name
) ranked_campaigns_by_channel
ORDER BY channel, roas_rank;

-- 22. Monthly Top Products by Units Sold
SELECT month, product_name, total_units,
       RANK() OVER (PARTITION BY month ORDER BY total_units DESC) AS unit_rank
FROM (
    SELECT DATE_TRUNC('month', o.order_date) AS month,
           p.product_name,
           SUM(oi.quantity) AS total_units
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY month, p.product_name
) monthly_product_totals
ORDER BY month, unit_rank;

-- 23. Repeat Customer and One-Time Customer Counts
SELECT
    COUNT(*) FILTER (WHERE total_orders = 1) AS one_time_customers,
    COUNT(*) FILTER (WHERE total_orders > 1) AS repeat_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE total_orders = 1) / COUNT(*), 2) AS one_time_percentage,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE total_orders > 1) / COUNT(*), 2) AS repeat_percentage
FROM customers;

-- 24. Sentiment Count by Month
SELECT DATE_TRUNC('month', feedback_date) AS month,
       sentiment,
       COUNT(*) AS sentiment_count
FROM customer_feedback
GROUP BY month, sentiment
ORDER BY month, sentiment;

-- 25. Sentiment Count Distribution
SELECT sentiment, COUNT(*) AS feedback_count
FROM customer_feedback
GROUP BY sentiment
ORDER BY feedback_count DESC;

-- 26. Stock Damage % by Product
SELECT 
    p.product_name,
    SUM(i.stock_received) AS total_received,
    SUM(i.damaged_stock) AS total_damaged,
    ROUND(
        100.0 * SUM(i.damaged_stock) FILTER (WHERE i.damaged_stock > 0) / NULLIF(SUM(i.stock_received), 0),
        2
    ) AS damage_percentage
FROM inventory i
JOIN products p ON i.product_id = p.product_id
GROUP BY p.product_name
ORDER BY damage_percentage DESC;

-- 27. Top Campaigns by Revenue (Top 10)
SELECT campaign_name, ROUND(SUM(revenue_generated * 0.012), 2) AS revenue_usd
FROM marketing_performance
GROUP BY campaign_name
ORDER BY revenue_usd DESC
LIMIT 10;

-- 28. Top Products by Revenue (Top 10)
SELECT p.product_name,
	ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS revenue_usd
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue_usd DESC
LIMIT 10;

-- 29. Top Products by Units Sold (Top 10)
SELECT p.product_name,
       SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_units_sold DESC
LIMIT 10;

-- 30. Total Revenue by Product Category
SELECT p.category,
       ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS revenue_usd
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue_usd DESC;

-- 31. Quarterly Total Revenue
SELECT DATE_TRUNC('quarter', o.order_date) AS quarter_start,
       ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS total_revenue_usd
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY quarter_start
ORDER BY quarter_start;

-- 32. Weekly Total Revenue
SELECT DATE_TRUNC('week', o.order_date) AS week_start,
       ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS total_revenue_usd
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY week_start
ORDER BY week_start;

-- 33. Yearly Total Revenue
SELECT DATE_TRUNC('year', o.order_date) AS year_start,
       ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS total_revenue_usd
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY year_start
ORDER BY year_start;

-- 34. Total Revenue to Date
-- Note: Running this query will produce a NULL value as there is no data for the year 2025.
SELECT ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS ytd_revenue_usd
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE DATE_TRUNC('year', o.order_date) = DATE_TRUNC('year', CURRENT_DATE);

-- 35. Active Customers by Cohort [Windowed Query]
-- Note: Cohorts were grouped by customer registration month.
WITH first_orders AS (
    SELECT customer_id, MIN(order_date)::DATE AS first_order_date
    FROM orders
    GROUP BY customer_id
),
order_cohorts AS (
    SELECT 
        o.customer_id,
        DATE_TRUNC('month', f.first_order_date) AS cohort_month,
        DATE_TRUNC('month', o.order_date) AS order_month
    FROM orders o
    JOIN first_orders f ON o.customer_id = f.customer_id
)
SELECT 
    cohort_month,
    order_month,
    COUNT(DISTINCT customer_id) AS active_customers
FROM order_cohorts
GROUP BY cohort_month, order_month
ORDER BY cohort_month, order_month;

-- 36. Discounted Products vs. Unit Sales
SELECT 
    p.product_id,
    p.product_name,
    p.mrp,
    p.price,
    ROUND((p.mrp - p.price) / NULLIF(p.mrp, 0) * 100, 2) AS discount_pct,
    SUM(oi.quantity) AS total_units_sold
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.mrp, p.price
ORDER BY total_units_sold DESC;





-- [CREATE VIEWS] --

-- 1. Create KPI Summary View
CREATE OR REPLACE VIEW kpi_summary AS
SELECT 
    -- Financial Metrics
    ROUND(SUM(mp.revenue_generated * 0.012), 2) AS total_revenue_usd,
    ROUND(SUM(mp.spend * 0.012), 2) AS total_spend_usd,
    
    -- Conversions and Customers
    SUM(mp.conversions) AS total_conversions,
    COUNT(DISTINCT c.customer_id) AS customers_acquired,
    
    -- KPIs
    ROUND(SUM(mp.revenue_generated * 0.012) / NULLIF(SUM(mp.spend * 0.012), 0), 2) AS roas,
    ROUND(SUM(mp.spend * 0.012) / NULLIF(SUM(mp.conversions), 0), 2) AS cost_per_conversion_usd,
    
    -- Customer Retention Rate
    ROUND(100.0 * COUNT(CASE WHEN c.total_orders > 1 THEN 1 END) / NULLIF(COUNT(c.customer_id), 0), 2) AS retention_rate_pct

FROM marketing_performance mp
JOIN customers c
  ON DATE_TRUNC('month', c.registration_date) = DATE_TRUNC('month', mp.date);


-- 2. Create Daily Sales Summary View
CREATE VIEW daily_sales_summary AS
SELECT 
    order_date::DATE AS order_day,
    ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS daily_revenue_usd,
    SUM(oi.quantity) AS units_sold
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY order_day
ORDER BY order_day;

-- 3. Create Campaign Performance Summary View
CREATE VIEW campaign_performance_summary AS
SELECT 
    campaign_name,
    channel,
    target_audience,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(conversions) AS total_conversions,
    ROUND(100.0 * SUM(clicks) / NULLIF(SUM(impressions), 0), 2) AS ctr,
    ROUND(100.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 2) AS conversions,
    ROUND(SUM(spend * 0.012) / NULLIF(SUM(conversions), 0), 2) AS cost_per_conversion,
    ROUND(SUM(revenue_generated * 0.012) / NULLIF(SUM(spend * 0.012), 0), 2) AS roas,
    CASE 
        WHEN ROUND(SUM(revenue_generated) / NULLIF(SUM(spend), 0), 2) >= 3 THEN 'High ROAS'
        WHEN ROUND(SUM(revenue_generated) / NULLIF(SUM(spend), 0), 2) >= 1 THEN 'Moderate ROAS'
        ELSE 'Low ROAS'
    END AS performance_tier
FROM marketing_performance
GROUP BY campaign_name, channel, target_audience
ORDER BY campaign_name, channel, target_audience;

-- 4. Create Customer Engagement Summary View
CREATE VIEW customer_engagement_summary AS
SELECT 
    customer_segment,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE total_orders = 1) AS one_time_customers,
    COUNT(*) FILTER (WHERE total_orders > 1) AS repeat_customers,
    ROUND(100.0 * COUNT(*) FILTER (WHERE total_orders > 1) / COUNT(*), 2) AS repeat_customer_pct,
    ROUND(AVG(avg_order_value * 0.012), 2) AS avg_order_value_usd
FROM customers
GROUP BY customer_segment;

-- 5. Create Customer Lifetime Value Summary View
CREATE VIEW customer_ltv_summary AS
SELECT 
    customer_id,
    customer_segment,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(order_total * 0.012), 2) AS lifetime_value_usd
FROM orders
JOIN customers USING (customer_id)
GROUP BY customer_id, customer_segment
ORDER BY lifetime_value_usd DESC;

-- 6. Create Product Perfomance Summary View
CREATE VIEW product_performance_summary AS
SELECT 
    p.product_name,
    p.category,
    SUM(oi.quantity) AS total_units_sold,
    ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS total_revenue_usd,
    COUNT(DISTINCT oi.order_id) AS num_orders
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name, p.category
ORDER BY total_revenue_usd DESC;

-- 7. Create Monthly Revenue Variance Summary View
CREATE VIEW monthly_revenue_variance AS
WITH monthly_revenue AS (
  SELECT
    DATE_TRUNC('month', o.order_date) AS month,
    ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS revenue_usd
  FROM orders o
  JOIN order_items oi ON o.order_id = oi.order_id
  GROUP BY month
)
SELECT
  month,
  revenue_usd,
  LAG(revenue_usd) OVER (ORDER BY month) AS prev_month_revenue,
  ROUND(revenue_usd - LAG(revenue_usd) OVER (ORDER BY month), 2) AS variance_usd,
  ROUND(100.0 * (revenue_usd - LAG(revenue_usd) OVER (ORDER BY month)) 
         / NULLIF(LAG(revenue_usd) OVER (ORDER BY month), 0), 2) AS variance_pct
FROM monthly_revenue;

-- 8. Create Date Dimension View
CREATE VIEW date_dimension AS
SELECT 
    GENERATE_SERIES(MIN(order_date::date), MAX(order_date::date), INTERVAL '1 day')::date AS date
FROM orders;
