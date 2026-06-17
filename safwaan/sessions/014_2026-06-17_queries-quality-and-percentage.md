# Session: Queries Quality and Percentage (LC #1211) — 2026-06-17

## What He Attempted
**Attempt 1:**
```sql
SELECT query_name, AVG(rating/position) AS quality,
       COUNT(rating < 3) * 100 / COUNT(*) AS poor_query_percentage
FROM queries
GROUP BY query_name;
```
Two bugs: integer division in rating/position; COUNT(boolean) counts all rows.

**Attempt 2 (after CASE WHEN introduced):**
```sql
SELECT query_name, AVG(rating/position) AS quality,
       ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS poor_query_percentage
FROM queries
GROUP BY query_name;
```
quality still wrong (integer division in AVG arg); poor_query_percentage still integer division.

**Attempt 3 (::numeric on AVG arg):**
```sql
SELECT query_name, ROUND(AVG(rating::numeric/position), 2) AS quality,
       ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS poor_query_percentage
FROM queries
GROUP BY query_name;
```
quality fixed; poor_query_percentage still truncating (33 vs 33.33).

**Attempt 4 → Accepted:**
```sql
SELECT query_name,
       ROUND(AVG(rating::numeric / position), 2) AS quality,
       ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END)::numeric * 100 / COUNT(*), 2) AS poor_query_percentage
FROM queries
GROUP BY query_name;
```

## Where He Got Stuck
1. **COUNT(boolean)** — didn't remember the trap from LC #1934. Unblocked by explaining COUNT only checks NULL. CASE WHEN introduced here.
2. **Integer division in AVG** — `AVG(int/int)` does integer math before AVG. Prompted with the `::numeric` fix (third encounter).
3. **Integer division in percentage** — `SUM(int) * 100 / COUNT(*)` still integer. Applied `::numeric` cast himself this time.

## Mistakes Made
- COUNT(condition) trap — second encounter (first was LC #1934), still not recalled
- `AVG(int/int)` integer division — new variant of the ::numeric pattern
- SUM(int) * 100 / COUNT(*) integer division — fixed with `::numeric` independently

## Key Insight
CASE WHEN is the standard SQL tool for conditional aggregation. `SUM(CASE WHEN condition THEN 1 ELSE 0 END)` counts matching rows correctly. Works everywhere — not Postgres-specific.

## Complexity / Correctness Notes
O(n) single table scan. CASE WHEN evaluated per row inside the SUM aggregation.

## Coach Notes for Next Session
- CASE WHEN introduced and used correctly — probe cold on next conditional aggregation problem.
- ::numeric cast applied independently on the SUM this time — slight improvement. Still needed prompting for the AVG(int/int) variant. 
- COUNT(boolean) trap: second encounter, still not recalled. Needs one more rep before it's automatic.
- GROUP BY included correctly without prompting — third consecutive clean rep. Solid now.
