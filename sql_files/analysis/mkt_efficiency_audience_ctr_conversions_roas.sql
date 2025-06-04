SELECT target_audience,
       ROUND(100.0 * SUM(clicks) / NULLIF(SUM(impressions), 0), 2) AS ctr,
       ROUND(100.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 2) AS conversion_rate,
       ROUND(SUM(revenue_generated) / NULLIF(SUM(spend), 0), 2) AS roas
FROM marketing_performance
GROUP BY target_audience
ORDER BY roas DESC;
