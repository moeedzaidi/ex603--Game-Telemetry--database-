-- Q5.1.1: Show which player performed each event,
-- which match produced it, and when the event occurred.

SELECT
    p.player_id,
    p.player_name AS actor,
    m.match_id,
    m.match_label AS producer,
    mp.participation_id AS event_id,
    mp.joined_at AS event_date_time
FROM players p
INNER JOIN match_participants mp
    ON p.player_id = mp.player_id
INNER JOIN matches m
    ON mp.match_id = m.match_id
ORDER BY mp.joined_at;




SELECT
    mode_id,
    mode_name,
    mode_description
FROM game_modes
ORDER BY mode_id;




-- Q5.1.2: Find producers associated with the selected game-mode tag.

SELECT
    m.match_id,
    m.match_label AS producer,
    gm.mode_id,
    gm.mode_name AS catalog_tag,
    mm.enabled_on
FROM matches m
INNER JOIN match_modes mm
    ON m.match_id = mm.match_id
INNER JOIN game_modes gm
    ON mm.mode_id = gm.mode_id
WHERE gm.mode_name = 'REPLACE_WITH_YOUR_THEME_TAG'
ORDER BY m.match_id;





-- Q5.1.3: Compare producers with other producers
-- using ranked status, player count, and event activity.

WITH producer_activity AS (
    SELECT
        m.match_id,
        m.match_label,
        m.server_region,
        m.player_count,
        m.is_ranked,
        COUNT(mp.participation_id) AS event_count
    FROM matches m
    LEFT JOIN match_participants mp
        ON m.match_id = mp.match_id
    GROUP BY
        m.match_id,
        m.match_label,
        m.server_region,
        m.player_count,
        m.is_ranked
)
