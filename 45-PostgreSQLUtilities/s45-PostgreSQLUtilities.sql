-- psql Commands

-- How to connect to a database
-- psql -d database -U user

psql -d hr -U admin

-- To connect to a database thar resides on another host you will add -h and
-- provide ip address or host to remote server

psql -h 192.168.0.0.1 -U admin

-- List all available databases and schemas
-- Databases
-- 1. Connect to database
-- 2. Tap \l

