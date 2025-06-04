SELECT channel, ROUND(100.0 * SUM(clicks) / NULLIF(SUM(impressions), 0), 2) AS ctr
FROM marketing_performance
GROUP BY channel
ORDER BY ctr DESC;
