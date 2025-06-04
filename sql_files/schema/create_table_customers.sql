CREATE TABLE customers(
customer_id TEXT PRIMARY KEY,
customer_name TEXT,
email TEXT,
phone TEXT,
address TEXT,
area TEXT,
pincode TEXT,
registration_date DATE,
customer_segment TEXT,
total_orders INTEGER,
avg_order_value NUMERIC(12,2)
);