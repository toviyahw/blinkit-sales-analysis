SELECT DATE_TRUNC('year', order_date) AS year_start, COUNT(*) AS total_orders
FROM orders
GROUP BY year_start
ORDER BY year_start;



