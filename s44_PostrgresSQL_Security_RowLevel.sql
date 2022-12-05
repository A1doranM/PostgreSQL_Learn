-- Row level security

/*

   1. Must be enable at table level, not enable by default

   ALTER TABLE [table_name] ENABLE ROW LEVEL SECURITY;

   2. After enable the row level policy, the default value is : Deny ALL;

*/

-- Setup row level security;

ALTER TABLE jobs ENABLE ROW LEVEL SECURITY;

-- Create a row level policy.

CREATE POLICY [policy_name] on [table_name]
FOR SELECT|INSERT|UPDATE|DELETE
TO [role_name]
USING (expression)

-- create a policy where 'sales' can only view all jobs where max_salary > 10000;

SELECT * FROM jobs WHERE max_salary >= 10000

CREATE POLICY p_jobs_sales_max_salary_10000 ON jobs
FOR SELECT
TO sales
USING (max_salary >= 10000);

-- lets add additional row level policy for 'sales' on table jobs where they can
-- view all rows where min_salary >= 4000;

CREATE POLICY p_jobs_sales_min_salary_4000 ON jobs
FOR SELECT
TO sales
USING (min_salary >= 4000);

-- combined query with OR
SELECT * FROM jobs WHERE (max_salary >= 10000 OR max_salary >= 4000);

-- drop policy

DROP POLICY [policy_name]

DROP POLICY p_jobs_sales_min_salary_4000 ON jobs;

-- create policy using for specific user

CREATE POLICY rls_t_users_data_by_username ON t_user_data
FOR ALL TO PUBLIC
using (username=current_user);

-- Row level security for application users

/*

    1. While creating policies for users we have used current_user and matched it with the
       user entry present in the table.

    2. But there are cases where there are too many users, like web applications, and it`s not
       feasible to create and explicit role for each application user.

    3. Our objective remains the same:
       a user should only be able to view their own data and not others

    4. One solution may be:

        - Instead of using current_user, we can change our policy to use a session variable.
        - Session variables can be initialized each time a new user tries to see data.

*/

-- Create policy that uses session variable

CREATE POLICY rls_t_users_data_by_username ON t_user_data
FOR all TO public
USING (username=current_setting('rls.username'));

-- set session variable

set rls.username = "tech";
