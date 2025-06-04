SELECT ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS ytd_revenue_usd
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE DATE_TRUNC('year', o.order_date) = DATE_TRUNC('year', CURRENT_DATE);





