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
