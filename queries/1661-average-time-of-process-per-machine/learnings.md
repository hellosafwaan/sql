Session: [005_2026-06-17_average-time-of-process-per-machine](../../safwaan/sessions/005_2026-06-17_average-time-of-process-per-machine.md)

## How It Felt
Hardest problem of the session. The self-join structure came naturally, but the equal-timestamp edge case caused several wrong turns before the real fix clicked. The insight — "use the column that tells you the role, not the timestamp ordering" — was genuinely non-obvious.

## Key Insight
When you're self-joining to pair rows that play different roles (start vs end), don't use ordering to distinguish roles. Pin the roles directly using the column that already encodes them. `t1.activity_type = 'start'` and `t2.activity_type = 'end'` in the JOIN condition means the roles can never be swapped, regardless of timestamp values.

## Solution Walkthrough
The problem: for each machine, calculate the average time it takes to complete a process. Each process has exactly one 'start' row and one 'end' row in the Activity table.

To compute duration, you need both timestamps in the same row. That means self-join.

Step 1 — self-join to bring start and end together:
```
FROM activity t1 JOIN activity t2
ON t1.machine_id = t2.machine_id
AND t1.process_id = t2.process_id
```

This gives a row for every combination of rows that share machine and process. That includes (start,start), (start,end), (end,start), (end,end).

Step 2 — pin the roles in the JOIN:
```
AND t1.activity_type = 'start'
AND t2.activity_type = 'end'
```

Now t1 is always the start row and t2 is always the end row. One row per process.

Step 3 — compute average duration per machine:
```sql
SELECT t1.machine_id, ROUND(AVG(t2.timestamp - t1.timestamp)::numeric, 3) as processing_time
GROUP BY t1.machine_id
```

The `::numeric` cast is needed because PostgreSQL's ROUND doesn't accept `double precision` with a decimal-places argument directly.

## Pattern Introduced
Self-join with role pinning — when rows in a table encode a role (start/end, open/close, etc.), pin the roles in the ON condition rather than filtering after the join.

## Watch Out For
- **Equal timestamps**: if you use `t1.timestamp < t2.timestamp` instead of pinning activity_type, a process where start and end have the same timestamp gets dropped. Always use the role column when it exists.
- **`ROUND` in Postgres**: `ROUND(double precision, int)` doesn't exist. Cast to `numeric` first: `ROUND(avg(...)::numeric, 3)`.
- **`<=` trap**: switching `<` to `<=` reintroduces same-row pairing for equal-timestamp rows, breaking counts.

## Template
```sql
SELECT t1.group_col, ROUND(AVG(t2.val - t1.val)::numeric, 3) as avg_duration
FROM table t1
JOIN table t2 ON
    t1.group_col = t2.group_col AND
    t1.sub_key = t2.sub_key AND
    t1.role_col = 'start' AND
    t2.role_col = 'end'
GROUP BY t1.group_col;
```

## Trace Through
Machine 0, Process 2: start=4.14, end=4.14. Duration = 0. With `t1.timestamp < t2.timestamp` this row is dropped. With role pinning via activity_type, it's correctly included with duration 0.

## Complexity / Correctness
O(n) with indexes on (machine_id, process_id). The role pinning in the JOIN condition is both correct and more efficient than a post-join WHERE filter.

## Submissions
Accepted at 2026-06-17 17:22 (no direct link captured).

## Open Questions
None.
