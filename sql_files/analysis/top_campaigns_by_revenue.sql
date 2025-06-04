SELECT campaign_name, ROUND(SUM(revenue_generated * 0.012), 2) AS revenue_usd
FROM marketing_performance
GROUP BY campaign_name
ORDER BY revenue_usd DESC
LIMIT 10;

