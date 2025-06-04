CREATE VIEW daily_sales_summary AS
SELECT 
    order_date::DATE AS order_day,
    ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS daily_revenue_usd,
    SUM(oi.quantity) AS units_sold
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY order_day
ORDER BY order_day;
