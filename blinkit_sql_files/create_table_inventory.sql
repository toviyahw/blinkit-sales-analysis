CREATE TABLE inventory(
product_id TEXT,
date DATE,
stock_received INTEGER,
damaged_stock INTEGER,
PRIMARY KEY (product_id, date)
);