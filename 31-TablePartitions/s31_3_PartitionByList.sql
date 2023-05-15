-- Partition by Range
#########################

/*

    1. The table is partitioned by explicitly listing which key values appear in each partition

    2. A list partitioned table can use any data type column that allows equality comparisons
        as its partition key column.

    3. Can also have a multi-column partition key

    4. Ideal for conditions when you know known values of partition key e.g. country codes,
        month_names

    5. We create partition by LIST when we want to create a partition on a list of values.

*/

-- Lets create the master table 'employees_list'
-- PARTITION BY LIST (field)

CREATE TABLE employees_list (
  id bigserial,
  birth_date DATE NOT NULL,
  country_code VARCHAR(2) NOT NULL
) PARTITION BY LIST (country_code);

-- Now we will create individual partition tables based on country_code values

-- Lets create partition:

CREATE TABLE employees_list_us PARTITION TO employees_list
    FOR VALUES IN ('US');

CREATE TABLE employees_list_eu PARTITION TO employees_list
    FOR VALUES IN ('UK', 'DE', 'IT', 'FR');

-- INSERT Operations
-- NEVER insert in partition table, insert data only in master table

INSERT INTO employees_list (birth_date, country_code) VALUES
('2000-01-01', 'US'),
('2000-01-02', 'FR'),
('2000-01-03', 'IT');
