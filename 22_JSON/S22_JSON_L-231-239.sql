-- JSON in PostgreSQL

1. The application can store JSON strings in the PostgreSQL database in the standard
JSON format.

2. PostgreSQL supports JSON and JSONB

JSON
-> classic JSON doc
-> Stores the JSON including white spaces
-> Does not support FULL-TEXT-SEARCH indexing
-> Does not support wide range of JSON functions and operators
-> JSON is faster as it does not process input data

JSONB
-> Stores the JSON in Binary format(JSONB)
-> Trim off white spaces
-> Supports FULL-TEXT-SEARCH indexing
-> Supports all JSON functions and operators
-> Faster on operators and functions

1. How will we represent a JSON in PostgreSQL

'{"title": "Test"}'

2. Do we have to cast data type to make it JSON?

SELECT '{"title": "Test"}'::JSON;

-- Create table with JSONB data type

1. Create table books

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    book_info JSONB
);

2. Insert some data

INSERT INTO books (book_id, book_info)
VALUES
('{
    "title":"Book 1",
    "author":"Author 1"
}');

SELECT * FROM books;

3. Insert many data

INSERT INTO books (book_id, book_info)
VALUES
('{
    "title":"Book 2",
    "author":"Author 2"
}'),
('{
    "title":"Book 3",
    "author":"Author 3"
}'),
('{
    "title":"Book 4",
    "author":"Author 4"
}');

SELECT * FROM books;

-- Using selectors

-- The operator -> returns the JSON Object field as a field in quotes

SELECT book_ino FROM books;

SELECT book_info->'title' FROM books;

-- the operator ->> returns the JSON object field as TEXT

SELECT
    book_info->>'title' as title,
    book_info->>'author' as author
FROM books;

-- Select and filter records.

SELECT
    book_info->>'title' as title,
    book_info->>'author' as author
FROM books
WHERE book_info->>'author' = 'Author 1';

-- UPDATE JSON data

-- We will use || concatenation operator which will:
--  add field of replace existing field

-- lets update Author 1

UPDATE books
SET book_info = book_info || '{"author": "Author 1 updated"}'
WHERE book_info->>'author' = 'Author 1';

-- lets add multiple key/values

UPDATE books
SET book_info = book_info || '
{
    "category": "Science",
    "pages": 250
}'
WHERE book_info->>'author' = 'Author 1';

-- Delete Best Seller boolean key/value
-- To delete we will use - operator

UPDATE books
SET book_info = book_info -'Best Seller'
WHERE book_info->>"author"="Author 2";

-- Create JSON from table

-- 1. Lets output table in JSON format

SELECT * FROM directors;

SELECT row_to_json(directors) FROM directors;

-- 2. Taking only particular fields

SELECT row_to_json(t) FROM
(
    SELECT
        director_id,
        first_name,
        last_name,
        nationality
    FROM directors
) as t;

-- Aggregate data

-- 1. Select director_id, first_name, last_name and all movies created by that director

SELECT
    director_id,
    first_name,
    last_name,
    movie_name,
    (
        SELECT json_agg(x) as all_movies FROM
        (
            SELECT movie_name
            from movies
            WHERE director_id = directors.director_id
        ) as x
    )
FROM directors;

-- Build a JSON array

-- 1. Lets build a sample array with numbers;

SELECT json_build_array(1, 2, 3, 4, 5);

-- 2. Can we do strings and numbers together;

json_build_object(values in key/value);

SELECT json_build_object (1, 2, 3, 4, 5, 6, 7, 'Hi');

-- 3. Can we supply key/value style data?

SELECT json_build_object('name', 'Test Name', 'email', 'test@email.com');

-- json_object({keys}, {values})

SELECT json_object('{name, email}', '{"Adnan", "test@email.com"}');
