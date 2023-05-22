-- Event Trigger
-- #################

/*

    1. Event triggers are data-specific and not bind or attached to a table.

    2. Unlike regular triggers they capture system level DLL events.

    3. Event triggers can be BEFORE or AFTER triggers

    4. Trigger function can be written in any language except SQL

    5. Event triggers are disabled in the single user mode and can only be created by a
        superuser.

*/

-- Syntax

CREATE EVENT TRIGGER trg_name

/*

    Requirements
    ---------------

    1. Before creating an event trigger, we must have a function that the trigger will
        execute

    2. The function must return a special type called EVENT_TRIGGER

    3. This function need not return a value the return type serves merely as a signal
        that the function is to be invoked as an eent trigger.

*/


-- Variables and Event types

/*

    ddl_command_start  -  This event occurs just BEFORE a CREATE, ALTER, or DROP DDL ddl_command_start
                            is executed

    ddl_command_end  -  This event occurs just AFTER a CREATE, ALTER, or DROP DDL ddl_command_start
                         is executed

    table_rewrite  -  This event occurs just before a table is rewritten by some actions
                        of the commands ALTER TABLE and ALTER TYPE.

    sql_drop  -  This event occurs just before the ddl_command_end event for the commands
                    that drop database objects.

    -- Variables

    TG_TAG  -  Tag or the command for which the trigger is executed, e.g. CREATE TABLE,
                DROP TABLE, ALTER TABLE and so on.

    TG_EVENT  -  Event name which can be ddl_command_start, ddl_command_end, and sql_drop

*/

-- Example

-- Creating audit trial event trigger
-- ######################################

-- Test table

CREATE TABLE audit_ddl(
    audit_ddl_id SERIAL PRIMARY KEY,
    username TEXT,
    ddl_event TEXT,
    ddl_command TEXT,
    ddl_add_time TIMESTAMPTZ
);

-- Event trigger function

CREATE OR REPLACE FUNCTION fn_event_audit_ddl()
RETURNS EVENT_TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER -- Allows the function to be executed with rules of function creator, regardless
AS               -- of current user in system.
$$
    BEGIN
        -- insert
        INSERT INTO audit_ddl
        (
            username,
            ddl_event,
            ddl_command,
            dll_ddl_add_time
        )
        VALUES
        (
            session_user,
            TG_EVENT,
            TG_TAG,
            NOW()
        );

        --raise notice
        RAISE NOTICE 'DDL activity is added!'

    END;
$$

-- Create trigger

-- without condition

CREATE EVENT TRIGGER trg_event_audit_ddl
ON ddl_command_start
EXECUTE PROCEDURE fn_event_audit_ddl();

-- with condition

CREATE EVENT TRIGGER trg_event_audit_ddl
ON ddl_command_start
WHEN
    TAG IN ('CREATE TABLE')
EXECUTE PROCEDURE fn_event_audit_ddl();
