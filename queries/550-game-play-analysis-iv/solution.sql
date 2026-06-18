SELECT
    ROUND(
        COUNT(*)::numeric / (SELECT COUNT(DISTINCT player_id) FROM activity),
        2
    ) AS fraction
FROM activity AS a
JOIN (
    SELECT player_id, MIN(event_date) AS first_login
    FROM activity
    GROUP BY player_id
) AS a2
    ON a.player_id = a2.player_id
WHERE a.event_date = first_login + 1;
