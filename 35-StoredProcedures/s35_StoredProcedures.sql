-- Functions vs Stored Procedures
-- ########################################

/*

    1. A user-defined functions cannot execute 'transactions'
        i.e. Inside a function, you cannot start a transaction.

    2. Stored procedure support transactions

    3. Stored procedures does not return value, so tou cannot use 'return';
        However you can use the return statement without the expression to stop the stored
        procedure immediately

    4. Can not be executed or called from within a SELECT

    5. You can call a procedure as often as you like.

    6. They are compiled object

    7. Procedures may or may not use parameters

    8. Execution:
            - Explicit execution, EXECUTE command, along with specific SP name and optimal
                parameters
            - Implicit execution using only SP name, CALL procedure_name();

    9. Declarations section can be empty.

    10. Stored Procedures that do not have parameters are called "static"

    11. Stored Procedures that use parameter values are called "dynamic".

*/

CREATE OR REPLACE PROCEDURE procedure_name (parameters_list)
AS
$$
    DECLARE
        -- variable declaration
    BEGIN

        -- stored procedure body

        COMMIT;
    END;
$$ LANGUAGE PLPGSQL;


-- Stored procedures with transactions

-- Create transaction
-- #####################################

CREATE TABLE t_accounts(
    recid SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    balance dec(15, 2) NOT NULL
);

-- Insert data

INSERT INTO t_accounts(name, balance)
VALUES
('Adam', 123),
('Linda', 100);

-- Create procedure

CREATE OR REPLACE PROCEDURE pr_money_transfer (
    sender int,
    receiver int,
    amount dec
)
AS
$$
    -- HERE WE GET MONEY FROM SENDER AND ADD TO RECEIVER
    BEGIN
        UPDATE t_accounts
        SET balance = balance - amount
        WHERE receid = sender;

        UPDATE t_accounts
        SET balance = balance + amount
        WHERE recid = receiver

        COMMIT;
    END;
$$ LANGUAGE PLPGSQL;

-- Returning a value
-- #########################

-- For this we use INOUT parameter mode

CREATE OR REPLACE PROCEDURE pr_orders_count(INOUT total_count integer default 0)
AS
$$
    -- HERE WE GET MONEY FROM SENDER AND ADD TO RECEIVER
    BEGIN
        SELECT COUNT (*)
        INTO total_count -- SAVE DATA TO RETURNING VALUE
        FROM orders
    END;
$$ LANGUAGE PLPGSQL;
