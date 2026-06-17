# Session: Replace Employee ID With The Unique Identifier — 2026-06-17

## What He Attempted
```sql
select EmployeeUNI.unique_id, Employees.name
from Employees join EmployeeUNI on EmployeeUNI.id = Employees.id;
```
INNER JOIN on first attempt — correct columns, wrong join type.

## Where He Got Stuck
Didn't get stuck exactly. Ran the query, saw 3 rows instead of 5, immediately identified that Alice and Bob were missing. From there he explained LEFT JOIN correctly without prompting.

## Mistakes Made
- First instinct: INNER JOIN. Only employees with a matching record in EmployeeUNI came back.
- Fixed it himself after seeing the actual output — looked at what was missing and why.

## Key Insight
"The left side is employees. We need all the employees' data, no matter if they have a unique ID or not, so we need to do a left join."

## Complexity / Correctness Notes
No NULLs in the key column (Employees.id), so no gotchas there. The NULL passthrough is in unique_id for unmatched rows — exactly what LEFT JOIN gives.

## Coach Notes for Next Session
Anti-join instinct not yet formed — he reached for INNER JOIN first. But the LEFT JOIN click was immediate once he saw missing rows. Worth watching whether he defaults to LEFT JOIN preemptively after a few more reps.
