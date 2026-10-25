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
