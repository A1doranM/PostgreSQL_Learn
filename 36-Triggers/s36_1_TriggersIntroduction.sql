-- Triggers
-- ######################

/*

     1. Trigger is defined as any event that sets a course of action in a motion

     2. PostgresSQL trigger is a function invoked automatically whenever 'an event' occurs.

     3. An event could be any of the following:

        - INSERT
        - UPDATE
        - DELETE
        - TRUNCATE

     4. A trigger can be associated with a specified

        - TABLE
        - View
        - Foreign table

     5. Trigger is a special user-defined function

     6. The difference between trigger and a function is that trigger is automatically invoked
        when associated event occurs.

     7. We can create trigger

        - BEFORE - before an event, it can skip the operation for the current row or change it.
        - AFTER - do something after
        - INSTEAD - do something instead event/operation

     8. The triggers fired in alphabetical order. So naming are matter.

     9. Trigger vs stored procedures
        - Triggers cannot be manually called.
        - There is no chance for triggers to receive parameters

     10. Triggers allow recursion, so when a trigger on a table performs an action on the
         table causes another instance of the trigger to fire.

     11. No trigger in SELECT statement, because SELECT DOES NOT MODIFY ANY ROW

     12. User functions are allowed in triggers

     13. A SINGLE trigger can support MULTIPLE ACTIONS i.e SINGLE -> MANY
*/

-- Types of triggers
-- ##################

/*

    1. Row level Trigger

        Called for each row that is getting modified by the event

    2. Statement Level Trigger

        The FOR EACH STATEMENT option will call the trigger function only ONCE fro each statement,
        regardless of the number of the rows getting modified.

*/

-- Trigger creation process
-- #########################

/*

    1. First, create a trigger function using CREATE FUNCTION statement

    2. Second, bind the trigger function to a table by using CREATE TRIGGER statement.

*/

-- 1. CREATE Function

CREATE TRIGGER trigger_function()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
AS
$$
BEGIN
    --logic
END;
$$

-- 2. CREATE TRIGGER function

CREATE TRIGGER trigger_name
    {BEFORE | AFTER} {event}
ON table_name
    FOR [EACH] {ROW | STATEMENT}
        EXECUTE PROCEDURE trigger_function;

-- Trigger variables
-- #########################

-- Lets create function to easy debug eny triggers

CREATE OR REPLACE FUNCTION fn_trigger_variables_display()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
    BEGIN

        RAISE NOTICE 'TG_NAME: %', TG_NAME; -- trigger name
        RAISE NOTICE 'TG_RELNAME: %', TG_RELNAME; -- table name
        RAISE NOTICE 'TG_TABLE_SCHEMA: %', TG_TABLE_SCHEMA; -- table schema
        RAISE NOTICE 'TG_TABLE_NAME: %', TG_TABLE_NAME; -- table name
        RAISE NOTICE 'TG_WHEN: %', TG_WHEN; -- when it was called (BEFORE | AFTER)
        RAISE NOTICE 'TG_LEVEL: %', TG_LEVEL; -- level (ROW | STATEMENT)
        RAISE NOTICE 'TG_OP: %', TG_OP; -- operation (DELETE | TRUNCATE | UPDATE | INSERT)
        RAISE NOTICE 'TG_NARGS: %', TG_NARGS; --
        RAISE NOTICE 'TG_ARGV: %', TG_ARGV; -- trigger name

        RETURN NEW;

    END;
$$

