ALTER TABLE delivery_performance
ADD FOREIGN KEY (order_id) REFERENCES orders(order_id);