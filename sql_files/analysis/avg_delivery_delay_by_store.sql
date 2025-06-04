SELECT store_id,
       ROUND(AVG(EXTRACT(EPOCH FROM (actual_delivery_time - promised_delivery_time)) / 60), 2) AS avg_delay_minutes
FROM orders
GROUP BY store_id
ORDER BY avg_delay_minutes DESC;




