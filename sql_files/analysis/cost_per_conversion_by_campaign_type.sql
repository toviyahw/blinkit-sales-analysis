SELECT campaign_name,
       ROUND(SUM(spend) / NULLIF(SUM(conversions), 0), 2) AS cost_per_conversion
FROM marketing_performance
GROUP BY campaign_name
ORDER BY cost_per_conversion ASC;