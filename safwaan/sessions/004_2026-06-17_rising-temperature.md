# Session: Rising Temperature — 2026-06-17

## What He Attempted
```sql
select t2.id
from weather t1
join weather t2 on t2.recordDate = t1.recordDate + 1
where t2.temperature > t1.temperature;
```
Correct on first attempt.

## Where He Got Stuck
Didn't get stuck. Immediately recognized self-join, used aliases correctly. Asked for help explaining the concept after solving — wanted to articulate it clearly.

## Mistakes Made
None conceptually. Flagged: `recordDate + 1` works in MySQL but on real Postgres should be `recordDate + INTERVAL '1 day'`.

## Key Insight
"Imagine the database physically duplicating the table — t1 and t2 are two copies with identical data. The JOIN condition pairs each row in t1 with the row in t2 that is exactly one day later. Then the WHERE keeps only pairs where the later day was warmer."

## Complexity / Correctness Notes
Self-join on date offset. The date arithmetic `+ 1` is MySQL shorthand; Postgres requires `+ INTERVAL '1 day'`. LeetCode accepted `+ 1` in PostgreSQL mode for this problem.

## Coach Notes for Next Session
Self-join concept clicked fast. Will encounter it again in the next problem (LC #1661) with a harder pairing condition.
