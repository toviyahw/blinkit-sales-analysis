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
