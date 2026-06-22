# Session: Second Highest Salary — 2026-06-22

## What He Attempted
First instinct: "Do I need three self-joins?" — immediately walked back from that.

Final solution:
```sql
SELECT (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;
```

## Where He Got Stuck
Knew ORDER BY DESC was the direction. Didn't know LIMIT/OFFSET — told directly. Also didn't know how to handle the NULL case — guided to the outer SELECT scalar subquery pattern (no CASE WHEN needed; empty subquery → NULL automatically).

## Mistakes Made
Initial instinct toward self-joins was overcomplicated — redirected with one question ("how would you get the highest salary?").

## Key Insight
A scalar subquery in SELECT returns NULL automatically when the inner query produces no rows. No CASE WHEN needed — the null case is handled for free by wrapping in an outer SELECT.

## Complexity / Correctness Notes
DISTINCT handles ties at the second position correctly. LIMIT 1 OFFSET 1 after ORDER BY DESC and DISTINCT gives the true second distinct salary. O(n log n) for the sort.

## Coach Notes for Next Session
LIMIT/OFFSET pattern is now known. Scalar-subquery-in-SELECT null-handling trick is new context — probe cold next time "return null if no result" appears.
