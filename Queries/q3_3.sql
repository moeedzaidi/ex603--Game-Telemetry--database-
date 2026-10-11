
-- Method 1: Subquery using IN
-- Find players with at least one participation scoring 1000+.

SELECT DISTINCT p.player_id
FROM players AS p
WHERE p.player_id IN (
    SELECT mp.player_id
    FROM match_participants AS mp
    WHERE mp.score >= 1000
)
ORDER BY p.player_id;



-- Method 2: CTE using WITH

WITH high_score_players AS (
    SELECT player_id
    FROM match_participants
    WHERE score >= 1000
)
SELECT DISTINCT p.player_id
FROM players AS p
JOIN high_score_players AS hsp
    ON hsp.player_id = p.player_id
ORDER BY p.player_id;



-- Method 3: Correlated subquery using EXISTS

SELECT p.player_id
FROM players AS p
WHERE EXISTS (
    SELECT 1
    FROM match_participants AS mp
    WHERE mp.player_id = p.player_id
      AND mp.score >= 1000
)
ORDER BY p.player_id;





-- Verify that all three methods return identical player IDs.

WITH
in_result AS (
    SELECT DISTINCT p.player_id
    FROM players AS p
    WHERE p.player_id IN (
        SELECT mp.player_id
        FROM match_participants AS mp
        WHERE mp.score >= 1000
    )
),
cte_result AS (
    WITH high_score_players AS (
        SELECT player_id
        FROM match_participants
        WHERE score >= 1000
    )
    SELECT DISTINCT p.player_id
    FROM players AS p
    JOIN high_score_players AS hsp
        ON hsp.player_id = p.player_id
),
exists_result AS (
    SELECT p.player_id
    FROM players AS p
    WHERE EXISTS (
        SELECT 1
        FROM match_participants AS mp
        WHERE mp.player_id = p.player_id
          AND mp.score >= 1000
    )
),
differences AS (
    (SELECT player_id FROM in_result
     EXCEPT
     SELECT player_id FROM cte_result)

    UNION ALL

    (SELECT player_id FROM cte_result
     EXCEPT
     SELECT player_id FROM in_result)

    UNION ALL

    (SELECT player_id FROM in_result
     EXCEPT
     SELECT player_id FROM exists_result)

    UNION ALL

    (SELECT player_id FROM exists_result
     EXCEPT
     SELECT player_id FROM in_result)
)
SELECT *
FROM differences
ORDER BY player_id;



I answered the same question using three SQL approaches: an `IN` subquery, a common table expression (CTE), 
and a correlated `EXISTS` subquery. Each query identifies players who have at least one participation with a score of 1000 or higher.
I used `DISTINCT` where needed to avoid duplicate player IDs. To verify equivalence, I compared the result sets in both directions using `EXCEPT`.
An empty difference result means the three approaches return identical player IDs.
One important SQL caveat is that `NOT IN` can behave unexpectedly when its subquery contains NULL values, because comparisons with NULL can evaluate to UNKNOWN.


  
