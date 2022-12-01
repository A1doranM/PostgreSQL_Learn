select upper('world peace');

select lower('WORLD PEACE');

select initcap('world peace');

select char_length('world');

select trim('  ADAM     ');

select char_length(trim('            ADAM   '));

-- REGULAR EXPRESSIONS

--     | denotes alternation (either of two alternatives).

--     * denotes repetition of the previous item zero or more times.

--     + denotes repetition of the previous item one or more times.

--     ? denotes repetition of the previous item zero or one time.

--     {m} denotes repetition of the previous item exactly m times.

--     {m,} denotes repetition of the previous item m or more times.

--     {m,n} denotes repetition of the previous item at least m and not more than n times.

--     Parentheses () can be used to group items into a single logical item.

--     A bracket expression [...] specifies a character class, just as in POSIX regular expressions.

select 'same' similar to 'same';

select 'same' similar to '%s';

select 'same' similar to 's%';

select 'same' similar to 'sam%';

select 'same' similar to '%(s|a)%';
