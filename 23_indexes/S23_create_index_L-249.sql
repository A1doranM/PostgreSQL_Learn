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

-- UNIQUE INDEXES
-- If we define UNIQUE index for two or more columns the combined values in these columns
-- cannot be duplicated in multiple rows.

CREATE UNIQUE INDEX idx_u_products_product_id ON products (product_id);

-- Get list of all indexes

SELECT
    *
FROM
    pg_indexes;

-- indexes of a table

SELECT
    *
FROM
    pg_indexes
WHERE
	tablename = 'orders';

