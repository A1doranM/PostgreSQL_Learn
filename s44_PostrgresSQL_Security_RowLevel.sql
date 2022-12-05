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
