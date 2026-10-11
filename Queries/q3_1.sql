

-- Task 3.1, Question 1
-- Find active, highly rated matches.
-- Theme filter: ranked matches with at least 8 players.

SELECT
    match_id,
    match_label,
    scheduled_on,
    server_region,
    player_count
FROM matches
WHERE is_ranked = TRUE
  AND player_count >= 8
ORDER BY player_count DESC, scheduled_on DESC
LIMIT 10;


-- Task 3.1, Question 2
-- Display all distinct event participation statuses.

SELECT DISTINCT
    participation_status
FROM match_participants
ORDER BY participation_status;




-- Task 3.1, Question 3A
-- Find participation events with scores between 100 and 500.

SELECT
    participation_id,
    player_id,
    match_id,
    score,
    participation_status
FROM match_participants
WHERE score BETWEEN 100 AND 500
ORDER BY score DESC;

-- Task 3.1, Question 3B
-- Find events with selected participation statuses.

SELECT
    participation_id,
    player_id,
    match_id,
    score,
    participation_status
FROM match_participants
WHERE participation_status IN ('completed', 'disconnected')
ORDER BY participation_status;



-- Task 3.1, Question 4A
-- Find matches whose labels contain the word "rank".

SELECT
    match_id,
    match_label,
    server_region
FROM matches
WHERE match_label LIKE '%rank%';

-- Task 3.1, Question 4B
-- Find participation records with no disconnect reason.

SELECT
    participation_id,
    participation_status,
    disconnect_reason
FROM match_participants
WHERE disconnect_reason IS NULL;

-- Task 3.1, Question 4C
-- Display a readable label when the disconnect reason is missing.

SELECT
    participation_id,
    participation_status,
    COALESCE(disconnect_reason, 'No reason provided')
        AS reason_display
FROM match_participants;




-- Task 3.1, Question 5
-- Make player participation results easier to understand.

SELECT
    participation_id,
    player_id,
    match_id,
    score AS total_score,
    duration_min AS minutes_played,
    CASE
        WHEN score >= 1000 THEN 'High Score'
        WHEN score >= 500 THEN 'Medium Score'
        ELSE 'Low Score'
    END AS score_category,
    CASE
        WHEN duration_min >= 60 THEN 'Long Session'
        WHEN duration_min >= 30 THEN 'Medium Session'
        ELSE 'Short Session'
    END AS session_category,
    COALESCE(participation_status, 'Status unknown')
        AS readable_status
FROM match_participants
ORDER BY score DESC
LIMIT 20;
