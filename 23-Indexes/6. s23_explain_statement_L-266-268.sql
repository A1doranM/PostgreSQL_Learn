-- The EXPLAIN statement
/*

    1. It will show query execution plan
    2. Shows the lowest COST among evaluated plans
    3. Will not execute the statement you enter, just show query only
    4. Show you the execution nodes that the executor will use to provide you
        with the dataset.

    EXPLAIN you_statement.

    e.g.
    EXPLAIN SELECT * FROM suppliers WHERE supplier_id = 1;

    EXPLAIN OUTPUT STRUCTURE
    ------------------------

    - execution nodes
        - scan type | execution nodes table
    - every node
        cost
            startup cost    - how much work PostgreSQL has to do before it begins execution node
            final cost      - how much effort PostgreSQL has to do to provide the last bit of the dataset
        rows                - how many tuples the node is expected to provide for final dataset
        width               - how many bits every tuples will occupy


   -- EXPLAIN OUTPUT options
   -------------------------

   -- (FORMAT JSON)
   -- TEXT (default), XML, JSON, YAML

   EXPLAIN (FORMAT JSON) SELECT * FROM orders WHERE order_id = 1

   -- Using EXPLAIN ANALYZE
   ------------------------

   1. It prints out the best plan to execute the query and
   2. runs the query
   3. also report back some statistical information

   e.g.

   EXPLAIN ANALYZE SELECT * FROM orders WHERE order_id = 1 ORDER BY order_id;

*/
