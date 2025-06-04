SELECT channel, campaign_name, roas,
       RANK() OVER (PARTITION BY channel ORDER BY roas DESC) AS roas_rank
FROM (
    SELECT channel, campaign_name,
           ROUND(SUM(revenue_generated) / NULLIF(SUM(spend), 0), 2) AS roas
    FROM marketing_performance
    GROUP BY channel, campaign_name
) ranked_campaigns_by_channel
ORDER BY channel, roas_rank;

