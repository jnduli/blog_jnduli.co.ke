######################################
Comment System Using Recursive Queries
######################################
:date: 2021-04-09
:category: Engineering
:slug: comment-system-using-recursive-queries
:author: John Nduli
:status: drafts




Table structure:

CREATE TABLE comments (comment_id SERIAL PRIMARY KEY, comment TEXT, parent_id INT);

INSERT INTO comments (comment_id, comment, parent_id) VALUES 
(1, 'random', NULL),
(2, 'random', NULL),
(3, 'random', 1),
(4, 'random', 1),
(5, 'random', 2),
(6, 'random', 3),
(7, 'random', 6),
(8, 'random', 7),
(9, 'random', 1),
(10, 'random', 5);

# Gets all children for comment_id 1
WITH RECURSIVE child_comments AS (
    SELECT * FROM comments WHERE comment_id = 1
    UNION
    SELECT c.comment_id, c.comment, c.parent_id FROM comments c
    INNER JOIN child_comments cc ON c.parent_id = cc.comment_id
) SELECT * FROM child_comments ;

TODO: 
- investigate cycles
- investigate how to validate correct parent relationships
- how do I deal with parent deletions


Resources:
https://www.postgresql.org/docs/9.1/queries-with.html
https://www.citusdata.com/blog/2018/05/15/fun-with-sql-recursive-ctes/

