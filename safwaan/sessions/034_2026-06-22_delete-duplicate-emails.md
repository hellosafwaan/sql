# Session: Delete Duplicate Emails — 2026-06-22

## What He Attempted
```sql
SELECT *
FROM Person AS p1
INNER JOIN Person AS p2 ON p1.email = p2.email
WHERE p2.id > p1.id;
```
Then needed syntax to convert to DELETE.

## Where He Got Stuck
Knew self-join was the tool immediately. Correctly identified the join condition (same email) and filter (p2.id > p1.id to find the higher duplicate). Stuck only on DELETE syntax — specifically, Postgres does not support `DELETE p1 FROM ... JOIN`.

## Mistakes Made
None on the logic. Postgres vs MySQL syntax was the only friction — he correctly called out "I'm in Postgres" before the wrong syntax was tried.

## Key Insight
DELETE is just SELECT in disguise — figure out which rows to delete with a SELECT first, then swap in DELETE. The Postgres `DELETE FROM ... USING` syntax is the equivalent of MySQL's multi-table DELETE.

## Complexity / Correctness Notes
Self-join on email is O(n²) in the naive case. For large tables, `DELETE WHERE id NOT IN (SELECT MIN(id) FROM Person GROUP BY email)` is cleaner and can use an index on email + id.

## Coach Notes for Next Session
DELETE ... USING syntax is new. Probe cold if another DELETE problem appears. The "write SELECT first, then convert to DELETE" heuristic is worth reinforcing.
