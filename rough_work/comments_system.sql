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

\echo 'all comments in table'
SELECT * FROM comments;

\echo 'Recursive children of comment_id 1'
WITH RECURSIVE child_comments AS (
    SELECT * FROM comments WHERE comment_id = 1
    UNION ALL
    SELECT c.* FROM comments c INNER JOIN child_comments cc ON c.parent_id = cc.comment_id
) SELECT * FROM child_comments ;

\echo 'Adding a cycle to the table'

UPDATE comments SET parent_id=8 WHERE comment_id=1;

WITH RECURSIVE child_comments AS (
    SELECT * FROM comments WHERE comment_id = 1
    UNION ALL
    SELECT c.* FROM comments c INNER JOIN child_comments cc ON c.parent_id = cc.comment_id
) SELECT * FROM child_comments LIMIT 10;


SELECT *, array[comment_id] as all_parents FROM comments;

-- https://stackoverflow.com/a/31745768
\echo 'Shouldnt have cycles in it'

WITH RECURSIVE child_comments AS (
    SELECT *, array[comment_id] as visited_parents FROM comments WHERE comment_id = 1
    UNION ALL
    SELECT c.*, cc.visited_parents || c.comment_id as visited_parents FROM comments c INNER JOIN child_comments cc ON c.parent_id = cc.comment_id WHERE NOT c.comment_id = ANY (cc.visited_parents)
) SELECT * FROM child_comments LIMIT 10;


-- Get all parents of 8

\echo 'Drop cycle from the table'

UPDATE comments SET parent_id=NULL WHERE comment_id=1;

WITH RECURSIVE parents AS (
    SELECT parent_id from comments where comment_id = 8
    UNION ALL
    select c.parent_id from comments c INNER JOIN parents p on p.parent_id=c.comment_id
) SELECT * FROM parents LIMIT 10;


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


UPDATE comments SET parent_id=8 WHERE comment_id=1;
