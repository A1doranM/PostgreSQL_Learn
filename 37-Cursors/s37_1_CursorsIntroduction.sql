-- Cursors
-- #########################

/*

   1. A Cursor enables SQL to retrieve a single row at a time.

   2. A cursor is like a pointer that point or locate a specific table row.

   3. A cursor is a database query store on the DBMS server - not a SELECT statement, but
        the RESULT SET retrieve by that statement.

   4. Once the cursor is active or stored, you can:

        SELECT
        UPDATE or
        DELETE

        a row at which the cursor is pointing

   5. Cursors can be used in functions or in PL/pgSLQ language.

*/

-- Creating a cursor
-- #####################

/*

    1. DECLARE

        A cursor must be DECLARE before it is to be used. This does not retrieve any data,
        it just defines the SELECT statement to be used and any other cursor options.

    2. OPEN

        Once it is declare, it must be OPENed for use.
        This process retrieves the data-using the define SELECT statement.

    3. FETCH

        Individual rows can be fetched as per needed.

    4. CLOSE

        When you do not need the cursor, it must be closed. This operation then deallocate
        memory etc back to the DBMS.

    5. So the steps are;

        DECLARE -> OPEN -> FETCH -> CLOSE;

*/

