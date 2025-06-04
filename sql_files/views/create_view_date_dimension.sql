CREATE VIEW date_dimension AS
SELECT 
    GENERATE_SERIES(MIN(order_date::date), MAX(order_date::date), INTERVAL '1 day')::date AS date
FROM orders;
