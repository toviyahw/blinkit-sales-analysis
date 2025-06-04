WITH first_orders AS (
    SELECT customer_id, MIN(order_date)::DATE AS first_order_date
    FROM orders
    GROUP BY customer_id
),
order_cohorts AS (
    SELECT 
        o.customer_id,
        DATE_TRUNC('month', f.first_order_date) AS cohort_month,
        DATE_TRUNC('month', o.order_date) AS order_month
    FROM orders o
    JOIN first_orders f ON o.customer_id = f.customer_id
)
SELECT 
    cohort_month,
    order_month,
    COUNT(DISTINCT customer_id) AS active_customers
FROM order_cohorts
GROUP BY cohort_month, order_month
ORDER BY cohort_month, order_month;