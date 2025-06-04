SELECT target_audience,
       ROUND(SUM(spend) / NULLIF(SUM(conversions), 0), 2) AS cost_per_conversion
FROM marketing_performance
GROUP BY target_audience
ORDER BY cost_per_conversion ASC;

