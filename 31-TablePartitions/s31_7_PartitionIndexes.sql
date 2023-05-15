-- Partition Indexes
-- ###########################

/*

   Good:
        1. Creating or deleting an index on the master/parent table will automatically
            create or delete same indexes to every attached partition.

   Little Bad:
        2. PostgreSQL does not allow a way to create a SINGLE INDEX covering every partition of the
            parent table. You have to create an index for each and every partition.

        3. The primary key, or any other unique index, must include the columns used on the
            partition by statement.

*/

-- UNIQUE INDEX in partitions.

-- Lets create an unique index on employees_list parent table with parent key id only.

CREATE UNIQUE INDEX idx_uniq_employees_list_id ON employees_list (id);

-- And this is how we create unique index on partition table.

CREATE UNIQUE INDEX idx_uniq_employees_list_id_country_code ON employees_list (id, country_code);

-- Adding the partition key to the next is the only way to grant the uniqueness of the record
-- across the whole table. If we do not do it over here, that may not be a good thing, because
-- by adding this combination we are adding a uniqueness to the whole table on partition tables.
