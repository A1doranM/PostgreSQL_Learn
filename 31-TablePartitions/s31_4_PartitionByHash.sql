-- Partition by Range
#########################

/*

    1. The table is partitioned by specifying a modulus and a remainder for each partition.

    2. This type is useful when we can`t logically divide your data.

    3. Use this type if you want to reduce the table size by spreading rows into many
        smaller partitions.

    4. Lets divide our employees_hash master table to 3 (almost) equally # of data rows.

*/

-- Lets create the master table 'employees_hash'
-- PARTITION BY HASH (field)

CREATE TABLE employees_hash (
  id bigserial,
  birth_date DATE NOT NULL,
  country_code VARCHAR(2) NOT NULL
) PARTITION BY HASH (id);

-- Now we will create individual partition tables based on id values

-- Lets create yearly partition:

CREATE TABLE partition_table_name PARTITION OF master_table
    FOR VALUES WITH (MODULUS m, REMAINDER n);

CREATE TABLE employees_hash_1 PARTITION OF employees_hash
    FOR VALUES WITH (MODULUS 3, REMAINDER 0);

CREATE TABLE employees_hash_2 PARTITION OF employees_hash
    FOR VALUES WITH (MODULUS 3, REMAINDER 1);

CREATE TABLE employees_hash_3 PARTITION OF employees_hash
    FOR VALUES WITH (MODULUS 3, REMAINDER 2);

-- Now system equally distribute data between 3 partition tables based on hash from id.

-- INSERT Operations
-- NEVER insert in partition table, insert data only in master table

INSERT INTO employees_hash (birth_date, country_code) VALUES
('2000-01-01', 'US'),
('2000-01-02', 'FR'),
('2000-01-03', 'IT');

-- SELECTING data
-- If we does not specify WHERE condition PostgreSQL scan all partitions,
-- but if we write query like this

SELECT * FROM employees_hash
WHERE id = 2;

-- The PostgreSQK directly access the partition table 'employees_hash_3'
