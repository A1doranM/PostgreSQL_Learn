-- An ACID database
-- #########################

/*

    1. ACID is a acronym for

        A   Atomicity
        C   Consistency
        I   Isolation
        D   Durability

    All of the above four characteristics are necessary to protect a database from corruption

    Atomicity
    --------------

    - The ENTIRE TRANSACTION should be treated as an INDIVIDUAL UNIT
    - Either it is executed in this entirety(COMMIT), or the database is restored(ROLLBACK)
        to its original state

    Consistency
    --------------

    Consistency means more of a BALANCED APPROACH before and after a transaction is
    executed. So for example when whe transfer money from one account to another total
    amount of the money from both account to be same at the the end of the transaction.

    Isolation
    ---------------

    Database transactions should be totally isolated from other transaction that execute at
    the SAME TIME.

    - If the transaction are SERIALIZED, then only TOTAL ISOLATION is achieved.

    Durability
    ---------------

    - After a transaction has committed or rolled back we should be able to count on the
        database BEING IN THE PROPER STATE i.e. UP-TO-DATE DATA.

*/
