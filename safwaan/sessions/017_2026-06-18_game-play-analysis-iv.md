# Session: Game Play Analysis IV (LC #550) — 2026-06-18

## What He Attempted
**Attempt 1 (wrong denominator):**
```sql
SELECT COUNT(*) / (SELECT COUNT(*) FROM activity GROUP BY player_id) * 100 ...
-- COUNT(*) GROUP BY player_id returns multiple rows, not a scalar
```

**Attempt 2 (fixed denominator, missing ::numeric, had * 100):**
```sql
SELECT ROUND(COUNT(*) / (SELECT COUNT(DISTINCT player_id) FROM activity) * 100, 2) ...
-- Integer division → 0; also * 100 wrong (fraction not percentage)
```

**Attempt 3 → Accepted:**
```sql
SELECT ROUND(COUNT(*)::numeric / (SELECT COUNT(DISTINCT player_id) FROM activity), 2) AS fraction
FROM activity AS a
JOIN (SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id) AS a2
    ON a.player_id = a2.player_id
WHERE a.event_date = first_login + 1;
```

## Where He Got Stuck
1. **Wrong total count** — used `COUNT(*) GROUP BY player_id` (returns per-player counts) instead of `COUNT(DISTINCT player_id)` (one total). Corrected after prompting.
2. **Fraction vs percentage** — multiplied by 100 initially; caught from wrong output (33.33 vs 0.33).
3. **::numeric** — applied independently this time without prompting. Progress.

## Mistakes Made
- `COUNT(*) GROUP BY` as subquery — returns multiple rows, not a scalar
- Misread output format (fraction not percentage)
- Integer division — caught himself and applied ::numeric fix independently

## Key Insight
Same pattern as LC #1174: subquery gets first event per player, JOIN back on player + date offset, count survivors, divide by total. Second application — pattern is solidifying.

## Complexity / Correctness Notes
O(n). Primary key (player_id, event_date) guarantees one row per player per date — no duplicate matches in the JOIN.

## Coach Notes for Next Session
- **::numeric applied independently** — first time without prompting. Call this solidifying. One more clean rep and it's solid.
- Derived-table subquery pattern applied correctly on second use — transferring well from LC #1174.
- COUNT(DISTINCT ...) vs COUNT(*) for unique counts — probe on next "total distinct X" need.
- Fraction vs percentage — always probe: "what does the expected output column name say?"
