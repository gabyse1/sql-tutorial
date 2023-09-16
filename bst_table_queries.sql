/*
You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.

Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.
*/
SELECT
    CASE
        WHEN P IS NULL THEN CONCAT(N, ' Root')
        WHEN N IN (SELECT DISTINCT P FROM BST) THEN CONCAT(N, ' Inner')
        ELSE CONCAT(N, ' Leaf')
    END AS 'Node Type'
FROM BST
ORDER BY n;

-- OTHERS ANSWER
SELECT N, IF(P IS NULL,'Root',IF(
    (SELECT COUNT(*) FROM BST WHERE P=B.N)>0,'Inner','Leaf')) FROM BST AS B ORDER BY N;