create table courses(
	course_id serial primary key,
	course_name varchar(50),
	course_level varchar(50),
	sold_units int not null
);

insert into courses(
	course_name,
	course_level,
	sold_units
) 
values 
	('Test Course 1', 'Premium', 100),
	('Test Course 2', 'Basic', 50),
	('Test Course 3', 'Premium', 100),
	('Test Course 4', 'Premium', 200),
	('Test Course 5', 'Legendary', 200),
	('Test Course 6', 'Premium', 100),
	('Test Course 7', 'Premium', 100);
	
select * from courses;


select * from courses
order by course_level, sold_units;


select 
	course_level,
	sum(sold_units) as "Total Sold"
from courses
group by 
	course_level;
	
	
select 
	course_level,
	course_name,
	sum(sold_units) as "Total Sold"
from courses
group by 
	course_level,
	course_name
order by
	course_level,
	course_name;
	
	
select 
	course_level,
	course_name,
	sum(sold_units) as "Total Sold"
from courses
group by 
	rollup (
		course_level,
		course_name
	)
order by
	course_name,
	course_level;
	
	

select 
	course_level,
	course_name,
	sum(sold_units) as "Total Sold"
from courses
group by 
	course_level,
	rollup (
		course_name
	)
order by
	course_name,
	course_level;
	

alter table courses
add column course_teacher varchar(50);


select * from courses;
	
	
insert into courses(
	course_name,
	course_level,
	course_teacher,
	sold_units
) 
values 
	('Test Course 1', 'Premium', 'Teacher 1', 100),
	('Test Course 2', 'Basic', 'Teacher 5', 50),
	('Test Course 3', 'Premium', 'Teacher 2', 100),
	('Test Course 4', 'Premium', 'Teacher 3', 200),
	('Test Course 5', 'Legendary', 'Teacher 4', 200),
	('Test Course 6', 'Premium', 'Teacher 4', 100),
	('Test Course 7', 'Premium', 'Teacher 6', 100);
	
	
select 
	course_name,
	course_level,
	sum(sold_units) as "SUM"
from courses
group by 
	course_name,
	course_level
order by 
	course_name,
	course_level;
	
	
select 
	course_teacher,
	course_level,
	sum(sold_units) as "SUM",
	grouping(course_level) as "Level Grouping",
	grouping(course_teacher) as "Teacher Grouping"
from courses
group by 
	rollup(
		course_teacher,
		course_level
	)
order by 
	course_teacher,
	course_level;
	
	
 
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	