SELECT c.area,
       ROUND(AVG(EXTRACT(EPOCH FROM (o.actual_delivery_time - o.promised_delivery_time)) / 60), 2) AS avg_delivery_time_minutes
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.area
ORDER BY avg_delivery_time_minutes DESC;