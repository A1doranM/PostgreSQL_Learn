-- SQL Functions
-- ############################

/*

    1. SQL functions are athe easiest way to write function in PostgreSQL

    2. We can use any SQL command inside them.

*/

CREATE OR REPLACE FUNCTION function_name(param1, param2) RETURNS void AS
$$
    -- SQL commands

    -- To access params we can use $1, $2, $3 ... or name of the param

    SELECT $1, $2;

    SELECT param1, param2;

$$
LANGUAGE SQL;

-- e.g.

CREATE OR REPLACE FUNCTION fn_sum(int, int)
RETURNS in AS
$$
    SELECT $1 + $2;
$$
LANGUAGE SQL;

-- or

-- usage

SELECT fn_sum(10, 20);

-- another function example

CREATE OR REPLACE FUNCTION fn_employees_update_country()
RETURNS void AS
$$
    UPDATE employees
    SET country = 'N/A'
    WHERE
        country is NULL;
$$
LANGUAGE SQL;

SELECT fn_employees_update_country();

-- We can return table from function

CREATE OR REPLACE FUNCTION fn_employees_latest_hire()
RETURNS employee AS
$$
    SELECT
        *
    FROM employees
    ORDER BY hire_date DESC
    LIMIT 1;
$$
LANGUAGE SQL;

SELECT (fn_employees_latest_hire()).*;
SELECT (fn_employees_latest_hire()).first_name;

-- or

SELECT
    *
FROM fn_employees_latest_hire();

-- Returning multiple rows, for this we should use RETURNS SETOF

CREATE OR REPLACE FUNCTION fn_employees_hire_date_by_year(p_year integer)
RETURNS SETOF employee AS
$$
    SELECT
        *
    FROM employees
    WHERE
        EXTRACT ('YEAR' FROM hire_date) = p_year
$$
LANGUAGE SQL;

SELECT
    *
FROM fn_employees_hire_date_by_year('1993'));

-- Function can return table with operator RETURNS TABLE (col1 type, col2 type, ...)

CREATE OR REPLACE FUNCTION fn_customer_top_orders(p_customer_id, p_limit)
RETURNS TABLE
(
    order_id smallint,
    customer_id bpchar,
    product_name varchar,
    unit_price real,
    quantity smallint,
    total_order double precision
)
AS
$$
    SELECT
        orders.order_id,
        orders.customer_id,

        products.product_name,

        order_details.unit_price,
        order_details.quantity
    FROM order_details
    NATURAL JOIN orders
    NATURAL JOIN products
    WHERE
        orders.customer_id = 'VINET'
    LIMIT p_limit;
$$
LANGUAGE SQL;

SELECT
    *
FROM fn_customer_top_orders('1', 10);
