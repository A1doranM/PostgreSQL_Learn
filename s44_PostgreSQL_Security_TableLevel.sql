-- Table level security
/*

	SELECT 
	INSERT
	UPDATE
	DELETE 
	TRUNCATE
	TRIGGER - create triggers on tables 

*/

-- To applying on an individual table 

GRANT permission_name ON ALL TABLES in SCHEMA [schema_name] TO [role_name];

-- Give sales SELECT ALL on tables in schema -> public;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO sales;