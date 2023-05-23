-- Creating cursor
-- #######################

-- 1. Unbound cursor

    DECLARE cursor_name refcursor;

-- e.g.

    DECLARE cur_all_movies refcursor;

-- 2. Cursor that bounds to a query expression

    cursor_name [cursor_scrollability] CURSOR [{name datatype, name datatype, ...}]
    FOR
        query-expression

    -- cursor_scrollability  -  SCROLL or NO SCROLL (default) NO SCROLL means the cursor cannot scroll backward.

    -- query-expression  -  you can use any legal SELECT statement as a query expression. The resultsets rows are
    --                      considered as scope of the cursor

-- e.g.

    DECLARE
        cur_all_movies CURSOR
        FOR
            SELECT
                movie_name,
                movie_length
            FROM movies;

-- 3. Create a cursor with query parameters

    DECLARE cur_all_movies_by_year CURSOR (custom_year integer)
    FOR
        SELECT
            movie_name,
            movie_length
        FROM movies
        WHERE EXTRACT('YEAR' FROM release_date) = custom_year

-- Opening cursor
-- ########################

-- Unbound cursor

-- 1. Opening a unbound cursor

    OPEN unbound_cursor_variable [[NO] SCROLL] FOR query;

    SELECT * FROM directors;

    OPEN cur_directors_us
    FOR
        SELECT
            first_name,
            last_name
        FROM directors
        WHERE
            nationality = 'American'

-- 2. With dynamic query

    OPEN unbound_cursor_variable [[NO] SCROLL]
    FOR EXECUTE
        query-expression [using expression [, ...]];

    my_query: = 'SELECT DISTINCT(NATIONALITY) FROM directors ORDER BY $1';

    OPEN cur_directors_nationality
    FOR EXECUTE
        my_query USING sort_field;

-- Bound cursor

-- Opening bound cursor

    OPEN cursor_variable[ (name:=value, name:=value, ...)];

    OPEN curr_all_movies;

    DECLARE cur_all_movies_by_year CURSOR (custom_year integer)
        FOR
            SELECT
                movie_name,
                movie_length
            FROM movies
            WHERE EXTRACT('YEAR' FROM release_date) = custom_year

    OPEN cur_all_movies_by_year(custom_year:=2010);

-- Using a cursor
-- ########################

-- 1. Following operations can be done once a cursor is open;

    FETCH, MOVE, UPDATE, or DELETE statement;

-- 2. FETCH statement

    FETCH [ direction {FROM | IN}] cursor_variable
    INTO target_variable
    FETCH cur_all_movies INTO row_movie;

-- 3. Direction

-- By default, a cursor gets the next row if tou don`t specify the direction explicitly.
/*

    NEXT,
    LAST,
    PRIOR,
    FIRST,
    ABSOLUTE count,
    RELATIVE count,
    FORWARD,
    BACKWARD

*/

    FETCH LAST
    FROM row_movie
    INTO movie_title, movie_release_year;

-- If you enable SCROLL at the declaration of the cursor, they can use only;

    FORWARD
    BACKWARD

-- Moving the cursor

    MOVE [direction {FROM | IN}] cursor_variable;

    MOVE cur_all_movies;
    MOVE LAST FROM cur_all_movies;
    MOVE relative -1 FROM cur_all_movies;
    MOVE FORWARD 4 FROM cur_all_movies;

-- Updating data using cursor
-- ############################

/*

    Once a cursor is positioned, we can delete or update row identifying be the cursor
    using the following statement

       DELETE WHERE CURRENT OF or
       UPDATE WHERE CURRENT OF

*/

-- e.g.

UPDATE movies
SET YEAR(release_date) = custom_year
WHERE
    CURRENT OF cur_all_movies;

-- Closing cursor
-- #######################

CLOSE cursor_variable

-- Close statement releases resources or frees up cursor variable to allow it to be
-- opened again using OPEN statement.

CLOSE cur_all_movies;






