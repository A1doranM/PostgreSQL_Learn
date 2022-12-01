-- Order shipping to USA or France

select * from  orders order by ship_country;

select 
	*
from orders
where 
	ship_country = 'USA'
	or
	ship_country = 'France'
order by ship_country;

--count total numbers of orders shipping to USA or France

select 
	ship_country,
	count(*)
from orders
where 
	ship_country = 'USA'
	or
	ship_country = 'France'
group by ship_country
order by ship_country;

-- orders shipping to any countries within latin america

select 
	*
from orders
where 
	ship_country 
	in 
	('Brazil', 'Maxico', 'Argentina', 'Venezuela')
order by ship_country;

-- show order total amount per each order line

select 
	order_id,
	product_id,
	unit_price,
	quantity,
	discount,
	((unit_price * quantity) - discount) as total_order_amount
from order_details
order by 6 desc;

--find the first and the latest order dates

select 
	min(order_date) as min_order,
	max(order_date) as max_order
from orders;

-- total products in each categories

select 
	c.category_name,
	count(*) as total_products 
from products p  
inner join categories c on c.category_id = p.category_id
group by 1
order by 2 desc;

-- list products that needs re-ordering

unit_in_stock <= reorder_level

select 
	product_id,
	product_name,
	units_in_stock,
	reorder_level
from products
where units_in_stock <= reorder_level
order by 4 desc;

-- list to 5 highest freight charges

select 
	ship_country,
	avg(freight)
from orders
group by ship_country
order by 2 desc
limit 5;

-- list top 5 hightest freight charges in year 1997

select 
	ship_country,
	avg(freight)
from orders
where order_date between ('1997-01-01') and ('1997-12-31')
group by ship_country
order by 2 desc
limit 5;

-- list top 5 hightest freight charges last year

select 
	max(order_date) 
from orders;

select 
	ship_country,
	avg(freight),
	max(order_date)
from orders
where extract('Y' from order_date) >= extract('Y' from (select max(order_date) from orders))
group by ship_country
order by 2 desc
limit 5;

-- customers with no orders

select 
	*
from customers c
left join orders o on o.customer_id = c.customer_id
where 
	o.customer_id is null;

-- top customers with their order amount spend

select 
	c.customer_id,
	c.company_name,
	sum((od.unit_price * od.quantity) - od.discount) as total_amount
from customers c
join orders o on o.customer_id = c.customer_id
join order_details od on od.order_id = o.order_id
group by 
	c.customer_id,
	c.company_name
order by 3 desc
limit 10;

-- orders with many line of items

select * from order_details 
order by order_id

select 
	order_id,
	count(*)
from order_details
group by order_id
order by 2 desc;

-- oreders with double entry line items

select 
	order_id,
	quantity
from order_details
where quantity > 60
group by
	order_id,
	quantity
having
	count(*) > 1
order by 
	order_id;

select * from order_details where order_id = 10395;

--lets get the details of the items too

with duplicate_entries as 
(
	select 
		order_id,
		quantity
	from order_details
	where quantity > 60
	group by
		order_id,
		quantity
	having
		count(*) > 1
	order by 
		order_id
)
select 
	*
from order_details
where 
	order_id in (select order_id from duplicate_entries)
order by 
	order_id;

--List all late shipped orders

select 
	*
from orders
where shipped_date > required_date

--list employees with late shipped orders

late_orders
	employee_id,
	count(*)
	
all_orders
	employee_id,
	count(*)
	
select 
	
with late_orders as 
(
	select 
		employee_id,
		count(*) as total_late_orders
	from orders
	where
		shipped_date > required_date
	group by employee_id
),
all_orders as 
(
	select 
		employee_id,
		count(*) as total_orders
	from orders
	group by employee_id
)
select 
	employees.first_name,
	employees.employee_id,
	all_orders.total_orders,
	late_orders.total_late_orders
from employees
join all_orders on all_orders.employee_id = employees.employee_id
join late_orders on late_orders.employee_id = employees.employee_id
order by late_orders.total_late_orders;

-- countries with customers or suppliers

select 
	country
from customers

union

select 
	country 
from suppliers
order by country;

-- with duplicates

select 
	country
from customers

union all

select 
	country 
from suppliers
order by country;

-- countries with customers or suppliers 
-- using CTE

with countries_suppliers as  
(
	select 
		distinct country
	from suppliers
),
countries_customers as
(
	select 
		distinct country
	from customers
)
select 
	countries_suppliers.country as country_suppliers,
	countries_customers.country as country_customers
from countries_suppliers
full join countries_customers on countries_customers.country = countries_suppliers.country;

-- customers with multipple orders 
-- say within 4 days period

with next_order_date as 
(
	select 
		customer_id,
		order_date,
		lead (order_date, 1) over (partition by customer_id order by customer_id, order_date) as next_order_date
	from orders
)
select 
	customer_id,
	order_date,
	next_order_date,
	(next_order_date - order_date) as days_between_orders
from next_order_date
where
	(next_order_date - order_date) <= 4;


--first order from each country

with orders_by_country as 
(
	select 
		ship_country,
		order_id,
		order_date,
		row_number() over (partition by ship_country order by ship_country, order_date desc) country_row_number
	from orders
)
select 
	ship_country,
	order_id,
	order_date
from orders_by_country
where country_row_number = 1
order by ship_country;

select * from orders where ship_country = 'Argentina' order by order_date;





