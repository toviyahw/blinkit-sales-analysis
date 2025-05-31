CREATE TABLE products (
    product_id TEXT PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    brand TEXT,
    price NUMERIC(10,2),
    mrp NUMERIC(10,2),
    margin_percentage NUMERIC(5,2),
    shelf_life_days INTEGER,
    min_stock_level INTEGER,
    max_stock_level INTEGER
);