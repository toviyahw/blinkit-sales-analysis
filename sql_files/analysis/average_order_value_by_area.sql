SELECT area,
       ROUND(AVG(order_total * 0.012), 2) AS avg_order_value_usd
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY area
ORDER BY avg_order_value_usd DESC;




