# Session: Classes More Than 5 Students — 2026-06-18

## What He Attempted
Submitted directly: GROUP BY class + HAVING COUNT(student) >= 5. No coaching needed.

## Where He Got Stuck
Nowhere.

## Mistakes Made
None.

## Key Insight
HAVING filters groups after aggregation. WHERE would filter rows before grouping — can't use it with a COUNT condition.

## Complexity / Correctness Notes
COUNT(student) works here since student is part of the primary key (non-nullable). COUNT(*) would also be fine.

## Coach Notes for Next Session
Nothing to flag.
