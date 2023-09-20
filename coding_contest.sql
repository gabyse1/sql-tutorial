SELECT submissions.hacker_id, hackers.name
FROM submissions
INNER JOIN hackers ON submissions.hacker_id = hackers.hacker_id
WHERE score = (
    SELECT score
    FROM difficulty
    WHERE difficulty_level = (
        SELECT challenges.difficulty_level
        FROM challenges
        WHERE submissions.challenge_id = challenges.challenge_id
    )
)
GROUP BY submissions.hacker_id, hackers.name
HAVING COUNT(submissions.challenge_id) > 1
ORDER BY COUNT(submissions.challenge_id) DESC, submissions.hacker_id

---------------------------------------------------------------------------
WITH leaderboard AS (
    SELECT hacker_id, COUNT(challenge_id) AS num_challenges
    FROM submissions
    WHERE score = (
        SELECT score
        FROM difficulty
        WHERE difficulty_level = (
            SELECT challenges.difficulty_level
            FROM challenges
            WHERE submissions.challenge_id = challenges.challenge_id
        )
    )
    GROUP BY hacker_id
    ORDER BY num_challenges DESC, hacker_id
)
SELECT leaderboard.hacker_id, hackers.name
FROM leaderboard
JOIN hackers ON leaderboard.hacker_id = hackers.hacker_id
WHERE leaderboard.num_challenges > 1



---- HACKERS
INSERT INTO hackers(hacker_id, name) VALUES (5580, 'Rose');
INSERT INTO hackers(hacker_id, name) VALUES (8439, 'Angela');
INSERT INTO hackers(hacker_id, name) VALUES (27205, 'Frank');
INSERT INTO hackers(hacker_id, name) VALUES (52243, 'Patrick');
INSERT INTO hackers(hacker_id, name) VALUES (52348, 'Lisa');
INSERT INTO hackers(hacker_id, name) VALUES (57645, 'Kimberly');
INSERT INTO hackers(hacker_id, name) VALUES (77726, 'Bonnie');
INSERT INTO hackers(hacker_id, name) VALUES (83082, 'Michael');
INSERT INTO hackers(hacker_id, name) VALUES (86870, 'Todd');
INSERT INTO hackers(hacker_id, name) VALUES (90411, 'Joe');

---- difficulty
INSERT INTO difficulty(difficulty_level, score) VALUES (1, 20);
INSERT INTO difficulty(difficulty_level, score) VALUES (2, 30);
INSERT INTO difficulty(difficulty_level, score) VALUES (3, 40);
INSERT INTO difficulty(difficulty_level, score) VALUES (4, 60);
INSERT INTO difficulty(difficulty_level, score) VALUES (5, 80);
INSERT INTO difficulty(difficulty_level, score) VALUES (6, 100);
INSERT INTO difficulty(difficulty_level, score) VALUES (7, 120);

----CHALLENGES
INSERT INTO challenges(challenge_id, hacker_id, difficulty_level) VALUES (4810, 77726, 4);
INSERT INTO challenges(challenge_id, hacker_id, difficulty_level) VALUES (21089, 27205, 1);
INSERT INTO challenges(challenge_id, hacker_id, difficulty_level) VALUES (36566, 5580, 7);
INSERT INTO challenges(challenge_id, hacker_id, difficulty_level) VALUES (66730, 52243, 6);
INSERT INTO challenges(challenge_id, hacker_id, difficulty_level) VALUES (71055, 52243, 2);

---SUBMISSIONS
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (1, 77726, 36566, 30);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (2, 77726, 21089, 10);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (3, 52243, 36566, 77);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (4, 27205, 4810, 4);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (5, 77726, 66730, 30);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (6, 52243, 66730, 0);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (7, 52348, 71055, 20);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (8, 27205, 71055, 23);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (9, 86870, 71055, 30);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (10, 52348, 36566, 0);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (11, 86870, 36566, 30);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (12, 8439, 66730, 92);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (13, 8439, 4810, 36);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (14, 5580, 71055, 4);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (15, 52348, 66730, 0);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (16, 57645, 66730, 80);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (17, 27205, 66730, 35);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (18, 8439, 36566, 80);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (19, 90411, 66730, 100);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (20, 83082, 4810, 40);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (21, 90411, 71055, 30);


----------------------------------------------------------------------------
/*
You did such a great job helping Julia with her last coding contest challenge 
that she wants you to work on this one, too!

The total score of a hacker is the sum of their maximum scores for all of the challenges. 
Write a query to print the hacker_id, name, and total score of the hackers ordered 
by the descending score. If more than one hacker achieved the same total score, 
then sort the result by ascending hacker_id. 
Exclude all hackers with a total score of 0 from your result.
*/
SELECT ms.hacker_id, (SELECT name FROM hackers WHERE hacker_id=ms.hacker_id) AS name, SUM(ms.max_score) as total_score
FROM (SELECT hacker_id, challenge_id, MAX(score) AS max_score
      FROM submissions
      WHERE score > 0
      GROUP BY hacker_id, challenge_id) ms
GROUP BY ms.hacker_id
ORDER BY total_score DESC, ms.hacker_id


-- hackers
INSERT INTO hackers(hacker_id, name) VALUES (4071, 'Rose');
INSERT INTO hackers(hacker_id, name) VALUES (4806, 'Angela');
INSERT INTO hackers(hacker_id, name) VALUES (26071, 'Frank');
INSERT INTO hackers(hacker_id, name) VALUES (49438, 'Patrick');
INSERT INTO hackers(hacker_id, name) VALUES (74842, 'Lisa');
INSERT INTO hackers(hacker_id, name) VALUES (80305, 'Kimberly');
INSERT INTO hackers(hacker_id, name) VALUES (84072, 'Bonnie');
INSERT INTO hackers(hacker_id, name) VALUES (87868, 'Michael');
INSERT INTO hackers(hacker_id, name) VALUES (92118, 'Todd');
INSERT INTO hackers(hacker_id, name) VALUES (95895, 'Joe');

-- submissions
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (67194, 74842, 63132, 76);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (64479, 74842, 19797, 98);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (40742, 26071, 49593, 20);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (17513, 4806, 49593, 32);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (69846, 80305, 19797, 19);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (41002, 26071, 89343, 36);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (52826, 49438, 49593, 9);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (31093, 26071, 19797, 2);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (81614, 84072, 49593, 100);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (44829, 26071, 89343, 17);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (75147, 80305, 49593, 48);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (14115, 4806, 49593, 76);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (6943, 4071, 19797, 95);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (12855, 4806, 25917, 13);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (73343, 80305, 49593, 42);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (84264, 84072, 63132, 0);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (9951, 4071, 49593, 43);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (45104, 49438, 25917, 34);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (53795, 74842, 19797, 5);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (26363, 26071, 19797, 29);
INSERT INTO submissions(submission_id, hacker_id, challenge_id, score) VALUES (10063, 4071, 49593, 96);