-- Partitioning
#####################

/*
   1. Partitioning is splitting one table into;

        --multiple smaller,
        --logically divided, and
        --more manageable pieces tables

   2. Partition leads to a huge performance boost;

        Postgres is able to exclude partitions that, for sure, won`t be
        affected by the data we are reading or writing.
        Read/Write only what is needed!

    3. Partitioned tables can improve query performance by allowing the
        Database query optimizer to scan only the data needed to satisfy
        a given query instead of scanning all the contents of a large table

    Key guidelines:

    1. When we have a large table or is the table large enough?

        - Large fact tables are good. If you have millions or billions of
            records
        - Don`t thonk about partitioning before reaching several millions
            of records, as there would no gain in performance
        - Also, for smaller tables with only a few thousand rows or less,
            the administrative overhead of maintaining the partitions will
            overweight any performance benefits

    2. Your table qualify to be able to logically divided into smaller chunks

        - e.g. server logs, where tou can split them by date

    3. Experiencing unsatisfactory performance/slow queries?

        - Although always first check the query plans.
        - Test with partition table to see if the query executions times
            increased after the partition or not.

    4. To avoid scanning the entire table, and have fast query processing

        - Review indices on large table i.e. primacy, foreign keys and
            composite indices before partitioning

    5. In a large table, some columns are frequently occurring in WHERE clause

        - Examine the WHERE clauses of your query workload and look for table
            columns that are consistently used to access data

        - Partition based on most frequent query conditions e.g.
            dates, regions, etc.

    6. Table can`t fit in memory

        - Strongly advice not to reach this limit, usually when a table
            hits the size of some gigabytes it is time to partition.
        - Always try to achieve the efficient usage of memory

    7. Business requirements for maintaining historical data

        - For example, your data warehouse may require that you keep data for
            the past twelve months. If the data is partitioned by month, you
            can easily drop the oldest monthly partition from warehouse and load
            current data into the most recent monthly partition.

    8. Is your data can be divided into say equal parts based on some good
        criteria?

        - When partitioning, tru to divide your data as evenly as possible
        - Partitions containing a relatively equal number of records will
            boost query execution performance

    9. Do not create more partitions than are needed.

        - Having too many partitions means overhead on management/maintenance tasks like:
            - vacuuming,
            - recovering segments,
            - expanding the cluster,
            - checking disk usage, and others

    10. Queries that scan every partition run slower than if the table
        were not partitioned correctly.

    11. Be very careful with multi-level partitioning because the number of
        partition files can grow very quickly.

        - For example, if a table is partitioned bu both day and city, and
            there are 1000 days and 1000 cities the total number of partitions
            is one million.
        - Also column-oriented tables will store each column in a physical table
          so if this table has 100 columns, the system would be required to
          manage 100 million files for the table.

        master level
            partition level 1
                partition level 2 is completely enough for most cases

    12. So look at data -> view most frequent queries -> create test partition -> improve bit by bit

    ------------------------------------------------------

    Table inheritance

        - In Postgres table inherits from its parent node
        - An example: master -> master_child

     CREATE TABLE master (
        pk INTEGER PRIMARY KEY,
        tag TEXT,
        parent INTEGER
     );

     CREATE TABLE master_child() INHERITS (master);

     -- If data added, or deleted data in master table they duplicate
     -- in child.

     -- If data added to child they do not duplicate in master

     - To see data only from master, of for child use:

     SELECT * FROM ONLY master;

     SELECT * FROM ONLY master_child;

    - You can not drop master until child exists. To drop master
        with child tables use:

    DROP TABLE master CASCADE;

    ----------------------------------------------------------

    Partition types

    1. Range
        The table is partitioned into "ranges" defined by a key
        column or set of columns, with no overlap between the ranges
        of values assigned to different partitions.

    2. List
        The table is partitioned bu explicitly listing which key
        values appear in each partition.

    3. Hash
        The table is partitioned by specifying a modulus and a
        remainder for each partition. Each partition will hold the
        rows for which the hash value of the partition key divided
        by the specified modules will produce the specified remainder.


*/


