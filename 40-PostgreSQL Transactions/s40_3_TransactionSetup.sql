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

-- Fix aborted transaction
-- ############################
