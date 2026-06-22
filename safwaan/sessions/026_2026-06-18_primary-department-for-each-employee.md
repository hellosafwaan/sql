# Session: Primary Department for Each Employee (LC #1789) — 2026-06-18

## What He Attempted
Correctly identified two cases immediately: (1) employees with primary_flag = 'Y', and (2) employees belonging to only one department. Knew to combine with UNION.

First case 1 draft had unnecessary GROUP BY + COUNT:
```sql
select employee_id, count(department_id) from employee where primary_flag = 'Y' group by employee_id;
```

After correction, combined with case 2:
```sql
select 
	employee_id, min(department_id) as department_id
from 
	employee
group by 
	employee_id
having 
	count(department_id) = 1
union
select 
	employee_id, department_id
from 
	employee
where
	primary_flag = 'Y';
```

## Where He Got Stuck
- Case 1: Added GROUP BY + COUNT unnecessarily. Just needed `WHERE primary_flag = 'Y'`.
- Case 2: Initially tried to put the COUNT filter in WHERE — needed to be reminded that aggregates go in HAVING.
- Tried to SELECT department_id without GROUP BY, didn't know the Postgres restriction.
- UNION vs UNION ALL: didn't remember the difference.

## Mistakes Made
- Case 1 wrote `count(department_id)` in SELECT and added GROUP BY — no aggregation needed, just a simple WHERE filter.
- Confused WHERE vs HAVING for case 2 — needed the reminder that WHERE runs before grouping.
- Didn't know in Postgres you can't SELECT a non-GROUP BY column without aggregating it — `MIN(department_id)` is the workaround when HAVING guarantees one row per group.

## Key Insight
Two-case OR logic → UNION. When the problem says "return X OR Y (but not both)", split it into two clean selects and UNION them. The reason to use UNION over UNION ALL is that a single-department employee whose flag is 'Y' would appear in both queries — UNION deduplicates.

## Complexity / Correctness Notes
UNION scans the table twice, UNION ALL once (plus dedup). For this data size it doesn't matter. If you knew single-department employees always have primary_flag = 'N', UNION ALL would be safe and slightly faster.

## Coach Notes for Next Session
- UNION vs UNION ALL: got it right when prompted about the overlap. Probe cold next time UNION appears.
- WHERE vs HAVING: needed a reminder. Not a new pattern — should be automatic. One more rep needed.
- The `MIN(col)` workaround for Postgres non-GROUP-BY column restriction: new this session. Probe cold next time this shape appears.
