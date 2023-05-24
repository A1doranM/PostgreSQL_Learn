-- Transaction Analysis Setup
-- ################################

-- Sample table

CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    balance INTEGER NOT NULL
);

-- Insert some data

INSERT INTO accounts (name, balance) VALUES
('Adam', 100),
('Bob', 100),
('Linda', 100);

-- Open a transaction

BEGIN;
    SELECT * FROM accounts;
COMMIT;

-- Another transaction

BEGIN;

    UPDATE accounts
    SET balance = balance - 50
    WHERE name = 'Adam';

    ROLLBACK; -- rollback transaction

COMMIT;

-- Partial transaction rollback
-- ############################

/*

    To support the ROLLBACK of PARTIAL TRANSACTION, we must put Savepoint at strategic
    location of the transaction block. Thus, if a rollback is required, you can read back
    on the said point.

    -- Syntax

    SAVEPOINT savepoint_name;

    -- And rollback to it

    ROLLBACK TO savepoint_name;

*/

-- Example

BEGIN;

    UPDATE accounts
    SET balance = balance - 50
    WHERE name = 'Adam';

    SAVEPOINT account_updated; -- savepoint

    UPDATE accounts
    SET balance = balance + 150
    WHERE name = 'Adam';

    ROLLBACK TO account_updated; -- rollback transaction to savepoint

COMMIT;
