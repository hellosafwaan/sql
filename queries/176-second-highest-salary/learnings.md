Session: [035_2026-06-22_second-highest-salary](../../safwaan/sessions/035_2026-06-22_second-highest-salary.md)

## How It Felt
First instinct was way overcomplicated (three self-joins). Once redirected to ORDER BY + LIMIT/OFFSET, the logic clicked immediately. The null-handling trick was new.

## Key Insight
`LIMIT 1 OFFSET 1` on a DESC-ordered distinct salary list gives you the second highest. Wrapping in an outer SELECT means the whole thing returns NULL automatically when there's no second row — no CASE WHEN needed.

## Solution Walkthrough
Sort distinct salaries descending: `ORDER BY salary DESC`. Skip the first (highest) with `OFFSET 1`. Take the next with `LIMIT 1`. That's the second highest.

Why the outer SELECT? If there's only one distinct salary, the inner query returns no rows. A `SELECT` with no rows produces nothing — not NULL. But a *scalar subquery* used as a column value in an outer SELECT returns NULL when it's empty. So wrapping it in `SELECT (...) AS SecondHighestSalary` handles the null case for free.

```sql
SELECT (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;
```

## Pattern Introduced
**LIMIT/OFFSET for Nth row:** `ORDER BY col DESC LIMIT 1 OFFSET N-1` gives the Nth highest.
**Scalar subquery null passthrough:** wrap in outer SELECT to get NULL instead of empty result set.

## Watch Out For
- `LIMIT 1 OFFSET 1` skips 1 row (0-indexed offset), giving the 2nd row. For Nth highest: `OFFSET N-1`.
- Without `DISTINCT`: if two employees share the highest salary, OFFSET 1 skips one of them — not the highest value. Always use DISTINCT when the question says "second highest distinct salary."

## Template
```sql
-- Nth highest salary with null handling
SELECT (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET N-1
) AS NthHighestSalary;
```

## Complexity / Correctness
O(n log n) for the sort. DISTINCT requires a dedup pass first.

## Submissions
https://leetcode.com/problems/second-highest-salary/submissions/2042227831

## Open Questions
None.
