SELECT DATE_TRUNC('quarter', o.order_date) AS quarter_start,
       ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS total_revenue_usd
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY quarter_start
ORDER BY quarter_start;




