-- Creating an aggregate function

CREATE AGGREGATE aggregate_name (p1, p2, ...)
(
    INITCOND = n,
    STYPE = type_name,
    SFUNC = function_name, -- The name of the state transition function to be called for each input row
    FINALFUNC = final_function_name -- final function to compute the aggregate`s results after all rows have been traversed
)


