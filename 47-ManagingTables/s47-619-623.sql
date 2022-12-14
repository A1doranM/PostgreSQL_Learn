-- Managing rows in PostgreSQL
/*
    When you UPDATE a value in a row PostgreSQL creates a NEW VERSION of that
    row includes updated value, but it does not delete old version of the row,
    then it marks it as dead row.

    When we DELETE a row it lives as a dead row in the table.

    The database engine uses these dead rows to provide certain features in
    environments where multiple transactions are happening and old versions of
    the rows might be needed by transactions other the current one.

*/

-- Tracking table size

CREATE TABLE table_vacuum (
    id integer
);

-- Lets view size of the table

SELECT
    pg_total_relation_size('table_vacuum'),
    pg_size_pretty(pg_total_relation_size('table_vacuum'));

SELECT * from table_vacuum; -- 0

-- Lets INSERT data

INSERT INTO table_vacuum
SELECT * FROM generate_series(1,4000); -- 2152 kB

-- Lets UPDATE some basic data

UPDATE table_vacuum
    SET id = id + 1; -- 11 MB !!!!

