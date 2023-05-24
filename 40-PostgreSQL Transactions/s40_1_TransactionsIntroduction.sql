-- What is a transaction
-- #########################

/*

    Key points
    ------------------

    1. A transaction bundles multiple steps or operations into a single, ALL-OR-NOTHING
        operation.

    2. SQL protects our database by restricting operations that can change it so they can
        occur only WITHING TRANSACTION.

    3. There are four main transaction commands, that protect from hard, both accidental
        and intentional.

        COMMIT
        ROLLBACK
        GRANT   -- grant privileges to user
        REVOKE  -- revoke privileges from user

    4. During a transaction, SQL record every operation performed on the data in a log file

    5. If anything interrupts the transaction BEFORE the COMMIT statement ends the transaction
        you can restore the system to its original state by issuing a ROLLBACK statement.

    6. The ROLLBACK process the transaction log in REVERSE, undoing all the actions that
        took place in the transaction.

*/
