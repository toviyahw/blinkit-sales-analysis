SELECT 
    p.product_name,
    SUM(i.stock_received) AS total_received,
    SUM(i.damaged_stock) AS total_damaged,
    ROUND(
        100.0 * SUM(i.damaged_stock) FILTER (WHERE i.damaged_stock > 0) / NULLIF(SUM(i.stock_received), 0),
        2
    ) AS damage_percentage
FROM inventory i
JOIN products p ON i.product_id = p.product_id
GROUP BY p.product_name
ORDER BY damage_percentage DESC;



