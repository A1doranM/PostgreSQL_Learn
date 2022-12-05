-- Column level security

/*

   SELECT - read data from column;

   INSERT

   UPDATE

   REFERENCE - ability to refer the column as foreign key

   *NO DELETE*

*/

GRANT [permission_name] (col1, col2, col3, ...) on [table_name] to [role_name];

-- restrict employees table columns phone_number, salary etc to be see bt 'sales' group;

REVOKE SELECT ON ALL TABLES IN SCHEMA public FROM sales;

GRANT SELECT (
    employee_id,
    first_name,
    last_name,
    phone_number
) ON employees TO sales;
