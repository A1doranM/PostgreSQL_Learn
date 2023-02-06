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


*/
