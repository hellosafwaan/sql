# Session: Average Time of Process per Machine — 2026-06-17

## What He Attempted
First attempt:
```sql
select t1.machine_id, avg(t2.timestamp - t1.timestamp) as processing_time
from activity t1
join activity t2 on t1.machine_id = t2.machine_id and t1.process_id = t2.process_id
where t1.timestamp < t2.timestamp
group by t1.machine_id;
```
Correct logic but `avg()` returned too many decimal places — needed `ROUND`.

Then hit a PostgreSQL type error: `round(double precision, integer)` doesn't exist. Needed `::numeric` cast.

Then hit a wrong answer: `t1.timestamp < t2.timestamp` excluded a valid process where start and end timestamps were equal (both 4.14).

Tried `<=` — broke everything (paired same row with itself for equal-timestamp rows).

Final correct solution: pin roles via `activity_type` directly in the JOIN condition, drop WHERE entirely.

## Where He Got Stuck
The equal-timestamp edge case. Went through `<` → `<=` → `OR` before being guided to look at what column already encodes the role of each row.

## Mistakes Made
1. `ROUND` without `::numeric` cast — Postgres type error.
2. `timestamp < t2.timestamp` — excluded valid zero-duration processes.
3. `<=` — reintroduced same-row pairing.
4. Tried `OR` combining `<` and `=` — equivalent to `<=`, same problem.

## Key Insight
"When you have a column that tells you what a row is, use it directly. Don't infer role from ordering when the data already tells you." Pinning `t1.activity_type = 'start'` and `t2.activity_type = 'end'` in the JOIN condition made the timestamp comparison unnecessary entirely.

## Complexity / Correctness Notes
Self-join where role disambiguation via ordering is fragile. The robust pattern: use the enum/type column to pin which alias is which, directly in the ON clause. Also: `ROUND(avg(...)::numeric, 3)` is the correct Postgres idiom for rounding a float aggregate to N decimal places.

## Coach Notes for Next Session
This was the hardest problem of the session. The "use the column that tells you the role" insight is genuinely non-obvious — took several wrong turns before landing. Worth revisiting to see if it sticks. Also: Postgres type casting (::numeric) is now on his radar.
