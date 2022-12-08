update trades
set 	
	imports = ROUND(imports/1000000, 2),
	exports = ROUND(exports/1000000, 2);
	
	
select 
	country,
	year,
	exports,
	max(exports) over (partition by country order by year)
from trades
where 
	year > 2001
	and country in ('France', 'USA');
	
	
select 
	country,
	year,
	exports,
	min(exports) over (
		partition by 
			country 
		order by year 
		rows between 
			1 preceding 
			and 
			1 following excluding current row
	) as avg_moving
from trades
where 
	year between 2001 and 2010
	and country in ('USA', 'Ukraine');
	
	
select 
	*,
	array_agg(x) over (order by x)
from generate_series(1,3) as x;
	
	
select 
	*,
	array_agg(x) over (order by x)
from generate_series(1,3) as x;
	
	
select 
	*,
	array_agg(x) over (order by x rows between current row and unbounded following)
from generate_series(1,3) as x;	


select 
	*,
	array_agg(x) over (order by x rows between unbounded preceding and 0 following)
from generate_series(1,3) as x;	


select 
	*,
	array_agg(x) over (order by x rows between unbounded preceding and 2 following)
from generate_series(1,5) as x;


select 
	*,
	array_agg(x) over () as "frame",
	sum(x) over () as "sum" 
from generate_series(1,5) as x;
	
	
select 
	*,
	array_agg(x) over() as "frame",
	sum(x) over() as "sum",
	x::float/sum(x) over() as "part_perc"
from generate_series(1,5) as x;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	