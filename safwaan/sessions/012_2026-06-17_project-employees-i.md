# Session: Project Employees I (LC #1075) — 2026-06-17

## What He Attempted
```sql
SELECT p.project_id, ROUND(AVG(e.experience_years), 2) AS average_years
FROM project AS p
INNER JOIN employee AS e ON p.employee_id = e.employee_id
GROUP BY p.project_id;
```
First attempt. Accepted 8/8.

## Where He Got Stuck
Nowhere — reasoned through the full approach verbally before writing: join type, condition, grouping, aggregation. No wrong turns.

## Mistakes Made
None. First clean solve with GROUP BY included pre-emptively, no runtime error needed.

## Key Insight
AVG on an integer column in Postgres returns numeric automatically — unlike SUM(int)/SUM(int) which stays integer. So ROUND(AVG(int_col), 2) works without ::numeric. This is the first time this distinction was made explicit.

## Complexity / Correctness Notes
O(n) over joined rows. INNER JOIN correct because experience_years is NOT NULL and the foreign key guarantees every project employee exists in Employee.

## Coach Notes for Next Session
- GROUP BY included first try without runtime error — this is the first time that's happened. Note whether it holds next session.
- AVG vs SUM/SUM distinction is now on the table — probe: "does AVG always work without ::numeric?"
- No issues to carry forward from this problem.
