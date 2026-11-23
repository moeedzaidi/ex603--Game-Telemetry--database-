-- Task 6.3, Part A
-- Question: What are the top three scoring events
-- for each match?

WITH ranked_events AS (
    SELECT
        match_id,
        player_id,
        participated_at,
        score,

        RANK() OVER (
            PARTITION BY match_id
            ORDER BY score DESC
        ) AS event_rank,

        FIRST_VALUE(player_id) OVER (
            PARTITION BY match_id
            ORDER BY score DESC, participated_at, player_id
        ) AS top_scoring_player_id

    FROM public.match_participants
)

SELECT
    match_id,
    player_id,
    participated_at,
    score,
    event_rank,
    top_scoring_player_id

FROM ranked_events
WHERE event_rank <= 3
ORDER BY match_id, event_rank, participated_at, player_id;





-- Task 6.3, Part B
-- Question: Is the platform's total event score
-- increasing or decreasing each month?

WITH monthly_totals AS (
    SELECT
        DATE_TRUNC('month', participated_at) AS month_start,
        SUM(score) AS monthly_score
    FROM public.match_participants
    GROUP BY DATE_TRUNC('month', participated_at)
),

month_calendar AS (
    SELECT
        GENERATE_SERIES(
            (SELECT MIN(month_start) FROM monthly_totals),
            (SELECT MAX(month_start) FROM monthly_totals),
            INTERVAL '1 month'
        ) AS month_start
),

monthly_series AS (
    SELECT
        mc.month_start,
        mt.monthly_score
    FROM month_calendar mc
    LEFT JOIN monthly_totals mt
        ON mc.month_start = mt.month_start
),

monthly_comparison AS (
    SELECT
        month_start,
        monthly_score,

        LAG(monthly_score) OVER (
            ORDER BY month_start
        ) AS previous_month_score

    FROM monthly_series
)

SELECT
    TO_CHAR(month_start, 'YYYY-MM') AS report_month,
    monthly_score,
    previous_month_score,

    ROUND(
        (
            (monthly_score::numeric - previous_month_score::numeric)
            / NULLIF(previous_month_score::numeric, 0)
        ) * 100,
        2
    ) AS percent_change,

    CASE
        WHEN monthly_score IS NULL THEN 'MISSING MONTH'
        ELSE 'DATA PRESENT'
    END AS month_status

FROM monthly_comparison
ORDER BY month_start;
