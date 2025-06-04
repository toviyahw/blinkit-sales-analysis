CREATE TABLE inventory (
    inventory_id SERIAL PRIMARY KEY,
    product_id TEXT,
    date DATE,
    stock_received INTEGER,
    damaged_stock INTEGER
);
