-- Instance level security

-- 1. Contorls all databases on an instance

-- 2. Highest levele of security

-- 3. Can be assigned with

-- SUPERUSER - super access, all access
-- CREATEDB - can create DBs,
-- CREATEROLE - can make roles
-- LOGIN - can login into database
-- REPLICATION - can be used for replication

-- 4. Using NO means no access i.e. NOSUPERUSER = No SUPERUSER access

-- Create roel using CREATE ROLE
-- Lets create two roles i.e. hr and programmers

-- CREATE ROLE hr NOSUPERUSER NOCREATEDB NOCREATEROLE NOLOGIN
-- CREATE ROLE programmers NOSUPERUSER NOCREATEDB NOCREATEROLE NOLOGIN

-- Can we login using a role name? (using console psql)
-- CREATE ROLE testR NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN PASSWORD '1q2w3e3e2w1q4r';

-- Add users to roles

-- GRANT hr ro testR;

-- How to create roles. 
