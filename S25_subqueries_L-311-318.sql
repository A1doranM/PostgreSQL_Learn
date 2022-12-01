select *
from (
	select first_name, 0 myorder, 'actors' as "table" from actors 
	union
	select first_name, 1, 'directors' as "tablename" from directors
) t
order by myorder;

-- 312
select 
*
from (
	select 
	*
	from movies
) t;


-- 313
select 
*
from movies;

select (
		select max(revenues_domestic) from movies_revenues
	),
	(
		select min(revenues_domestic) as "Min domestic Revenues" from movies_revenues
	);


-- 314. Correlated Queries

select 
	mv1.movie_name,
	mv1.movie_length,
	mv1.movie_lang,
	mv1.age_certificate
from movies mv1	
where mv1.movie_length >
	(
		select
			min(movie_length)
		from movies mv2
		where mv1.age_certificate = mv2.age_certificate
	)
order by mv1.movie_length asc;


select 
	avg(movie_length)
from movies
where age_certificate = 'U';


select 
	ac1.first_name,
	ac1.last_name,
	ac1.gender,
	ac1.date_of_birth
from actors ac1
where 
	ac1.date_of_birth >
	(
		select 
			min(date_of_birth)
		from actors ac2
		where ac1.gender = ac2.gender
	)
order by ac1.gender, ac1.date_of_birth;




















