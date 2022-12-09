-- List all databases users

select * from pg_users;

-- List all databases and their size, with/without indexes

select
    datname as database_name,
    pg_size_pretty(pg_database_size(datname)) as database_size
from pg_database_size
order by pg_database_size(datname) desc;

-- List all database and schemas

select catalog_name as "Database Name"
from information_schema.information_schema_catalog_name

-- List all schemas names starting with "pg" largely for internal schemas

select *
from information_schema.schemata
where schema_name like 'pg%';

-- Aggregate all schemas using STRING_AGG

select string_agg(schema_name, '')
from information_schema.schemata
where schema_name like 'pg%';

-- List all tables

select *
from information_schema.tables
where table_schema = 'public';

-- List all tables and views

select *
from information_schema.views
where table_schema = 'public';

-- List all columns

select column_name, data_type, dtd_identifier
from information_schema.columns
where table_name = 'movies';

-- View system metadata

select
    current_catalog,
    current_database(),
    current_schema,
    current_user,
    session_user;

-- See current version of PostgreSQL server

select version();












