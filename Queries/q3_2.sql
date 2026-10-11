
-- Task 3.2 Part A, Step 1
-- Check for missing participation statuses.

SELECT
    COUNT(*) AS total_rows,
    COUNT(participation_status) AS rows_with_status,
    COUNT(*) - COUNT(participation_status) AS rows_with_null_status
FROM match_participants;




-- Step 2: The original filter that silently excludes NULLs.

SELECT COUNT(*) AS rows_returned
FROM match_participants
WHERE participation_status != 'completed';



-- Step 3: Compare the counts.

SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (
        WHERE participation_status != 'completed'
    ) AS original_filter_count,
    COUNT(*) FILTER (
        WHERE participation_status IS NULL
    ) AS null_rows_omitted
FROM match_participants;





-- Step 4: Corrected filter includes NULL statuses.

SELECT
    participation_id,
    player_id,
    match_id,
    participation_status,
    disconnect_reason
FROM match_participants
WHERE participation_status != 'completed'
   OR participation_status IS NULL;






-- Task 3.2 Part B, Step 1
-- Intentionally incorrect: alias used in WHERE.

SELECT
    participation_id,
    score * 2 AS doubled_score
FROM match_participants
WHERE doubled_score > 1000;



-- Correct rewrite 1: Repeat the expression in WHERE.

SELECT
    participation_id,
    score * 2 AS doubled_score
FROM match_participants
WHERE score * 2 > 1000;

-- Correct rewrite 2: Define the alias inside a CTE.

WITH scored_participants AS (
    SELECT
        participation_id,
        score * 2 AS doubled_score
    FROM match_participants
)
SELECT
    participation_id,
    doubled_score
FROM scored_participants
WHERE doubled_score > 1000;

