SELECT p.product_name,
       ROUND(SUM(oi.unit_price * oi.quantity * (p.margin_percentage / 100.0) * 0.012), 2) AS estimated_profit_usd
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY estimated_profit_usd DESC
LIMIT 10;


