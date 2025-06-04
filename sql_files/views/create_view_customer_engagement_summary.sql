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
