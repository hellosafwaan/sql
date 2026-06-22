# Session: Group Sold Products By The Date — 2026-06-22

## What He Attempted
Started with:
```sql
SELECT sell_date, COUNT(*) FROM Activities GROUP BY sell_date;
```
Then tried `SELECT sell_date, DISTINCT COUNT(*)` — syntax error.

Final:
```sql
SELECT sell_date,
       COUNT(DISTINCT product) AS num_sold,
       STRING_AGG(DISTINCT product, ',' ORDER BY product) AS products
FROM Activities
GROUP BY sell_date;
```

## Where He Got Stuck
Two things: `DISTINCT` placement (goes inside the function, not between SELECT and the expression), and the string aggregation function name. Knew he needed something like CONCAT but not the cross-row aggregation function.

## Mistakes Made
`SELECT DISTINCT COUNT(*)` syntax error — DISTINCT goes inside: `COUNT(DISTINCT product)`. Knew the concept, wrong placement.

## Key Insight
STRING_AGG is the Postgres equivalent of `SUM()` but for strings — it aggregates values across rows in a group and joins them with a separator. The ORDER BY inside STRING_AGG controls the sort of the concatenated output.

## Complexity / Correctness Notes
`COUNT(DISTINCT product)` works even though (sell_date, product) is the PK — no duplicates anyway, but DISTINCT is required by the problem spec. MySQL equivalent: GROUP_CONCAT(DISTINCT product ORDER BY product SEPARATOR ',').

## Coach Notes for Next Session
STRING_AGG is new. Probe cold if another "comma-separated list per group" problem appears.
