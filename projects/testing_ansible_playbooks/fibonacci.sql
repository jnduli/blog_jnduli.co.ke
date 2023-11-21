WITH RECURSIVE fib(a, b) AS (
    -- non recursive part --
    values (0, 1)
    UNION ALL
    -- recursive part --
    select b, a + b from fib where b < 100

) SELECT a from fib;
