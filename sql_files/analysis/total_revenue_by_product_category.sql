SELECT p.category,
       ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS revenue_usd
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue_usd DESC;

