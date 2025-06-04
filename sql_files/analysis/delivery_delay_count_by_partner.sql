SELECT partner_id, COUNT(*) AS delay_count
FROM delivery_performance
WHERE delivery_status != 'on time'
GROUP BY partner_id
ORDER BY delay_count DESC
LIMIT 10;





