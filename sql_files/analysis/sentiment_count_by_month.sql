SELECT DATE_TRUNC('month', feedback_date) AS month,
       sentiment,
       COUNT(*) AS sentiment_count
FROM customer_feedback
GROUP BY month, sentiment
ORDER BY month, sentiment;
