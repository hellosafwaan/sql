Session: [026_2026-06-18_primary-department-for-each-employee](../../safwaan/sessions/026_2026-06-18_primary-department-for-each-employee.md)

## How It Felt
Identified the two-case structure quickly. The path to the actual SQL was bumpy — confused WHERE vs HAVING for the count filter, added an unnecessary GROUP BY to case 1, and didn't remember UNION vs UNION ALL. But the high-level logic was correct from the start.

## Key Insight
When a problem has two distinct conditions for selecting the "right" row, split them into two queries and UNION. Case 1 is a simple filter (`primary_flag = 'Y'`). Case 2 is an aggregate filter (only one department per employee). You can't express both cleanly in a single WHERE or HAVING — UNION is the natural tool.

Use UNION (not UNION ALL) because a single-department employee whose flag is also 'Y' would appear in both result sets — UNION deduplicates.

## Solution Walkthrough
Two types of "primary" department:
1. Explicitly flagged: `primary_flag = 'Y'` — just filter rows directly.
2. Implicit (only one department): group by employee_id, keep groups where COUNT = 1.

For case 2, you need `MIN(department_id)` in the SELECT (not bare `department_id`) because Postgres requires all selected columns to be either in GROUP BY or aggregated. Since HAVING COUNT = 1 guarantees exactly one department per group, MIN just returns that one value.

UNION combines both result sets and handles the edge case where both conditions apply to the same employee.

## Pattern Introduced
UNION for two-case conditional selection — when the output logic has two mutually distinct paths, write two queries and UNION them.

## Watch Out For
- UNION vs UNION ALL: UNION deduplicates, UNION ALL keeps all rows including duplicates. When there's overlap between your two result sets, use UNION.
- Case 1 doesn't need GROUP BY — it's just a WHERE filter. Adding GROUP BY + COUNT is unnecessary extra work.
- In Postgres, you can't SELECT a column that's not in GROUP BY without wrapping it in an aggregate. `MIN(department_id)` is the standard workaround when HAVING guarantees a single value per group.
- WHERE filters before grouping; HAVING filters after. COUNT-based filters always go in HAVING.

## Template
```sql
-- Case 2: single-department employees
SELECT employee_id, MIN(department_id) AS department_id
FROM employee
GROUP BY employee_id
HAVING COUNT(department_id) = 1

UNION

-- Case 1: explicitly flagged primary
SELECT employee_id, department_id
FROM employee
WHERE primary_flag = 'Y';
```

## Trace Through
Sample data:
```
employee_id | department_id | primary_flag
1           | 1             | N            ← only one dept
2           | 1             | Y            ← flagged primary
2           | 2             | N
3           | 3             | N            ← only one dept, flag is N
```
Case 2 (COUNT = 1): employees 1 and 3
Case 1 (flag = 'Y'): employee 2, department 1
UNION result:
```
employee_id | department_id
1           | 1
2           | 1
3           | 3
```

## Complexity / Correctness
Two full table scans (one per SELECT in the UNION). UNION dedup adds a sort/hash step — UNION ALL would be one pass cheaper if you could prove no overlap, but you generally can't without domain knowledge.

## Submissions
https://leetcode.com/problems/primary-department-for-each-employee/submissions/2037818251

## Open Questions
- Could this be solved with a single query using CASE WHEN or window functions instead of UNION?
