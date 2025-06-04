CREATE VIEW campaign_performance_summary AS
SELECT 
    campaign_name,
    channel,
    target_audience,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(conversions) AS total_conversions,
    ROUND(100.0 * SUM(clicks) / NULLIF(SUM(impressions), 0), 2) AS ctr,
    ROUND(100.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 2) AS conversions,
    ROUND(SUM(spend) / NULLIF(SUM(conversions), 0), 2) AS cost_per_conversion,
    ROUND(SUM(revenue_generated) / NULLIF(SUM(spend), 0), 2) AS roas,
    
    -- categorize campaigns as high, moderate, or low performing
    CASE 
        WHEN ROUND(SUM(revenue_generated) / NULLIF(SUM(spend), 0), 2) >= 3 THEN 'High ROAS'
        WHEN ROUND(SUM(revenue_generated) / NULLIF(SUM(spend), 0), 2) BETWEEN 1.5 AND 3 THEN 'Moderate ROAS'
        ELSE 'Low ROAS'
    END AS performance_tier

FROM marketing_performance
GROUP BY campaign_name, channel, target_audience
ORDER BY campaign_name, channel, target_audience;
