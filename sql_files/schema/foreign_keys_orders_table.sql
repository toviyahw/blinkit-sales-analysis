ALTER TABLE orders
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id);