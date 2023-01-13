-- Size of the table index

SELECT
	pg_size_pretty(pg_indexes_size('orders'));
