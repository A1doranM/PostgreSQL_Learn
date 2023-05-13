-- Partition by Range
#########################

/*

    - The table is partitioned into ranges defined by a key column or
        set of columns, with NO OVERLAP between the ranges of values
        assigned to different partitions.
    - Useful when working ith dates Days/Weekly/Month.
    - A multi-level design can reduce query planning time, but a flat
        partition design runs faster.

*/

-- Lets create the master table 'employees_range'
-- PARTITION BY RANGE (field)

CREATE TABLE employees_range (
  id bigserial,
  birth_date DATE NOT NULL,
  country_code VARCHAR(2) NOT NULL
) PARTITION BY RANGE (birth_date);

-- Now we will create individual partition tables based on birth_date range values
-- FROM value1 TO value2

-- Lets create yearly partition:

CREATE TABLE partition_table_name PARTITION TO master_table
    FOR VALUES FROM value1 TO value2

CREATE TABLE employees_range_y2000 PARTITION TO employees_range
    FOR VALUES FROM ('2000-01-01') TO ('2001-01-01');

CREATE TABLE employees_range_y2001 PARTITION TO employees_range
    FOR VALUES FROM ('2001-01-01') TO ('2002-01-01');

-- INSERT Operations
-- NEVER insert in partition table, insert data only in master table

INSERT INTO employees_range (birth_date, country_code) VALUES
