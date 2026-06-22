# Session: Fix Names in a Table — 2026-06-22

## What He Attempted
```sql
SELECT user_id,
       CONCAT(UPPER(SUBSTRING(name, 0, 2)), LOWER(SUBSTRING(name, 2))) AS name
FROM Users
ORDER BY user_id;
```

## Where He Got Stuck
Knew UPPER/LOWER were needed but didn't know SUBSTRING by name. One prompt ("do you know a function that extracts a substring given a start and length?") was enough — he immediately assembled the CONCAT pattern himself.

## Mistakes Made
Used `SUBSTRING(name, 0, 2)` instead of `SUBSTRING(name, 1, 1)`. Works in MySQL (position 0 is a quirk that returns 1 character when length is 2), but not portable. Noted and flagged.

## Key Insight
Once he had SUBSTRING, he independently composed: first letter → UPPER, rest → LOWER, wrap in CONCAT. Didn't need to be told the structure.

## Complexity / Correctness Notes
Purely row-level transformation — no GROUP BY, no JOIN. O(n) scan. The SUBSTRING(0,2) quirk is MySQL-specific; standard is SUBSTRING(1,1).

## Coach Notes for Next Session
SUBSTRING syntax is now known. Watch for SUBSTRING(0,...) vs SUBSTRING(1,...) on future string problems.
