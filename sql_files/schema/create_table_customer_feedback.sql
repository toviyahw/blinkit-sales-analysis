CREATE TABLE customer_feedback(
feedback_id TEXT PRIMARY KEY,
order_id TEXT,
customer_id TEXT,
rating INTEGER,
feedback_text TEXT,
feedback_category TEXT,
sentiment TEXT,
feedback_date DATE
);