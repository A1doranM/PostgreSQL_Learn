-- Disallow Delete on table
-- #############################

-- Test table

CREATE TABLE test_delete(
    id INT
);

-- Lets insert some data

INSERT INTO test_delete (id) values (1), (2);

-- Create function

CREATE OR REPLACE FUNCTION fn_generic_cancel_op()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
BEGIN

    IF TG_WHEN = 'AFTER' THEN
        -- raise exception
        RAISE EXCEPTION 'You are not allowed to % rows in %.%',
        TG_OP, TG_TABLE_SCHEMA, TG_TABLE_NAME;

    END IF;

    RAISE NOTICE '% on rows on %.% wont happen',
    TG_OP, TG_TABLE_SCHEMA, TG_TABLE_NAME

    -- prevent any action with table;
    RETURN NULL;

END;
$$

-- Bind trigger

CREATE TRIGGER trg_disallow_delete
BEFORE DELETE
ON test_delete
FOR EACH ROW
EXECUTE PROCEDURE fn_generic_cancel_op();

