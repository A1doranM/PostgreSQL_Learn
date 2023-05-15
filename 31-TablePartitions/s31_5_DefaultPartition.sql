-- DEFAULT PARTITION
-- ###########################

-- What happens when we try to insert a record that can`t fit into any partition?

-- ERROR

-- But PostgreSQL provides functionality to handle such cases using DEFAULT partition.

CREATE TABLE partition_table_name PARTITION OF parent_table_name DEFAULT;

-- e.g.

CREATE TABLE employees_list_default PARTITION OF employees_list DEFAULT;
