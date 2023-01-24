/*

    Index Types

    # B-Tree Index
    -------------

    1. Default Index
    2. self-balancing tree
        - SELECT, INSERT, DELETE and sequential access in logarithmic time

    3. Can be used for most operators and column type
    4. Supports the UNIQUE condition and
    5. Normally user to build the primary key indexes
    6. Uses when columns involves following operators:
         <
         <=
         =
         >=
         BETWEEN
         IN
         IS NULL
         IS NOT NULL

    e.g. SELECT * FROM orders WHERE order_id IN ('1', '2', '3').

    7. Use when Pattern matching
        even for LIKE based queries

        e.g. customer_id LIKE 'VI%'

    - Drawback: copy the whole columns values into the tree structure.


    # Hash Index
    -----------

    1. For equality operators (only simple equality comparison =)
    2. not for range nor disequality operators
    3. Larger then btree indexes

    e.g.
    CREATE INDEX idx_orders_order_date ON orders USING hash (order_date);

    and SELECT

    SELECT * FROM orders WHERE order_date = '2020-01-01';


    # BRIN (Block range index) Index
    --------------

    1. Block range indexes
    2. data block -> min to max values
    3. Smaller index
    4. Less costly to maintain than btree index
    5. Can be used on a large table vs btree index
    6. Used linear sort order e.g. customer -> order_date


    # GIN (generalized inverted indexes) Index
    ------------------------------------------

    1. Generalized inverted indexes
    2. Point to multiple tuples
    3. Used with array type data
    4. Used in full text-search
    5. Useful when we have multiple values stored in a single column
*/
