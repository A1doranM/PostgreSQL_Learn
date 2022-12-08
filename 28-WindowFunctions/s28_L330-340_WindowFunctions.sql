select count(*) from trades;

select distinct(region) from trades;

select distinct(country) from trades;

select min(year), max(year) from trades;

select * from trades where country = 'USA'
order by year desc;


select 
	min(imports),
	max(imports),
	avg(imports)
from trades;


select distinct(country) from trades;


select
	region,
	round(min(imports), 0) as min,
	round(max(imports), 0) as max,
	round(avg(imports), 0) as avg
from trades
group by region
order by 3 desc;


select
	region,
	round(min(exports), 0) as min,
	round(max(exports), 0) as max,
	round(avg(exports), 0) as avg
from trades
group by region
order by 3 desc;


select distinct(country) 
from trades
where region = 'SOUTH AMERICA';


select 
	region,
	avg(imports)
from trades
group by rollup(region);


select 
	region,
	country,
	round(avg(imports), 2)
from trades
where 
	country in ('USA', 'Argentina', 'Ukraine', 'Brazil')
group by rollup(region, country);


select 
	region,
	country,
	round(avg(imports/1000000000),2)
from trades
where 
	country in ('USA', 'France', 'Germany', 'Brazil')
group by
	CUBE (region, country);
	
	
select 
	region,
	country,
	round(avg(imports/1000000000),2)
from trades
where 
	country in ('USA', 'France', 'Germany', 'Brazil')
group by
	grouping sets (
		(),
		country,
		region
	);

	
explain analyze select 
	region,
	country,
	round(avg(imports/1000000000),2)
from trades
where 
	country in ('USA', 'France', 'Germany', 'Brazil')
group by
	grouping sets (
		(),
		country,
		region
	);


show enable_hashagg;
set enable_hashagg to on;


select 
	region,
	avg(exports) as "avg_all",
	avg(exports) filter (where year < 1995) as "avg_old",
	avg(exports) filter (where year >= 1995) as "avg_latest"
from trades
group by 
	rollup(region);


select 
	avg(exports) 
from trades;


select 
	country,
	year,
	imports,
	exports,
	avg(exports) over() as avg_exports
from trades;


select 
	country,
	year,
	imports,
	exports,
	avg(exports) over(partition by country) as avg_exports
from trades
order by country, year desc;


select 
	country,
	year,
	imports,
	exports,
	avg(exports) over(partition by year < 2000) as avg_exports
from trades
order by country, year desc;
































































