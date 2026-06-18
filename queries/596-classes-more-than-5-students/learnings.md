Session: [021_2026-06-18_classes-5-students](../../safwaan/sessions/021_2026-06-18_classes-5-students.md)

## How It Felt
Clean solve, no friction.

## Key Insight
HAVING filters groups after aggregation. You can't put COUNT(...) >= 5 in a WHERE clause — WHERE runs before grouping, so the aggregate doesn't exist yet.

## Solution Walkthrough
Group students by class, then keep only classes where the count hits 5.

```sql
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;
```

FROM → GROUP BY collapses rows into one per class → HAVING filters to classes with 5+ students → SELECT returns class names.

## Pattern Introduced
GROUP BY + HAVING for filtering on aggregate results. (Previously applied in LC #570.)

## Watch Out For
HAVING vs WHERE: WHERE filters rows (before GROUP BY), HAVING filters groups (after GROUP BY). Aggregates like COUNT only exist after grouping, so they must live in HAVING, never WHERE.

## Template
```sql
SELECT group_col
FROM table
GROUP BY group_col
HAVING COUNT(*) >= N;
```

## Complexity / Correctness
O(n) scan + GROUP BY. COUNT(student) works since student is non-nullable here.

## Submissions
https://leetcode.com/problems/classes-with-at-least-5-students/submissions/2037682327

## Open Questions
None.
