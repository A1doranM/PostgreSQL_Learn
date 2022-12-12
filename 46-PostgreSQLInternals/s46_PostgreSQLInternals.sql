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

-- View privileges information across database, tables, columns

-- Check privileges for current_user

select
    has_database_privilege('hr', 'create'),
    has_schema_privilege('public', 'USAGE'),
    has_table_privilege('movies', 'INSERT'),
    has_any_column_privilege('movies', 'SELECT');

-- Checking privilege of a particular user and for a particular column

select
    has_column_privilege('postgres', 'movies', 'movie_name', 'UPDATE');

-- View current timezone information

select current_setting('timezone');

-- File access function

select pg_stat_file('/etc/aliases');

-- Read file contents

select pg_read_file('/etc/aliases');

-- List content of a directory

select pg_ls_dir('/tmp');

-- Show all running queries

select
    pid,
    age(clock_timestamp(), query_start),
    usename as run_by_user_name,
    query as running_query
from pg_stat_activity
where
    query != '<IDLE>'
    AND query NOT ILIKE '%pg_stat_activity%'
order by query_start desc;

-- How to kill running query

select pg_cancel_backend([PROCESS_ID]);

select pg_cancel_backend(17432);

select pg_terminate_backend([PROCESS_ID]);

-- Check live and dead rows in tables

-- Live rows - rows currently in use
-- Dead rows - deleted rows

select
    relname,
    n_live_tup,
    n_dead_tup
from pg_stat_user_tables

-- The file layout of PostgreSQL tables

-- location of the PostgreSQL data_directory

show data_directory;

-- where is the files for particular DB located

select pg_relation_filepath('employees');








