SELECT customer_id, lifetime_value_usd,
       RANK() OVER (ORDER BY lifetime_value_usd DESC) AS customer_rank
FROM (
    SELECT customer_id,
           ROUND(SUM(order_total * 0.012), 2) AS lifetime_value_usd
    FROM orders
    GROUP BY customer_id
) customer_lifetime_value_rank
ORDER BY customer_rank
LIMIT 10;
