-- Task 4.1.1: Platform-wide score statistics.
-- Question: How many events and distinct players are recorded, and what are the overall score statistics?

SELECT
    COUNT(*) AS event_count,
    SUM(score) AS total_score,
    AVG(score) AS average_score,
    MIN(score) AS minimum_score,
    MAX(score) AS maximum_score,
    COUNT(DISTINCT player_id) AS distinct_players
FROM match_participants;


-- Task 4.1.2: Event volume and average score per producer.
-- Question: Which matches have the most events, and what is their average score?

SELECT
    m.match_id AS producer_id,
    m.server_region,
    COUNT(mp.participation_id) AS event_count,
    AVG(mp.score) AS average_score
FROM matches AS m
JOIN match_participants AS mp
    ON m.match_id = mp.match_id
GROUP BY m.match_id, m.server_region
ORDER BY event_count DESC, producer_id;



-- Task 4.1.3: Filter producers by minimum event volume.
-- Question: Which producers have at least 10 events for a more meaningful comparison?

SELECT
    m.match_id AS producer_id,
    m.server_region,
    COUNT(mp.participation_id) AS event_count,
    AVG(mp.score) AS average_score
FROM matches AS m
JOIN match_participants AS mp
    ON m.match_id = mp.match_id
GROUP BY m.match_id, m.server_region
HAVING COUNT(mp.participation_id) >= 10
ORDER BY event_count DESC, producer_id;

-- Task 4.1.4: Compare producer performance across regions.
-- Question: How do event volume and score statistics vary by producer and server region?

SELECT
    m.match_id AS producer_id,
    m.server_region,
    COUNT(mp.participation_id) AS event_count,
    AVG(mp.score) AS average_score,
    MIN(mp.score) AS minimum_score,
    MAX(mp.score) AS maximum_score
FROM matches AS m
JOIN match_participants AS mp
    ON m.match_id = mp.match_id
GROUP BY m.match_id, m.server_region
ORDER BY m.server_region, event_count DESC;
