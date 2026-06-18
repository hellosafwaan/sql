Session: [017_2026-06-18_game-play-analysis-iv](../../safwaan/sessions/017_2026-06-18_game-play-analysis-iv.md)

## How It Felt
Came together quickly — the derived-table subquery pattern from LC #1174 transferred directly. Main friction was misreading "fraction" as "percentage" and a brief confusion on how to count total distinct players.

## Key Insight
Same two-step pattern as LC #1174, applied to a date-arithmetic problem:
1. Subquery finds each player's first login date
2. JOIN back to Activity on `player_id` AND `event_date = first_login + 1`
3. The resulting rows are players who logged in the day after their first login
4. COUNT those rows, divide by total distinct players (scalar subquery), ROUND

**Date arithmetic:** `date + 1` in Postgres adds one day. Simple and clean — no need for `INTERVAL '1 day'` in LeetCode's Postgres mode.

**Fraction vs percentage:** The output column is `fraction` — a value between 0 and 1, not multiplied by 100. Always re-read what the problem is asking for.

## Solution Walkthrough
The question: of all players, what fraction logged in on day 2 (the day after their first login)?

**Subquery:** Get each player's first login date.
```sql
SELECT player_id, MIN(event_date) AS first_login
FROM activity
GROUP BY player_id
```

**JOIN:** Match each player's Activity rows against their first_login. The WHERE clause `event_date = first_login + 1` filters to only rows where they logged in the next day. Players who didn't log in on day 2 won't have a matching row — they drop out.
```sql
FROM activity AS a
JOIN (...) AS a2 ON a.player_id = a2.player_id
WHERE a.event_date = first_login + 1
```

**Denominator:** Total distinct players = `(SELECT COUNT(DISTINCT player_id) FROM activity)`. Scalar subquery, returns one number.

**Numerator:** `COUNT(*)` — how many rows survived the WHERE filter = how many players logged in on day 2.

Put it together with `::numeric` cast to avoid integer division:
```sql
ROUND(COUNT(*)::numeric / (SELECT COUNT(DISTINCT player_id) FROM activity), 2) AS fraction
```

## Pattern
Derived-table subquery + two-condition JOIN (player_id + date offset) — second consecutive application of this pattern. Should be getting solid.

## Watch Out For
- **Fraction vs percentage**: re-read the expected output column name. `fraction` means 0–1 range; `percentage` means 0–100.
- `date + 1` works in Postgres/LeetCode for adding one day
- `COUNT(DISTINCT player_id)` not `COUNT(*) GROUP BY player_id` for total player count

## Template
```sql
-- Fraction of group members satisfying a condition on their first event
SELECT ROUND(COUNT(*)::numeric / (SELECT COUNT(DISTINCT group_id) FROM table), 2) AS fraction
FROM table AS t
JOIN (
    SELECT group_id, MIN(date_col) AS first_date
    FROM table
    GROUP BY group_id
) AS sub ON t.group_id = sub.group_id
WHERE t.date_col = first_date + 1;
```

## Complexity / Correctness
Subquery O(n). JOIN O(n). Scalar subquery O(n). Total O(n). One row per qualifying player in the WHERE result — no fan-out since primary key is (player_id, event_date).

## Submissions
- https://leetcode.com/problems/game-play-analysis-iv/submissions/2037550340

## Open Questions
*(none)*
