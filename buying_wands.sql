/*
Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.

Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.

Input Format

The following tables contain data on the wands in Ollivander's inventory:

Wands: The id is the id of the wand, code is the code of the wand, coins_needed is the total number of gold galleons needed to buy the wand, and power denotes the quality of the wand (the higher the power, the better the wand is). 

Wands_Property: The code is the code of the wand, age is the age of the wand, and is_evil denotes whether the wand is good for the dark arts. If the value of is_evil is 0, it means that the wand is not evil. The mapping between code and age is one-one, meaning that if there are two pairs, (code1, age1) and (code2, age2), then (code1 != code2) and (age1 != age2).
*/

SELECT id, age, coins_needed, power
FROM wands
JOIN wands_property ON wands.code = wands_property.code AND wands_property.is_evil = 0
WHERE (wands.code, wands.coins_needed, wands.power) IN (
    SELECT code, MIN(coins_needed), power
    FROM wands
    GROUP BY code, power
)
ORDER BY power DESC, age DESC;

----DE OTRA PERSONA
SELECT 
       w.id, 
       p.age, 
       w.coins_needed, 
       w.power 
FROM   wands AS w 
JOIN wands_property AS p ON ( w.code = p.code ) 
WHERE  p.is_evil = 0 
       AND w.coins_needed = (
                             SELECT Min(coins_needed) 
                             FROM   wands AS w1 
                             JOIN   wands_property AS p1 
                             ON   ( w1.code = p1.code ) 
                             WHERE  w1.power = w.power 
                             AND    p1.age = p.age
                            ) 
ORDER  BY w.power DESC, 
          p.age DESC


---DE OTRA PERSONA
WITH min_coins AS (
SELECT ROW_NUMBER() OVER(PARTITION BY code, power ORDER BY code, power, coins_needed) AS RowNumber, id, code, coins_needed, power
FROM wands
-- ORDER BY code, power;
)
SELECT id, age, coins_needed, power
FROM wands_property wp
JOIN min_coins mc ON mc.code = wp.code AND mc.RowNumber = 1
WHERE is_evil = 0
ORDER BY power DESC, age DESC;

----Wands
INSERT INTO wands(id, code, coins_needed, power) VALUES(1, 4, 3688, 8);
INSERT INTO wands(id, code, coins_needed, power) VALUES(2, 3, 9365, 3);
INSERT INTO wands(id, code, coins_needed, power) VALUES(3, 3, 7187, 10);
INSERT INTO wands(id, code, coins_needed, power) VALUES(4, 3, 734, 8);
INSERT INTO wands(id, code, coins_needed, power) VALUES(5, 1, 6020, 2);
INSERT INTO wands(id, code, coins_needed, power) VALUES(6, 2, 6773, 7);
INSERT INTO wands(id, code, coins_needed, power) VALUES(7, 3, 9873, 9);
INSERT INTO wands(id, code, coins_needed, power) VALUES(8, 3, 7721, 7);
INSERT INTO wands(id, code, coins_needed, power) VALUES(9, 1, 1647, 10);
INSERT INTO wands(id, code, coins_needed, power) VALUES(10, 4, 504, 5);
INSERT INTO wands(id, code, coins_needed, power) VALUES(11, 2, 7587, 5);
INSERT INTO wands(id, code, coins_needed, power) VALUES(12, 5, 9897, 10);
INSERT INTO wands(id, code, coins_needed, power) VALUES(13, 3, 4651, 8);
INSERT INTO wands(id, code, coins_needed, power) VALUES(14, 2, 5408, 1);
INSERT INTO wands(id, code, coins_needed, power) VALUES(15, 2, 6018, 7);
INSERT INTO wands(id, code, coins_needed, power) VALUES(16, 4, 7710, 5);
INSERT INTO wands(id, code, coins_needed, power) VALUES(17, 2, 8798, 7);
INSERT INTO wands(id, code, coins_needed, power) VALUES(18, 2, 3312, 3);
INSERT INTO wands(id, code, coins_needed, power) VALUES(19, 4, 7651, 6);
INSERT INTO wands(id, code, coins_needed, power) VALUES(20, 5, 5689, 3);

-- Wands_property
INSERT INTO wands_property(code, age, is_evil) VALUES(1, 45, 0);
INSERT INTO wands_property(code, age, is_evil) VALUES(2, 40, 0);
INSERT INTO wands_property(code, age, is_evil) VALUES(3, 4, 1);
INSERT INTO wands_property(code, age, is_evil) VALUES(4, 20, 0);
INSERT INTO wands_property(code, age, is_evil) VALUES(5, 17, 0);