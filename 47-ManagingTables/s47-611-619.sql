-- Using SELECT INTO to create a new table with joins

SELECT
    *
FROM movies;

SELECT
    *
INTO movies_pg
FROM movies
WHERE age_certificate = 'PG';

-- Using JOINs

SELECT
*
INTO top_10_movies
FROM
(
   SELECT
       mv.movie_id,
       mv.movie_name,
       r.revenues_domestic
       r.revenues_international
   FROM movies mv
   INNER JOIN movies_revenues r ON mb.movie_id = r.movie_id
   ORDER BY 5 DESC NULLS LAST
   LIMIT 10
) as t;


-- Create a table called to_10_directors with to 10 most profitable movies;

SELECT
*
INTO top_10_directors
FROM
(
   SELECT
       mv.movie_id,
       mv.movie_name,
       d.director_id,
       d.first_name,
       d.last_name,
       r.revenues_domestic
       r.revenues_international
   FROM movies mv
   INNER JOIN movies_revenues r ON mb.movie_id = r.movie_id
   INNER JOIN directors d ON mb.director_id = d.director_id
   ORDER BY 5 DESC NULLS LAST
   LIMIT 10
) as t;


-- Duplicate table

-- with all data

-- CREATE TABLE new_tablename as (SELECT * FROM original_tablename);

-- without data

-- CREATE TABLE new_tablename as (SELECT * FROM original_tablename) WITH NO DATA;


-- Import data from a CSV file

-- 1. CREATE TABLE STRUCTURE
-- 2. Import data from csv using \copy command at the terminal
-- \copy table_name(table_col1, table_col2, table_col3) from '../../Sname_of_the_file.csv' DELIMITER ',' CSV HEADER;


-- Export data to CSV file

-- COPY table_name TO 'location\file_name' DELIMITER ',' CSV HEADER;

-- \copy table_name TO 'test.csv' DELIMITER ',' CSV HEADER;


-- Deleting duplicate records

-- Delete via USING statement

DELETE FROM colors a USING colors b -- self join here
W
