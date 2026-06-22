Session: [025_2026-06-18_number-of-employees-reporting](../../safwaan/sessions/025_2026-06-18_number-of-employees-reporting.md)

## How It Felt
Came in with the derived-table approach fully formed. The only hiccup was FLOOR vs ROUND — asked what FLOOR does, swapped it, passed first try.

## Key Insight
The derived table builds a per-manager summary (count, average age), then the outer JOIN pulls the manager's name. The subquery needs `WHERE reports_to IS NOT NULL` to exclude employees with no manager, otherwise they appear as a "manager" of nobody.

Alternative that skips the subquery entirely — self-join directly:
```sql
SELECT m.employee_id, m.name, COUNT(e.employee_id) AS reports_count, ROUND(AVG(e.age)) AS average_age
FROM Employees m
INNER JOIN Employees e ON e.reports_to = m.employee_id
GROUP BY m.employee_id, m.name
ORDER BY m.employee_id;
```
Join every manager row to all its reportee rows, group by manager, aggregate. Same result, fewer moving parts. The `WHERE reports_to IS NOT NULL` from the original is handled implicitly — employees with no reportees just produce no matching rows in the INNER JOIN.

## Solution Walkthrough
So the question is: for every employee who manages someone, show their id, name, how many direct reports they have, and the average age of those reports.

Start from the reportees' perspective: group `Employees` by `reports_to` and COUNT/AVG. That gives you the manager's id, their report count, and average age. But you need the manager's name — that lives in the same `Employees` table. So JOIN back on `employee_id`.

The WHERE in the subquery (`reports_to IS NOT NULL`) is critical — it filters out top-level employees who don't report to anyone, so they don't show up as phantom managers.

## Pattern Introduced
Self-join disguised as derived-table: same table appears twice, once for the manager role, once for the reportee role. A direct self-join is the cleaner form.

## Watch Out For
- `FLOOR` ≠ `ROUND`. FLOOR always rounds down. ROUND rounds to nearest.
- The `WHERE reports_to IS NOT NULL` filter. Without it, employees with NULL reports_to would be treated as a manager of "nobody."

## Template
```sql
-- Direct self-join form (cleaner)
SELECT m.employee_id, m.name,
       COUNT(e.employee_id) AS reports_count,
       ROUND(AVG(e.age)) AS average_age
FROM Employees m
INNER JOIN Employees e ON e.reports_to = m.employee_id
GROUP BY m.employee_id, m.name
ORDER BY m.employee_id;
```

## Trace Through
Sample data:
```
employee_id | name    | reports_to | age
1           | Michael | null       | 45
2           | Alice   | 1          | 38
3           | Bob     | 1          | 42
```
After JOIN (m=manager, e=reportee):
```
m.employee_id | m.name  | e.employee_id | e.age
1             | Michael | 2             | 38
1             | Michael | 3             | 42
```
After GROUP BY + aggregate:
```
employee_id | name    | reports_count | average_age
1           | Michael | 2             | 40
```

## Complexity / Correctness
O(n) scan for both approaches. Direct self-join reads the table twice; derived-table approach also reads it twice (subquery + outer join). Effectively identical. With an index on `reports_to`, the self-join version can be faster on large tables.

## Submissions
https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/submissions/2037776247

## Open Questions
- Can you write this without any subquery using a direct self-join? (answered — yes, shown above)
