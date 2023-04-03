-- The optimizer

/*

    1. The lowest cost win.
       If the query is large (about 10 - 20 joins) optimizer uses more generic
       algorithm which not always optimal.

    2. Nodes

    e.g. For this statement SELECT * FROM orders order by order_id; optimizer
    creates two nodes.
          First node all data
          Second node order by

    -- Optimizer Nodes types

        1. Nodes are available for:
            - every operations and
            - every access methods

        2. Nodes are stackable
            Parent Nodes
                Child Node 1
                    Child Node 2
                        ......
            the output of a node can be used as input to another node.

        3. Types of Nodes
            - Sequential Scan
            - Index Scan, Index Only Scan, and Bitmap Index Scan
            - Nested Loop, Hash Join and Merge Join
            - The Gather and Merge parallel nodes

        e.g. Look at types of nodes uses our PostgreSQL
        SELECT * FROM pg_am;

    -- Sequential Scan

        1. Default when no other valuable alternative.

        2. Read from the beginning of the dataset;

        3. Filtering clause is not very limiting, so that the end result
            will be to get almost the whole table contents - sequential read-all
            operation faster.

        4. Sequential scan has high cost.

        To see how optimizer chooses how to execute query run  EXPLAIN command e.g:
        EXPLAIN SELECT * FROM orders;

    -- Index Nodes

        1. An index is used to access the dataset

        2. Data file and index files are separated but they are nearby

        3. Index Nodes scan type

            Index Scan          if query uses index columns with not index columns -> seeking the tuples -> then read again the data

            Index Only Scan     if query uses index columns only -> directly get data from index file

            Bitmap Index Scan   builds a memory bitmap of where tuples that satisfy the statement clauses

    -- Join Nodes

    Types:
    1. Inner table - build a hash table from the inner table, keyed by the join key.
    2. Outer table - then scan the outer table, checking if a corresponding value is present.

    SHOW work_mem
    ORDER BY, DISTINCT, AND MERGE JOINS

    HASH table -> hash joins, hash-based aggregation and hash-based processing IN subqueries

    e.g.
    SELECT * FROM orders where order_id IN ('');

    -- Merge Join

    Joins two children already sorted by their shared join key. This only needs to scan
    each relation once, but both inputs need to be sorted by the join key first (or scanned
    in a way that produces already-sorted output like and index scan matching the required sort order)

    -- Nested Loop

    For each row in the outer table, iterate through all the rows in the inner table and see
    if they match the join condition. If the inner relation can be scanned with an index, that can
    improve the performance of a Nested Loop Join. tThis is generally and inefficient way to process joins
    but is always available and sometimes mey be the only option

    e.g.
    EXPLAIN SELECT * FROM orders
    NATURAL JOIN customers;

*/
