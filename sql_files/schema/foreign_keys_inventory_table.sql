ALTER TABLE inventory
ADD FOREIGN KEY (product_id) REFERENCES products(product_id);