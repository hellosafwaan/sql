Session: [031_2026-06-22_count-salary-categories](../../safwaan/sessions/031_2026-06-22_count-salary-categories.md)

## How It Felt
Immediate — went straight to UNION with hardcoded categories. Cleanest first attempt of the session.

## Key Insight
When the output must include fixed categories (even with zero matches), hardcode each category as a separate SELECT and UNION them. COUNT(*) on an empty set returns 0 — not NULL, not "no row" — so each SELECT always produces exactly one output row.

## Solution Walkthrough
Three categories, three SELECTs. Each one filters to its salary range and counts. UNION stacks them into a single result. The neat trick: if no accounts fall in a category, the WHERE produces no input rows but COUNT(*) still returns 0 — so that category row appears with accounts_count = 0. You can't lose a category this way.

A CASE WHEN approach (`SELECT CASE WHEN income < 20000 THEN 'Low' ... END, COUNT(*) GROUP BY category`) would also work, but zero-count categories would silently disappear from the output unless you had a reference table to LEFT JOIN against.

## Pattern Introduced
UNION for guaranteed output categories — hardcode category names in each SELECT, let COUNT(*) handle the zero case automatically.

## Watch Out For
- Boundary values: Average Salary is `>= 20000 AND <= 50000`. Using strict `>` or `<` would exclude people earning exactly 20000 or 50000.
- CASE WHEN + GROUP BY loses zero-count categories — use UNION when all categories must appear.

## Template
```sql
SELECT 'Category A' AS category, COUNT(*) AS cnt FROM t WHERE <condition_a>
UNION
SELECT 'Category B' AS category, COUNT(*) AS cnt FROM t WHERE <condition_b>
UNION
SELECT 'Category C' AS category, COUNT(*) AS cnt FROM t WHERE <condition_c>;
```

## Complexity / Correctness
Three full table scans. Fine for this size; for very large tables a single CASE WHEN scan with a reference table join would be more efficient.

## Submissions
https://leetcode.com/problems/count-salary-categories/submissions/2042119595

## Open Questions
None.
