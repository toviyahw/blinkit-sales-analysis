SELECT campaign_name,
       ROUND(SUM(spend) / NULLIF(SUM(conversions), 0), 2) AS customer_aqc_cost
FROM marketing_performance
GROUP BY campaign_name
ORDER BY customer_aqc_cost ASC;

