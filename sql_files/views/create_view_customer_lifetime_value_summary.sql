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
