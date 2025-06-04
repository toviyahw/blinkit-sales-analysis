SELECT sentiment, ROUND(AVG(rating), 2) AS avg_rating
FROM customer_feedback
GROUP BY sentiment
ORDER BY avg_rating DESC;
