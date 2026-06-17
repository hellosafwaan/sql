Session: [001_2026-06-17_replace-employee-id](../../safwaan/sessions/001_2026-06-17_replace-employee-id.md)

## How It Felt
First SQL problem. Reached for INNER JOIN instinctively — ran it, saw Alice and Bob missing, immediately understood why and switched to LEFT JOIN. The click was fast once real output showed up.

## Key Insight
LEFT JOIN keeps every row from the left table, even when there's no match on the right. Unmatched right-side columns come back as NULL. The question to ask is: *do I need all rows from one table regardless of whether the other table has a match?* If yes, that table goes on the left.

## Solution Walkthrough
So, we have two tables: Employees (everyone) and EmployeeUNI (only some people have a unique ID). The goal is to show every employee with their unique ID — and if they don't have one, show NULL.

If you do `Employees JOIN EmployeeUNI`, SQL only returns rows where there's a match in both tables. Alice and Bob have no unique ID, so they'd vanish.

What we want instead: start with every row in Employees, then attach the unique ID where it exists. That's exactly what `LEFT JOIN` does — it keeps all rows from the left table (Employees), and fills in NULL for anything on the right that doesn't match.

```
FROM Employees LEFT JOIN EmployeeUNI ON EmployeeUNI.id = Employees.id
```

After this join, the result looks like:
| id | name | unique_id |
|----|------|-----------|
| 1 | Alice | NULL |
| 7 | Bob | NULL |
| 11 | Meir | 2 |
| 90 | Winston | 3 |
| 3 | Jonathan | 1 |

Then SELECT just picks the two columns we want.

## Pattern Introduced
LEFT JOIN for NULL passthrough — keep all rows from the left table, get NULL on the right when there's no match.

## Watch Out For
Don't confuse "which table goes on the left" — it's the one you want ALL rows from, regardless of whether the other table has a match.

## Template
```sql
SELECT left_table.col, right_table.col
FROM left_table
LEFT JOIN right_table ON left_table.key = right_table.key;
```

## Trace Through
Employees has 5 rows. EmployeeUNI has 3 rows (ids 3, 11, 90).
After LEFT JOIN: 5 rows. Alice (id=1) and Bob (id=7) have NULL unique_id because they don't appear in EmployeeUNI.

## Complexity / Correctness
O(n) with an index on the join key. No aggregation, no NULLs in the key column itself — only in the result column for unmatched rows.

## Submissions
https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/submissions/2036241499

## Open Questions
None.
