
-- Task 6.1, Part 1
-- Question: How does each participation event's score
-- compare with the average score for its match?

SELECT
    mp.match_id,
    mp.player_id,
    mp.participated_at,
    mp.score,
    ROUND(
        AVG(mp.score) OVER (
            PARTITION BY mp.match_id
        ),
        2
    ) AS producer_avg_score
FROM match_participants mp
ORDER BY
    mp.match_id,
    mp.participated_at,
    mp.player_id;


-- Task 6.1, Part 1 - GROUP BY comparison
-- Question: What is the average score for each match?

SELECT
    mp.match_id,
    ROUND(AVG(mp.score), 2) AS producer_avg_score,
    COUNT(*) AS event_count
FROM match_participants mp
GROUP BY mp.match_id
ORDER BY mp.match_id;





-- Task 6.1, Part 2
-- Question: How do matches rank by their number of participation events?

WITH producer_counts AS (
    SELECT
        m.match_id,
        COUNT(mp.player_id) AS event_count
    FROM matches m
    LEFT JOIN match_participants mp
        ON m.match_id = mp.match_id
    GROUP BY m.match_id
)

SELECT
    match_id,
    event_count,

    ROW_NUMBER() OVER (
        ORDER BY event_count DESC, match_id
    ) AS row_num,

    RANK() OVER (
        ORDER BY event_count DESC
    ) AS rank_num,

    DENSE_RANK() OVER (
        ORDER BY event_count DESC
    ) AS dense_rank_num

FROM producer_counts
ORDER BY event_count DESC, match_id;










-- Task 6.1, Part 3
-- Question: How can matches be divided into four bands
-- based on their number of participation events?

WITH producer_counts AS (
    SELECT
        m.match_id,
        COUNT(mp.player_id) AS event_count
    FROM matches m
    LEFT JOIN match_participants mp
        ON m.match_id = mp.match_id
    GROUP BY m.match_id
)

SELECT
    match_id,
    event_count,
    NTILE(4) OVER (
        ORDER BY event_count DESC, match_id
    ) AS event_band

FROM producer_counts
ORDER BY event_count DESC, match_id;
