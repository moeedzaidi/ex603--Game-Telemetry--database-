-- Q5.2 Part A.1
-- Show every producer (match), including matches with no events.

SELECT
    m.match_id,
    m.match_label,
    mp.participation_id AS event_id,
    mp.joined_at
FROM matches m
LEFT JOIN match_participants mp
    ON m.match_id = mp.match_id
ORDER BY m.match_id, mp.participation_id;




-- Q5.2 Part A.2
-- Show only producers that have at least one event.

SELECT
    m.match_id,
    m.match_label,
    mp.participation_id AS event_id,
    mp.joined_at
FROM matches m
INNER JOIN match_participants mp
    ON m.match_id = mp.match_id
ORDER BY m.match_id, mp.participation_id;


-- Q5.2 Part A.3
-- Identify producers excluded by INNER JOIN and count them.

SELECT
    m.match_id,
    m.match_label
FROM matches m
LEFT JOIN match_participants mp
    ON m.match_id = mp.match_id
WHERE mp.match_id IS NULL
ORDER BY m.match_id;



-- Q5.2 Part B.1
-- Return all producers using RIGHT JOIN.

SELECT
    m.match_id,
    m.match_label,
    mp.participation_id AS event_id,
    mp.joined_at
FROM match_participants mp
RIGHT JOIN matches m
    ON mp.match_id = m.match_id
ORDER BY m.match_id, mp.participation_id;



-- Q5.2 Part B.2
-- Include matching and unmatched records from both tables.

SELECT
    m.match_id,
    m.match_label,
    mp.participation_id AS event_id,
    mp.joined_at
FROM matches m
FULL OUTER JOIN match_participants mp
    ON m.match_id = mp.match_id
ORDER BY m.match_id, mp.participation_id;




-- Q5.2 Part C.1
-- Find producers that have never had an event using NOT EXISTS.

SELECT
    m.match_id,
    m.match_label
FROM matches m
WHERE NOT EXISTS (
    SELECT 1
    FROM match_participants mp
    WHERE mp.match_id = m.match_id
)
ORDER BY m.match_id;



-- Q5.2 Part C.2
-- Find producers without events using EXCEPT.

SELECT match_id
FROM matches

EXCEPT

SELECT match_id
FROM match_participants

ORDER BY match_id;





