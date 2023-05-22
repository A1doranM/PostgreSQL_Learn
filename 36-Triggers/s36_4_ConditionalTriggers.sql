-- Creating conditional triggers
-- ##################################

/*

    1. We can create a conditional trigger by using generic WHEN clause

    2. With a WHEN clause, you can write some conditions except a subquery (because subquery
        tested before the trigger function is called)

    3. The WHEN expression should result into Boolean value. If the values is FALSE or NULL (
        which is automatically converted to FALSE), the trigger function is not called.

*/

-- Example

-- We will use:

    -- 1. WHEN condition
    -- 2. We will use FOR EACH STATEMENT
    -- 3. We will pass a 'parameter' to EXECUTE PROCEDURE function_name(parameter)

-- Our table

CREATE TABLE mytask (
    task_id SERIAL PRIMARY KEY,
    task TEXT
);

-- Create a generic function which show a message

CREATE OR REPLACE FUNCTION fn_cancel_with_message()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
    BEGIN

        RAISE EXCEPTION '%', TG_ARGV(0);

        RETURN NULL;

    END;
$$

-- Trigger statement with condition

CREATE TRIGGER trg_no_update_friday_afternoon
BEFORE INSERT OR UPDATE OR DELETE OR TRUNCATE
ON mytask
FOR EACH STATEMENT
WHEN -- our condition
(
    EXTRACT('DOW' FROM CURRENT_TIMESTAMP) = 5 AND CURRENT_TIME > '12:00'
)
EXECUTE PROCEDURE fn_cancel_with_message('No update are allowed at afternoon Friday');

-- Check if working

INSERT INTO mytask (task) VALUES ('test');
