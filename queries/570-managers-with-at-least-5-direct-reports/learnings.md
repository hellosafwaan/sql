Session: [008_2026-06-17_managers-with-at-least-5-direct-reports](../../safwaan/sessions/008_2026-06-17_managers-with-at-least-5-direct-reports.md)

## How It Felt
Got the logic right on the first try. The only friction was GROUP BY completeness (Postgres error) and a quick question about how multi-column GROUP BY works.

## Key Insight
Self-join where one alias is the manager (e1) and the other is the direct reports (e2). Joining on `e1.id = e2.managerId` pairs each manager with their reports. GROUP BY + HAVING then counts how many reports each manager has and filters to >= 5.

Multi-column GROUP BY: grouping by `(id, name)` creates groups defined by the *combination* — two managers named John with different ids stay in separate groups because their ids differ. Adding name to GROUP BY is functionally redundant here (name is determined by id) but required by Postgres.

## Solution Walkthrough
The question: which managers have at least 5 direct reports?

The Employee table has both employees and managers — it's self-referential (managerId points to another row's id). To find managers and their reports in the same query, self-join.

`e1` is the manager, `e2` is the report:
```sql
FROM employee e1
JOIN employee e2 ON e1.id = e2.managerId
```

After this join, each row has a manager (e1) paired with one of their direct reports (e2). A manager with 5 reports appears 5 times.

GROUP BY the manager, then use HAVING to filter:
```sql
GROUP BY e1.id, e1.name
HAVING count(e1.id) >= 5
```

HAVING filters *after* grouping — this is the key difference from WHERE. You can't put `count(...) >= 5` in a WHERE clause because the count doesn't exist until after the rows are grouped.

## Pattern Introduced
**HAVING** — filters groups after GROUP BY. Use it whenever your condition involves an aggregate function (COUNT, SUM, AVG, etc.).

Rule: WHERE filters rows (before grouping), HAVING filters groups (after grouping).

## Watch Out For
- GROUP BY must include all non-aggregated SELECT columns. If you SELECT `e1.name`, it must be in GROUP BY.
- `GROUP BY e1.name` alone would incorrectly merge two different managers with the same name. Always include the unique key (id).

## Template
```sql
SELECT parent.name
FROM table parent
JOIN table child ON parent.id = child.parent_id
GROUP BY parent.id, parent.name
HAVING COUNT(child.id) >= N;
```

## Trace Through
Manager 101 (John) has 5 direct reports (ids 102, 103, 104, 105, 106).
After self-join: 5 rows all with e1 = John.
After GROUP BY + HAVING count >= 5: John passes. Result: John.

## Complexity / Correctness
O(n log n) with index on managerId. COUNT(e1.id) and COUNT(*) equivalent here — e1 rows are never NULL after INNER JOIN.

## Submissions
https://leetcode.com/problems/managers-with-at-least-5-direct-reports/submissions/2036422148

## Open Questions
None.
