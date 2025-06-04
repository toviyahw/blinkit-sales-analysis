SELECT campaign_name, roas, spend, channel, date
FROM marketing_performance
WHERE roas < 1
ORDER BY roas ASC;


