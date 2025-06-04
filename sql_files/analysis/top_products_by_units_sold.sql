SELECT p.product_name,
       SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_units_sold DESC
LIMIT 10;




