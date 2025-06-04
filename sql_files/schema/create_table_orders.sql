CREATE TABLE orders(
order_id TEXT PRIMARY KEY,
customer_id TEXT,
order_date TIMESTAMP,
promised_delivery_time TIMESTAMP,
actual_delivery_time TIMESTAMP,
delivery_status TEXT,
order_total NUMERIC(10,2),
payment_method TEXT,
delivery_partner_id TEXT,
store_id TEXT
);