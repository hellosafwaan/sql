Session: [006_2026-06-17_employee-bonus](../../safwaan/sessions/006_2026-06-17_employee-bonus.md)

## How It Felt
Easy. Third application of the anti-join pattern in the same session — applied it correctly and immediately without any prompting.

## Key Insight
The anti-join pattern applied again: some employees have no entry in Bonus. LEFT JOIN exposes them as NULLs. The WHERE combines two cases: no bonus at all (`bonus.empId IS NULL`) and low bonus (`bonus.bonus < 1000`).

## Solution Walkthrough
We want every employee whose bonus is under 1000 — including employees who have no bonus record at all.

If we INNER JOIN Employee with Bonus, employees with no bonus record get dropped entirely. So we LEFT JOIN.

After the LEFT JOIN, employees with no bonus have NULL in all Bonus columns. The WHERE condition:
```sql
WHERE bonus.bonus < 1000 OR bonus.empId IS NULL
```

catches both cases:
- `bonus.bonus < 1000` → employee has a bonus, but it's small
- `bonus.empId IS NULL` → employee has no bonus record at all

Note: `bonus.bonus IS NULL` would work equally well instead of `bonus.empId IS NULL` — whichever column from the right table you check, NULL means no match.

## Pattern Introduced
Anti-join with an additional filter — LEFT JOIN + (right_col IS NULL OR right_col < threshold).

## Watch Out For
NULL comparisons: `bonus.bonus < 1000` is FALSE when bonus is NULL (not TRUE). That's why you need the separate `OR bonus.empId IS NULL` clause to catch the no-bonus employees.

## Template
```sql
SELECT l.col, r.col
FROM left_table l
LEFT JOIN right_table r ON l.key = r.key
WHERE r.val < threshold OR r.key IS NULL;
```

## Trace Through
After LEFT JOIN: Brad (no bonus → NULL), John (no bonus → NULL), Dan (bonus=500), Thomas (bonus=2000).
After WHERE: Brad (NULL), John (NULL), Dan (500 < 1000). Thomas (2000) excluded.

## Complexity / Correctness
O(n) with index on empId.

## Submissions
https://leetcode.com/problems/employee-bonus/submissions/2036337714

## Open Questions
None.
