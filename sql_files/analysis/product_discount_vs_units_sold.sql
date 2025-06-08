SELECT 
    p.product_id,
    p.product_name,
    p.mrp,
    p.price,
    ROUND((p.mrp - p.price) / NULLIF(p.mrp, 0) * 100, 2) AS discount_pct,
    SUM(oi.quantity) AS total_units_sold
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.mrp, p.price
ORDER BY total_units_sold DESC;
