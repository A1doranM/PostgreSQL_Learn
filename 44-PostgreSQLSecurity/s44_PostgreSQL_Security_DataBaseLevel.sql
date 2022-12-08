-- Database Level Security

-- Control a database level
-- Can be assigned with

-- CREATE - Make a new schema
-- CONNECT - Connect to a database
-- TEMP/TEMPORARY - Create a temporary table

-- Adding permission for connection via CONNECT
-- GRANT CONNECT ON DATABASE databasename TO role

grant connect on database [DBNAME] to [USERNAME];