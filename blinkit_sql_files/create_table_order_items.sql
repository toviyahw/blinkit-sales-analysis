CREATE TABLE order_items(
order_id TEXT,
product_id TEXT,
quantity INTEGER,
unit_price NUMERIC(10,2),
PRIMARY KEY (order_id, product_id)
);