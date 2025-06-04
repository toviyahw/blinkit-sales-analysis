ALTER TABLE customer_feedback
ADD FOREIGN KEY (order_id) REFERENCES orders(order_id),
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id);