CREATE VIEW monthly_revenue_variance AS
WITH monthly_revenue AS (
  SELECT
    DATE_TRUNC('month', o.order_date) AS month,
    ROUND(SUM(oi.unit_price * oi.quantity * 0.012), 2) AS revenue_usd
  FROM orders o
  JOIN order_items oi ON o.order_id = oi.order_id
  GROUP BY month
)
SELECT
  month,
  revenue_usd,
  LAG(revenue_usd) OVER (ORDER BY month) AS prev_month_revenue,
  ROUND(revenue_usd - LAG(revenue_usd) OVER (ORDER BY month), 2) AS variance_usd,
  ROUND(100.0 * (revenue_usd - LAG(revenue_usd) OVER (ORDER BY month)) 
         / NULLIF(LAG(revenue_usd) OVER (ORDER BY month), 0), 2) AS variance_pct
FROM monthly_revenue;

