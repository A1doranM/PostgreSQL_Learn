-- get the highest, lowest, total, and average salary of all employees.

--function: Rount, Min, Max, Sum, Avg

select 
	max(salary),
	min(salary),
	avg(salary),
	sum(salary)
from employees;

select
	department_id,
	max(salary),
	min(salary),
	avg(salary),
	sum(salary)
from employees
group by department_id;

-- query to get ther difference between the highest and lowest result.

select 
	job_id,
	max(salary) - min(salary),
	avg(salary),
	sum(salary)
from employees
group by job_id;

-- query to lowest-paid salary paid by each manager_id

select 
	manager_id,
	min(salary)
from employees
group by manager_id;

select 
	manager_id,
	min(salary)
from employees
where 
	manager_id is not null and manager_id != 0 
group by manager_id
order by min(salary);

-- average salary for each department with more than 10 employees.

select 
	department_id,
	avg(salary) as "average salary",
	count (*) as "total employees"
from employees
group by department_id
having count(*) > 10
order by 3;

-- query to get the average salary for each post excluding programmer (IT_PROG)
-- function: NOT IN

select 
	job_id,
	round(avg(salary), 0) as "average salary"
from employees
where job_id not in ('IT_PROG')
group by job_id;

-- or 

select 
	job_id,
	round(avg(salary), 0) as "average salary"
from employees
where job_id <> ('IT_PROG')
group by job_id;

-- query to list maximum salary of each post for maximum salary is at or above $5000

select 
	job_id,
	round(avg(salary), 0) as "average salary"
from employees
where job_id not in ('IT_PROG')
group by job_id
having avg(salary) > 5000;

-- display emloyees name (first_name, last_name) using an alias name "First Name", "Last Name"

select 
	first_name as "First Name",
	last_name as "Last Name"
from employees;

-- get the names (first_name, last_name), salary and calculate 15% of salary for all employees.

select 
	first_name as "First Name",
	last_name as "Last Name",
	salary*0.15 as "15% of salary"
from employees;

-- query to get the job_id and all the employees ID(s) within each job_id group.
-- funtion: ARRAY_AGG(column)

select 
	j.job_id,
	array_agg(employee_id) as "Employees id"
from employees e
right join jobs j on e.job_id = j.job_id
group by j.job_id
order by array_length(array_agg(employee_id), 1);

-- get all employees, and discard the last four characters from email
-- functions

-- length(string)
-- substr(string, from, to)
-- reverse(string)

select 
	first_name,
	last_name,
	substr(email, 0, length(email) - 4)
from employees;

-- list all employees with first_name starts with letters "A", "C", "M"
-- function: LIKE (string)

select 
	first_name 
from employees
where first_name LIKE('A%') or first_name LIKE('C%') or first_name LIKE('M%');

-- get all the first name from the employees table in upper case or lower case

select 
	lower(first_name),
	upper(first_name)
from employees;

-- get unique numbers of designation available in the employees table

select 
	distinct job_id
from employees;

-- update phone_number column with '888' where the substring '123' found.
-- function: UPDATE, REPLACE (column, search_string, replace_string)

select 
	*
from employees;

update 
	employees 
	set 
		phone_number = replace(phone_number, '123', '888');

-- query to display the last name of employees whose name contain exactly six characters.
-- function: LIKE

select 
	last_name
from employees
where last_name like '______';

-- or 

select 
	last_name
from employees
where length(last_name) = 6;










