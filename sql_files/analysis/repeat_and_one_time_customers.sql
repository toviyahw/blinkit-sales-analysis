SELECT
    COUNT(*) FILTER (WHERE total_orders = 1) AS one_time_customers,
    COUNT(*) FILTER (WHERE total_orders > 1) AS repeat_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE total_orders = 1) / COUNT(*), 2) AS one_time_percentage,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE total_orders > 1) / COUNT(*), 2) AS repeat_percentage
FROM customers;


