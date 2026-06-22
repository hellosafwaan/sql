# Session: Count Salary Categories (LC #1907) — 2026-06-22

## What He Attempted
Went straight to UNION with hardcoded category names — clean first attempt:

```sql
select 'Low Salary' as category, count(*) as accounts_count from accounts where income < 20000
union
select 'Average Salary' as category, count(*) as accounts_count from accounts where income >= 20000 and income <= 50000
union
select 'High Salary' as category, count(*) as accounts_count from accounts where income > 50000;
```

## Where He Got Stuck
Nowhere. Immediate correct approach.

## Mistakes Made
None.

## Key Insight
Three hardcoded category rows via UNION. Each SELECT returns exactly one row with the count — even if count = 0 — because COUNT(*) on an empty set returns 0, not NULL or no rows. This is why UNION works here for guaranteed output of all three categories.

## Pattern Introduced
UNION for guaranteed output rows — when the output must include fixed categories even with zero matches, hardcode each category as a separate SELECT and UNION them together. COUNT(*) on empty = 0 ensures the row always appears.

## Watch Out For
- CASE WHEN bucketing is an alternative but doesn't guarantee zero-count categories appear. UNION approach guarantees all categories are present.
- The boundary conditions: Average Salary uses `>=` and `<=`, not `>` and `<`. Don't accidentally exclude the boundary values.

## Template
```sql
SELECT 'Category A' AS category, COUNT(*) AS accounts_count FROM table WHERE condition_a
UNION
SELECT 'Category B' AS category, COUNT(*) AS accounts_count FROM table WHERE condition_b
UNION
SELECT 'Category C' AS category, COUNT(*) AS accounts_count FROM table WHERE condition_c;
```

## Complexity / Correctness
Three full table scans (one per SELECT). Could be done in a single scan with CASE WHEN + GROUP BY, but that approach would omit zero-count categories unless handled with a reference table.

## Submissions
https://leetcode.com/problems/count-salary-categories/submissions/2042119595

## Open Questions
None.
