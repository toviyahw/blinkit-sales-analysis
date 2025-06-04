SELECT 
    p.product_name,
    COUNT(*) AS complaint_count
FROM customer_feedback cf
JOIN orders o ON cf.order_id = o.order_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE LOWER(cf.feedback_category) LIKE '%complaint%' 
   OR LOWER(cf.feedback_text) LIKE '%return%' 
   OR LOWER(cf.feedback_text) LIKE '%damaged%' 
GROUP BY p.product_name
ORDER BY complaint_count DESC
LIMIT 10;
