SELECT DATE_TRUNC('quarter', order_date) AS quarter_start, COUNT(*) AS total_orders
FROM orders
GROUP BY quarter_start
ORDER BY quarter_start;




