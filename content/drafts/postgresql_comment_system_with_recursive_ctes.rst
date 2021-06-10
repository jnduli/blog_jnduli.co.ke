######################################
Comment System Using Recursive Queries
######################################
:date: 2021-04-09
:category: Engineering
:slug: comment-system-using-recursive-queries
:author: John Nduli
:status: drafts

I was reading SQL antipatterns and got into the chapter about recursive
queries and how there are different ways to approach this. I wanted to
experiment with this and found that postgresql supports recursive
queries. I decided to make a simple commenting database and see how it
would work.

Fibonnacci with CTEs
--------------------
Adopted from https://wiki.postgresql.org/wiki/Fibonacci_Numbers

.. code-block:: sql

    WITH RECURSIVE fib(a, b) AS (
        -- non recursive part --
        values (0, 1)
        UNION ALL
        -- recursive part --
        select b, a + b from fib
    ) SELECT a from fib limit 20

Here's how this would work:

1. There are three tables, intermediate, working and result table. The
   non-recursive part is first calculated, setting the working and
   result table to values (0, 1)
2. The recursive part of the query `select b, a + b from fib` is run on
   the first try. Fib here is the working table, with contains (0, 1).
   This sets the intermediate table to (1, 1). This is appended to the
   result table, and replaces the working table.
3. In the third run, the working table is (1, 1), with ends up with (1,
   2) as the result and so on.
4. The recursion should stop when the intermediate table is empty but
   since fibonacci is infinite this does not happen. Adding a where
   clause to the recursive part would cause this to occur. For example:
   .. code-block:: sql

       WITH RECURSIVE fib(a, b) AS (
           -- non recursive part --
           values (0, 1)
           UNION ALL
           -- recursive part --
           select b, a + b from fib where b < 100

       ) SELECT a from fib;
   
Detailed explanation of how this works can be found here:
`CTE Read me <https://wiki.postgresql.org/wiki/CTEReadme>`_

Comment System
--------------

Here's the table structure I used:

.. code-block:: sql

    DROP TABLE IF EXISTS comments;
    CREATE TABLE comments (comment_id SERIAL PRIMARY KEY, comment TEXT, date_created DATE, parent_id INT);

    INSERT INTO comments (comment_id, comment, date_created, parent_id) VALUES 
    (1, 'parent 1', '2021-01-01', NULL),
    (2, 'parent 2', '2021-01-01', NULL),
    (3, 'child of 1', '2021-01-02', 1),
    (4, 'another child of 1', '2021-01-03', 1),
    (5, 'child of 2', '2021-01-03', 2),
    (6, 'child of 3', '2021-01-03', 3),
    (7, 'child of 6', '2021-01-04', 6),
    (8, 'child of 7', '2021-01-05', 7),
    (9, 'child of 1', '2021-01-06', 1),
    (10, 'child of 5', '2021-01-05', 5);


A simple recursive query getting all children for comment_id 1 is:

.. code-block:: sql

    WITH RECURSIVE child_comments AS (
        SELECT * FROM comments WHERE comment_id = 1
        UNION
        SELECT c.* FROM comments c INNER JOIN child_comments cc ON c.parent_id = cc.comment_id
    ) SELECT * FROM child_comments ;


Cycle Prevention
----------------

To introduce a cycle in this query we just have to do:

.. code-block:: sql

    UPDATE comments SET parent_id=8 WHERE comment_id=1;

To prevent this while running our query, we have to keep a state of all
the parents we've visited and filter these out in the recursive bit. In
this case, we maintain an array of visited parents and ignore all
children comments that have that id.

.. code-block:: sql

    WITH RECURSIVE child_comments AS (
        SELECT *, array[comment_id] as visited_parents FROM comments WHERE comment_id = 1
        UNION ALL
        SELECT c.*, cc.visited_parents || c.comment_id as visited_parents FROM comments c INNER JOIN child_comments cc ON c.parent_id = cc.comment_id WHERE NOT c.comment_id = ANY (cc.visited_parents)
    ) SELECT * FROM child_comments LIMIT 10;


But how do we prevent cycle creation in the query itself? I can think of
only one method at the moment. Having a trigger that gets all parents of
a child comment, and doesn't update if this happens within the tree.

.. code-block:: sql


    CREATE OR REPLACE FUNCTION cycle_prevention() RETURNS trigger AS $cycle_prevention$
        DECLARE
            parents_not_allowed int[];
        BEGIN
            -- Check that parent id doesn't cause a cycle
            IF NEW.parent_id IS NOT NULL THEN
                raise notice 'parent id: %, comment_id %', NEW.parent_id, NEW.comment_id;

                WITH RECURSIVE parents AS (
                    SELECT parent_id from comments where comment_id = NEW.parent_id
                    UNION ALL
                    select c.parent_id from comments c INNER JOIN parents p on p.parent_id=c.comment_id
                )
                SELECT ARRAY(SELECT parent_id::int FROM parents LIMIT 10) INTO parents_not_allowed;
                raise notice 'Value: %', parents_not_allowed;

                IF NEW.comment_id = ANY(parents_not_allowed) THEN
                    RAISE EXCEPTION 'cycle found in query';
                END IF;
            END IF;
            RETURN NEW;
        END;
    $cycle_prevention$ LANGUAGE plpgsql;

    CREATE TRIGGER cycle_prevention BEFORE INSERT OR UPDATE ON comments
        FOR EACH ROW EXECUTE PROCEDURE cycle_prevention();


Now the update fails with `ERROR:  cycle found in query`.



TODO:


Real life usage of CTEs can be to get all children levels of partitioned
table in postgresql.






- research inserting recursively using CTEs e.g. look for problem with
  interview


Detailed explanation of how this works can be found here: https://wiki.postgresql.org/wiki/CTEReadme

There are three tables intermediate, working and result, which are
initially empty. The non recursive part of the query `SELECT * FROM
comments WHERE comment_id = 1` is first called, appending this to result
and working table. The recursive bit `SELECT c.* FROM comments c INNER
JOIN child_comments cc ON c.parent_id = cc.comment_id` is then called
using the working table as the child_comments part. The result the
intermediate table, and is appended to the result, and replaces the
working table. This happens until the intermediate table is empty.





Table structure:


# Gets all children for comment_id 1

TODO: 
- investigate cycles
- investigate how to validate correct parent relationships
- how do I deal with parent deletions


Resources:
https://www.postgresql.org/docs/9.1/queries-with.html
https://www.citusdata.com/blog/2018/05/15/fun-with-sql-recursive-ctes/

