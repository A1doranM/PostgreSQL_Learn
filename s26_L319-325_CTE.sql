with num as (
	select * from generate_series(1, 10) as id
)
select * from num;

with cte_director_1 as (
	select 
		*
	from movies mv
	inner join directors d on d.director_id = mv.director_id
	where
		d.director_id = 1
) 
select * from cte_director_1;


with cte_long_movies as (
	select 
		movie_name,
		movie_length,
		(
			case
				when movie_length < 100 then 'short'
				when movie_length < 120 then 'medium'
				else 'long'
			end
		) as "m_length"
	from movies
) 
select 
	* 
from cte_long_movies
where 
	m_length = 'long';
	

with cte_movie_count as (
	select 
		d.director_id,
		sum(r.revenues_domestic + r.revenues_international) as total_revenues
	from directors d
	inner join movies mv on mv.director_id = d.director_id
	inner join movies_revenues r on r.movie_id = mv.movie_id
	group by d.director_id
)
select 
	d.director_id,
	d.first_name,
	d.last_name
from cte_movie_count cte
inner join directors d on d.director_id = cte.director_id;


WITH cte_movie_count AS
    (
        SELECT
            d.director_id,
            SUM(COALESCE(r.revenues_domestic,0) + COALESCE(r.revenues_international,0)) AS total_revenues
        FROM directors d
        INNER JOIN movies mv ON mv.director_id = d.director_id
        INNER JOIN movies_revenues r ON r.movie_id = mv.movie_id
        GROUP BY d.director_id
    )
    SELECT
       d.director_id,
       d.first_name,
       d.last_name,
       cte.total_revenues
    FROM cte_movie_count cte
    INNER JOIN directors d ON d.director_id = cte.director_id;


create table articles (
	article_id serial primary key,
	title varchar(100)
);

create table articles_delete as select * from articles limit 0;

insert into articles(title) values
('art1'),
('art2'),
('art3'),
('art4'),
('art5');


select * from articles;


select * from articles_delete;


with cte_delete_articles as 
(
	delete from articles
	where article_id = 1
	returning *
)
insert into articles_delete
select * from cte_delete_articles;


create table articles_insert as select * from articles limit 0;


with cte_move_articles as 
(
	delete from articles
	returning *
)
insert into articles_insert
select * from cte_move_articles;


select * from articles_insert;


with recursive series (list_num) as
(
	select 10
	
	union all
	
	select list_num + 5 from series
	where list_num + 5 <= 50
)
select * from series; 


create table items (
	pk serial primary key,
	name text not null,
	parent int
);

insert into items (pk, name, parent) values
(1, 'vegetables', 0),
(2, 'fruits', 0),
(3, 'apple', 2),
(4, 'banana', 2);

select * from items;


with recursive cte_tree as 
(
	select 
		name,
		pk,
		1 as tree_level
	from items
	where
		parent = 0
	
	union
	
	select 
		tt.name || '->' || ct.name,
		ct.pk,
		tt.tree_level + 1
	from items ct
	join cte_tree tt on tt.pk = ct.parent
)
select 
	tree_level,
	name
from cte_tree;


















































































