CREATE TABLE delivery_performance(
order_id TEXT PRIMARY KEY,
partner_id TEXT,
promised_time TIMESTAMP,
actual_time TIMESTAMP,
delivery_time_minutes NUMERIC(6,2),
distance_km NUMERIC(6,2),
delivery_status TEXT,
reasons_if_delayed TEXT
);