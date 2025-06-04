SELECT DATE_TRUNC('year', o.order_date) AS year_start,
       ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS total_revenue_usd
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY year_start
ORDER BY year_start;




