-- Creating a new custom index strategy

-- Create sample table
CREATE TABLE ssn (
    ssn TEXT
)

-- INSERT data

INSERT INTO ssn (ssn) VALUES
('111-11-0100'),
('222-11-0100'),
('333-33-0300'),
('444-44-0400');

EXPLAIN SELECT * FROM ssn
ORDER BY ssn;

-- First lets write a function that will
-- 1. changes the order of digits
-- 2. remove any non-numeric characters

CREATE OR REPLACE FUNCTION fn_fix_ssn(text) RETURNS text AS
&&
    BEGIN
--
--        SELECT substring('111-11-0100', 8)
--        SELECT replace(('111-11-0100', 1, 7), '-', '');

        RETURN substring($1, 8) || replace(substring($1, 1, 7), '-', '');
    END;
&& LANGUAGE PLPGSQL IMMUTABLE;

SELECT fn_fix_ssn('111-1-0100');

SELECT ssn, fn_fix_ssn(ssn) FROM ssn;

-- Compare $1, $2
-- $1 < $2 return -1
-- $1 > $2 return 1
-- 0

CREATE OR REPLACE FUNCTION fn_ssn_compare(text, text) RETURNS integer AS
&&
    BEGIN

        IF
            fn_fix_ssn($1) < fn_fix_ssn($2) THEN RETURN -1;
            ELSEIF fn_fix_ssn($1) > fn_fix_ssn($2) THEN RETURN 1;
        ELSE
            RETURN 0;
        END IF;

    END;
&& LANGUAGE PLPGSQL IMMUTABLE;

SELECT fn_ssn_compare('111-11-0100', '222-22-0200');

-- Lets create custom operator class

CREATE OPERATOR CLASS op_class_ssn_ops1
FOR TYPE text USING btree
AS
    OPERATOR 1 <,
    OPERATOR 2 <=,
    OPERATOR 3 =,
    OPERATOR 4 >=,
    OPERATOR 5 >,
    FUNCTION 1 fn_ssn_compare(text, text);

-- Lets create index using custom operator class

CREATE INDEX idx_ssn ON ssn(ssn op_class_ssn_ops1);

-- Lets set the optimizer so that it uses our index

SHOW enable_seqscan;
SET enable_seqscan = 'off';

-- Quick query which uses our index;

EXPLAIN SELECT * FROM ssn
WHERE ssn = '010011111';











