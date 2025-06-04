SELECT month, product_name, total_units,
       RANK() OVER (PARTITION BY month ORDER BY total_units DESC) AS unit_rank
FROM (
    SELECT DATE_TRUNC('month', o.order_date) AS month,
           p.product_name,
           SUM(oi.quantity) AS total_units
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY month, p.product_name
) monthly_product_totals
ORDER BY month, unit_rank;
