-- Schema level security

-- CREATE create tables, funtions etc.
-- USAGE view schema and its objects.

-- If we did not give permission to user through
-- We must set level zero permissioning i.e. We should revoke all access on schema to public first

revoke all on schema [schemaname] from public;

-- lets create two roles;

create role sales NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN password 'welcome';
create role tech NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN password 'welcome';

-- give tech create and usage permission on schema -> public

grant permissions on schema [schema_name] to [role_name];

grant create on schema public to tech;

-- give sales usage permission on schema -> public
grant usage on schema public to sales;

