-- Try to ceep the naming convention for indexes;
-- e.g. idx_[table_name]_[column_name]

CREATE INDEX idx_orders_order_date ON orders(order_date);

-- or for multiple column indexes;

CREATE INDEX idx_orders_customer_id_order_id ON orders(customer_id, order_id);

-- In multi-column indexes order of column have very high matter and we
-- should always place most selective column first. PostgreSQL will
-- consider a multi-column index from the first column onward, so if the
-- first column are the most selective, the index access method will be the
-- cheapest.




