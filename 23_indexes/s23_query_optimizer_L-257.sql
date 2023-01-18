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
*/
