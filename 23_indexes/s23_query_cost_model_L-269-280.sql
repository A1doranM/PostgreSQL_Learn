-- The Query cost model
/*

    -- The more bigger query the more workers PostgreSQL apply to it.

    SHOW max_parallel_workers_per_gather
    SET max_parallel_workers_per_gather TO 0;

    SELECT pg_relation_size('t_big')

    SHOW seq_page_cost;

    SHOW cpu_tuple_cost;

    SHOW cpu_operator_cost;

    -- cost formula

    pg_relation_size * seq_page_cost + total_number_of_table_records * cpu_tuple_cost
    + total_number_of_table_records * cpu_operator_cost

    -- index are not free
    -----------------------------------------

    -- index size
    SELECT pg_size_pretty(pg_indexes_size('TABLE_NAME'))

    -- Partial Index - improve the performance of the query while reducing size of the
    -- index

    -- e.g. create index that includes names without 'Adam' and 'Linda'

    CREATE INDEX idx_p_t_big_name ON t_big(name)
    WHERE
        name NOT IN ('Adam', 'Linda')

    -- Expression Index

    1. An index created based on an 'expression'

    2. PostgreSQL will consider using that index when the expression that defines the
       index appears in the WHERE, or ORDER BY clause

    3. It is very expensive index

    CREATE INDEX index_name ON table_name (expression);

    -- e.g.

    CREATE INDEX idx_expr_t_dates ON t_dates(EXTRACT(day FROM d));

    -- Adding data while indexing
    -- by default create index command lock the table during indexing
    -- to avoid that use

    CREATE INDEX CONCURRENTLY idx_t_big_name on t_big(name);

    -- View all indexes for a table

    SELECT oid, relname, relpages, reltuples,
           i.indisunique, i.indisclustered, i.indisvalid,
           pg_catalog.pg_get_indexdef(i.indexrelid, 0, true)
           FROM pg_class c JOIN pg_index i on c.oid = i.indrelid
           WHERE c.relname = 'orders';

    -- Rebuild index

    REINDEX [INDEX | TABLE | SCHEMA | DATABASE | SYSTEM] index_name;

    -- if you need additional info use VERBOSE

    -- e.g. reindex all indexes in table
    REINDEX (VERBOSE) TABLE table_name

    -- e.g reindex all schema concurrently
    REINDEX (VERBOSE) SCHEMA CONCURRENTLY schema_name

*/
