/*
Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, 
and the total number of challenges created by each student. 
Sort your results by the total number of challenges in descending order. 
If more than one student created the same number of challenges, then sort the result by hacker_id. 
If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, 
then exclude those students from the result.
*/

/*
SELECT 
  hacker_id,
  name,
  total number of challenges created by each student

ORDER BY
  total_num_challenges DESC,
  hacker_id ASC

If more than one student created the same number of challenges 
and the count is less than the maximum number of challenges created, 
then exclude those students from the result.
*/
SET @max_num_challenges = (SELECT MAX(num_challenges)
    FROM (SELECT COUNT(challenge_id) AS num_challenges
        FROM challenges
        GROUP BY hacker_id) list_num_challenges);

SELECT hc.hacker_id, (SELECT name FROM hackers WHERE hacker_id=hc.hacker_id) AS name, hc.num_challenges
FROM (SELECT hacker_id, COUNT(challenge_id) AS num_challenges,
    COUNT(hacker_id) OVER(PARTITION BY COUNT(challenge_id)) AS num_hackers 
    FROM challenges
    GROUP BY hacker_id
    ORDER BY num_challenges DESC, hacker_id) hc
WHERE hc.num_hackers=1 OR (hc.num_challenges = @max_num_challenges)

-- OTHER PERSON
SELECT c.hacker_id, h.name, count(c.challenge_id) AS cnt 
FROM Hackers AS h JOIN Challenges AS c ON h.hacker_id = c.hacker_id
GROUP BY c.hacker_id, h.name 
HAVING cnt = (SELECT count(c1.challenge_id) FROM Challenges AS c1 GROUP BY c1.hacker_id 
              ORDER BY count(*) desc limit 1) or /*Igual al máximo de desafíos*/
cnt NOT IN (SELECT count(c2.challenge_id) FROM Challenges AS c2 GROUP BY c2.hacker_id 
            HAVING c2.hacker_id <> c.hacker_id) /*Sólo existe un hacker con el cnt actual*/
ORDER BY cnt DESC, c.hacker_id;



-- HACKERS
INSERT INTO hackers(hacker_id, name) VALUES (5077, 'Rose');
INSERT INTO hackers(hacker_id, name) VALUES (21283, 'Angela');
INSERT INTO hackers(hacker_id, name) VALUES (62743, 'Frank');
INSERT INTO hackers(hacker_id, name) VALUES (88255, 'Patrick');
INSERT INTO hackers(hacker_id, name) VALUES (96196, 'Lisa');
-- second example
INSERT INTO hackers(hacker_id, name) VALUES (12299, 'Rose');
INSERT INTO hackers(hacker_id, name) VALUES (34856, 'Angela');
INSERT INTO hackers(hacker_id, name) VALUES (79345, 'Frank');
INSERT INTO hackers(hacker_id, name) VALUES (80491, 'Patrick');
INSERT INTO hackers(hacker_id, name) VALUES (81041, 'Lisa');

-- CHALLENGES
INSERT INTO challenges(challenge_id, hacker_id) VALUES (61654, 5077);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (58302, 21283);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (40587, 88255);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (29477, 5077);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (1220, 21283);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (69514, 21283);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (46561, 62743);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (58077, 62743);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (18484, 88255);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (76766, 21283);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (52382, 5077);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (74467, 21283);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (33625, 96196);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (26053, 88255);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (42665, 62743);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (12859, 62743);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (70094, 21283);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (34599, 88255);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (54680, 88255);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (61881, 5077);

-- seccond example
INSERT INTO challenges(challenge_id, hacker_id) VALUES (63963, 81041);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (63117, 79345);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (28225, 34856);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (21989, 12299);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (4653, 12299);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (70070, 79345);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (36905, 34856);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (61136, 80491);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (17234, 12299);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (80308, 79345);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (40510, 34856);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (79820, 80491);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (22720, 12299);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (21394, 12299);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (36261, 34856);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (15334, 12299);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (71435, 79345);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (23157, 34856);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (54102, 34856);
INSERT INTO challenges(challenge_id, hacker_id) VALUES (69065, 80491);
