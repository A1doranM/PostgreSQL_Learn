/*

    Views are useful because they allow you to:

    -- Creating a View

    CREATE OR REPLACE VIEW view_name AS query

    'query' can be:

    -- SELECT
        -- SELECT with subquery
        -- SELECT with joins
        -- anything with SELECT

    e.g.
    Create a view to include all movies with directors first and last names.

    CREATE OR REPLACE VIEW v_movie_quick AS
    SELECT
        movie_name,
        movie_length,
        release_date
    FROM movies mv;

   -- or another example

    CREATE OR REPLACE VIEW v_movies_directors_all AS
    SELECT
        mv.movie_id,
        mv.movie_name,
        mv.movie_length,
        mv.age_certification,
        mv.release_date,
        d.first_name,
        d.last_name
    FROM movies mv
    INNER JOIN directors d ON d.director_id = mv.director_id;

    -- RENAME VIEW

    ALTER VIEW view_name RENAME TO new_view_name;

    -- DELETE VIEW

    DROP VIEW view_name;

    -- Using condition / filters with views

    1. Create a view to list all movies released after 1997;

        CREATE OR REPLACE VIEW v_movies_after_1997 AS
        SELECT
            *
        FROM movies
        WHERE release_date >= '1997-12-31'
        ORDER BY release_date DESC;

    2. Select all movies with english language only from the view;

        SELECT
            *
        FROM v_movies_after_1997
        WHERE movie_lang = 'English'
        ORDER BY movie_lang;

   -- Vies with SELECT and UNION with multiple tables;

   1. Lets have a vies for all peoples in a movie like actors and directors with first, last names

        CREATE VIEW v_all_actors_directors AS
        SELECT
            first_name,
            last_name,
            'actor' as people_type
        FROM actors
        UNION ALL
        SELECT
            first_name,
            last_name,
            'directors' as people_type
        FROM directors;

    2. Get data

        SELECT
            *
        FROM v_all_actors_directors
        WHERE first_name LIKE 'J%'
        ORDER BY people_type, first_name

   -- Re-arrange column to an existing view

   1. Delete the existing view and create a new view with re-arranged columns.

   -- Delete a column from an existing view

   1. Delete the existing view and create a new view with renamed columns.



*/
