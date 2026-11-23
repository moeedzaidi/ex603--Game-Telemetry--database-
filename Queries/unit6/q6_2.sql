-- Task 6.2, Part A
-- Question: How does each event's score compare
-- with the previous and next event in the same match?

SELECT
    match_id,
    player_id,
    participated_at,
    score,

    LAG(score) OVER (
        PARTITION BY match_id
        ORDER BY participated_at, player_id
    ) AS previous_score,

    LEAD(score) OVER (
        PARTITION BY match_id
        ORDER BY participated_at, player_id
    ) AS next_score,

    score - LAG(score) OVER (
        PARTITION BY match_id
        ORDER BY participated_at, player_id
    ) AS score_delta

FROM public.match_participants
WHERE match_id = 1
ORDER BY participated_at, player_id;








-- Task 6.2, Part B
-- Question: How does the platform's cumulative score
-- and recent average change over time?

WITH event_trends AS (
    SELECT
        participated_at,
        match_id,
        player_id,
        score,

        SUM(score) OVER (
            ORDER BY participated_at, match_id, player_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_total,

        AVG(score) OVER (
            ORDER BY participated_at, match_id, player_id
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS moving_avg

    FROM public.match_participants
)

SELECT
    participated_at,
    match_id,
    player_id,
    score,
    running_total,
    ROUND(moving_avg, 2) AS moving_avg,

    100000 AS target,

    ROUND(
        running_total::numeric / 100000 * 100,
        2
    ) AS target_percentage

FROM event_trends
ORDER BY participated_at, match_id, player_id;



-- Task 6.2, Part C
-- Question: Which matches have a gap of more than 7 days
-- between consecutive participation events?

WITH event_gaps AS (
    SELECT
        match_id,
        player_id,
        participated_at,

        LAG(participated_at) OVER (
            PARTITION BY match_id
            ORDER BY participated_at, player_id
        ) AS previous_event_time

    FROM public.match_participants
)

SELECT
    match_id,
    player_id,
    previous_event_time,
    participated_at AS current_event_time,
    participated_at - previous_event_time AS time_gap

FROM event_gaps
WHERE previous_event_time IS NOT NULL
  AND participated_at - previous_event_time > INTERVAL '7 days'

ORDER BY time_gap DESC;

























