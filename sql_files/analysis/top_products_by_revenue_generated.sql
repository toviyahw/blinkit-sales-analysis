SELECT p.product_name,
	ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS revenue_usd
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue_usd DESC
LIMIT 10;


