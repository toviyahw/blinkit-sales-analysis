SELECT DATE_TRUNC('week', order_date) AS week_start, COUNT(*) AS total_orders
FROM orders
GROUP BY week_start
ORDER BY week_start;





