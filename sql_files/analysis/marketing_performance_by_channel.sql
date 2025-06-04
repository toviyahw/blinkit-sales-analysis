SELECT 
    channel,
    SUM(impressions) AS total_impressions,
    SUM(clicks) FILTER (WHERE clicks > 0) AS engaged_users,
    SUM(conversions) FILTER (WHERE conversions > 0) AS converted_users
FROM marketing_performance
GROUP BY channel;



