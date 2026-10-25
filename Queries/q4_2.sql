-- Inspect recorded disconnect reasons before defining failure.
SELECT
    disconnect_reason,
    COUNT(*) AS event_count
FROM match_participants
GROUP BY disconnect_reason
ORDER BY event_count DESC;

SELECT
    match_id AS producer_id,
    COUNT(*) AS total_events,
    SUM(
        CASE
            WHEN disconnect_reason = 'network_timeout' THEN 1
            ELSE 0
        END
    ) AS failure_events
FROM match_participants
GROUP BY match_id
ORDER BY total_events DESC;


-- Task 4.2 Part B: Regional subtotals and platform grand total.
-- Question: What are the event totals by server region and across the whole platform?

SELECT
    CASE
        WHEN GROUPING(m.server_region) = 1
            THEN 'PLATFORM GRAND TOTAL'
        ELSE m.server_region
    END AS region_summary,
    COUNT(mp.participation_id) AS total_events,
    SUM(mp.score) AS total_score,
    GROUPING(m.server_region) AS grouping_level
FROM matches AS m
JOIN match_participants AS mp
    ON m.match_id = mp.match_id
GROUP BY GROUPING SETS (
    (m.server_region),
    ()
)
ORDER BY
    GROUPING(m.server_region),
    region_summary;




-- Task 4.2 Part C: Establish a failure-rate baseline for high-volume producers.
-- Replace the failure condition with the value confirmed from the dataset.

WITH producer_summary AS (
    SELECT
        match_id AS producer_id,
        COUNT(*) AS total_events,
        SUM(
            CASE
                WHEN /* confirmed failure condition */ THEN 1
                ELSE 0
            END
        ) AS failure_events
    FROM match_participants
    GROUP BY match_id
)
SELECT
    COUNT(*) AS high_volume_producers,
    AVG(
        100.0 * failure_events / NULLIF(total_events, 0)
    ) AS baseline_failure_rate_percent,
    MIN(
        100.0 * failure_events / NULLIF(total_events, 0)
    ) AS minimum_producer_failure_rate_percent,
    MAX(
        100.0 * failure_events / NULLIF(total_events, 0)
    ) AS maximum_producer_failure_rate_percent
FROM producer_summary
WHERE total_events >= 10;
