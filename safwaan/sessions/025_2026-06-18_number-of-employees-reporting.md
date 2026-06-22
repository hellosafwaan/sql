# Session: The Number of Employees Which Report to Each Employee (LC #1731) — 2026-06-18

## What He Attempted
Identified the problem as needing a derived table: subquery to get reports_count and average_age per manager, then JOIN back to Employees to get the manager's name.

```sql
select
	managers.employee_id, employees.name, managers.reports_count, managers.average_age
from
	employees
		inner join 
			(
				select 
					reports_to as employee_id, count(*) as reports_count, floor(avg(age)) as average_age
				from 
					Employees
				where 
					reports_to is not null
				group by 
					reports_to
			) as managers
		on managers.employee_id = employees.employee_id
order by managers.employee_id asc;
```

## Where He Got Stuck
Used `FLOOR` instead of `ROUND`. Needed to ask what FLOOR does — didn't know the difference.

## Mistakes Made
- `FLOOR(avg(age))` — FLOOR always rounds down, not to nearest integer. `ROUND` is the correct function here.

## Key Insight
The derived-table approach came fully independently — subquery handles aggregation per manager, JOIN back on employee_id pulls the name. Pattern is now deeply internalized after 4 applications (#1174, #550, #1070, #1731).

Worth noting: this problem has a cleaner direct self-join formulation:
```sql
SELECT m.employee_id, m.name, COUNT(e.employee_id) AS reports_count, ROUND(AVG(e.age)) AS average_age
FROM Employees m
INNER JOIN Employees e ON e.reports_to = m.employee_id
GROUP BY m.employee_id, m.name
ORDER BY m.employee_id;
```
Join the manager copy to the reportee copy via `reports_to = manager.employee_id`, group by manager, aggregate. Skips the subquery entirely — same result, fewer moving parts.

## Complexity / Correctness Notes
Both approaches are O(n) for the aggregation scan. The direct self-join is slightly more readable and avoids the subquery indirection. Either works.

## Coach Notes for Next Session
- FLOOR vs ROUND now explicit — should not recur.
- Derived-table pattern is fully automatic. Stop probing.
- Probe the direct self-join approach cold eventually — "can you write this without a subquery?"
