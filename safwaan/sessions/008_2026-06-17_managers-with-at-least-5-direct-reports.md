# Session: Managers with at Least 5 Direct Reports — 2026-06-17

## What He Attempted
```sql
select e1.id from employee e1
join employee e2 on e1.id = e2.managerId
group by e1.id
having count(e1.id) >= 5;
```
Correct structure first try. Didn't know how to get the name, then added `e1.name` to SELECT but forgot GROUP BY.

Final solution:
```sql
select e1.name
from employee e1
join employee e2 on e1.id = e2.managerId
group by e1.id, e1.name
having count(e1.id) >= 5;
```

## Where He Got Stuck
GROUP BY completeness again — Postgres runtime error told him directly. Fixed immediately.

## Mistakes Made
- `SELECT e1.name` without adding `e1.name` to GROUP BY — Postgres error caught it.

## Key Insight
Good conversation about multi-column GROUP BY: grouping by `(id, name)` creates groups defined by the *combination* of both columns. Two managers named "John" with different ids stay separate. Also landed on the insight that `e1.name` in GROUP BY is functionally redundant (since name is determined by id) but required by Postgres's strict mode.

Also first explicit encounter with HAVING — filtering on an aggregate after grouping.

## Complexity / Correctness Notes
Self-join where e2 is the direct reports and e1 is the manager. HAVING count >= 5 filters after grouping. COUNT(e1.id) and COUNT(*) are equivalent here since e1.id is never NULL after the join.

## Coach Notes for Next Session
GROUP BY completeness error occurred again — same as LC #1280. Pattern is not yet automatic. Has now hit it twice in the same session; should become reflex soon.
