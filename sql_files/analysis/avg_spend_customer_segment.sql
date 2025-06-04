SELECT customer_segment, 
       ROUND(AVG(avg_order_value * 0.012), 2) AS avg_spend_usd
FROM customers
GROUP BY customer_segment
ORDER BY avg_spend_usd DESC;

