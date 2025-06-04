SELECT ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS revenue_to_date_usd
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id;




