# Session: Employee Bonus — 2026-06-17

## What He Attempted
```sql
select employee.name, bonus.bonus
from employee
left join bonus on employee.empId = bonus.empId
where bonus.bonus < 1000 or bonus.empId is null;
```
Correct on first attempt.

## Where He Got Stuck
Nowhere.

## Mistakes Made
None. Used `bonus.empId IS NULL` rather than `bonus.bonus IS NULL` — both correct, but `bonus.bonus IS NULL` is more direct since that's the column being selected.

## Key Insight
Anti-join pattern applied automatically without prompting — third time seeing it this session. "Employee left joins with bonus. If there's no match, the bonus side is NULL. We use that NULL to catch the no-bonus employees, and the `< 1000` catches the low-bonus ones."

## Complexity / Correctness Notes
Same LEFT JOIN + NULL check pattern as LC #1581. The OR condition combines two cases: no bonus at all (NULL) and low bonus (< 1000).

## Coach Notes for Next Session
Anti-join is solidly internalized — applied correctly and immediately on a problem that didn't explicitly state "some employees have no bonus record." Pattern recognition is working.
