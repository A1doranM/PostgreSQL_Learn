-- JSON in PostgreSQL

-- Getting info from JSON

1. Get json length

jsonb_array_length

2. List all keys within JSON row

json_object_keys

3. If we want to see key/value style

SELECT
    j.key,
    j.value
FROM table_name, jsonb_each(table_name) j;

4. Turning JSON object to table format

jsonb_to_record

SELECT
    j.*
FROM table_name, jsonb_to_record(table_name) j (
    director_id ING,
    first_name VARCHAR(255)
    ....
    other table_structure
);

5. Existence operator "?" returns nothing or data.

SELECT
    *
FROM directors_docs
WHERE body->'first_name' ? 'John';
