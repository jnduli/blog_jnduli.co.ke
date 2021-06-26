######################################
Comment System Using Recursive Queries
######################################
:date: 2021-06-26
:category: Engineering
:slug: comment-system-using-recursive-queries
:author: John Nduli
:status: published


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
    ) SELECT a from fib limit 20;

Here's how this would work:

1. There are three tables, intermediate, working and result table. The
   non-recursive part is first calculated, setting the working and
   result table to values (0, 1)
2. The recursive part of the query `select b, a + b from fib` is then
   run on. `fib` here is the working table, which contains (0, 1).  This
   sets the intermediate table to (1, 1). This gets appended to the result
   table, and replaces the working table.
3. In the next run, the working table is (1, 1), resulting in (1, 2) in
   the intermediate table, which gets appended to the result table, and
   replaces the working table. This goes on and on.
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

5. The last select statement: `SELECT a from fib limit 20;` picks the
   information from the result table. Limiting this too can cause the
   infinite recursion to stop.

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
        UNION ALL
        SELECT c.* FROM comments c INNER JOIN child_comments cc ON c.parent_id = cc.comment_id
    ) SELECT * FROM child_comments ;


A good use case is when you have partitioned tables and want to see all
descendant of a particular parent.

.. code-block:: sql

    DROP TABLE IF EXISTS parent;
    CREATE TABLE parent (id INT, user_id INT, topic_id INT, comment TEXT) PARTITION BY HASH(user_id);
    CREATE TABLE child_1 PARTITION OF parent FOR VALUES WITH (modulus 2, remainder 0) PARTITION BY HASH(topic_id);
    CREATE TABLE child_2 PARTITION OF parent FOR VALUES WITH (modulus 2, remainder 1);
    CREATE TABLE grand_child_1 PARTITION OF child_1 FOR VALUES WITH (modulus 2, remainder 0);
    CREATE TABLE grand_child_2 PARTITION OF child_1 FOR VALUES WITH (modulus 2, remainder 1);

    WITH RECURSIVE child_partition AS (
    SELECT inhparent, inhrelid FROM pg_catalog.pg_inherits WHERE inhparent = 'parent'::regclass
    UNION ALL
    SELECT pg_cat.inhparent, pg_cat.inhrelid FROM pg_catalog.pg_inherits pg_cat INNER JOIN child_partition cp ON pg_cat.inhparent = cp.inhrelid
    ) SELECT inhparent::regclass AS parent, inhrelid::regclass AS child from child_partition;

which results in:

.. code-block:: sql

     parent  |     child
    ---------+---------------
     parent  | child_1
     parent  | child_2
     child_1 | grand_child_1
     child_1 | grand_child_2
    (4 rows)


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


But how do we prevent cycle creation in the query itself? One method is
to have a trigger that gets all parents of a child comment, and doesn't
update if the update would cause a cycle.

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
