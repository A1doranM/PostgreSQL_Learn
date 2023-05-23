-- PL/pgSQL cursors
-- ########################

-- 1. Lets use the cursor to list all movies names

DO
$$
    DECLARE
        output_text text DEFAULT '';
        rec_movie record;

        cur_all_movies CURSOR
        FOR
            SELECT * FROM movies;


    BEGIN

        OPEN cur_all_movies;

        LOOP

            FETCH cur_all_movies INTO rec_movie;
            EXIT WHEN NOT FOUND;

            output_text := output_text || ',' || rec_movie.movie_name;

        END LOOP;

        RAISE NOTICE 'ALL MOVIES NAMES %', output_text;

    END;
$$
