/*
    Four stages
    -----------------------------------

    parser - handles the textual form of the statement and verifies whether
             it is correct or not.

    rewriter - applying ant syntactic rules to rewrite the original SQL statement.

    optimizer - finding the very fastest path to the data that the statement needs.

    executor  - responsible for effectively going to the storage and retrieving the
                data gets physical access to the data.

*/
