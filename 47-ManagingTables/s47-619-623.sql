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

-- Autovacuum process

/*

    1. When we have a large number of rows gets deleted in a table, PostgreSQL launches the VACUUM automatically.
    2. Autovacuum process is enable by default.
    3. Autovacuum runs in the background. But you can check activity by a query
    4. By default, the Autovacuum runs every minute.
    5. Autovacuum does not delete dead rows.

*/

-- 1. Lets view the autovacuum process by query

SELECT
    relname,
    last_vacuum,
    last_autovacuum,
    vacuum_count,
    autovacuum_count,
    last_analyze,
    last_autoanalyze
FROM
    pg_stat_all_tables
WHERE
    relname = 'table_vacuum';

-- 2. Recovering unused space using VACUUM

VACUUM [FULL] [FREEZE] [VERBOSE] [ table_name ];
ANALYZE table_name [(col1, col2, col3)];

/*
    FULL - all unused space and requires an exclusive lock on each table that is vacuumed

    FREEZE - Optional, the turples are aggressively frozen when the table is vacuumed

    VERBOSE - Optional, am activity report will be printed

    table_name - Optional, is not specified all tables in the database will be vacuumed

    col1, col2 - Optional, same as table_name but for analyze.
*/

VACUUM VERBOSE table_vacuum;

-- 2. Lets view the autovacuum/vacuum processes by query

SELECT
    relname,
    last_vacuum,
    last_autovacuum,
    vacuum_count,
    autovacuum_count,
    last_analyze,
    last_autoanalyze
FROM
    pg_stat_all_tables

-- Vacuum create new table copy but without dead rows.

---------------------------------------------------------------------

-- Generated Columns

-- Generated columns it is columns computed based on values from another
-- columns.

CREATE TABLE t
(
    width real,
    height real,
    area real GENERATED ALWAYS AS (width * height) STORED
);

-- The value of area is computed at row creation time;

SELECT * FROM t;

-- Lets insert data

INSERT INTO t (width, height) VALUES (2, 2);

-- Or update data

UPDATE t
SET width = 10
WHERE width = 1;
