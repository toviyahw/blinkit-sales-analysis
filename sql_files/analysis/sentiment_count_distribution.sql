SELECT sentiment, COUNT(*) AS feedback_count
FROM customer_feedback
GROUP BY sentiment
ORDER BY feedback_count DESC;
