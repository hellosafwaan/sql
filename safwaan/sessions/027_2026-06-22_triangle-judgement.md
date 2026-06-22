# Session: Triangle Judgement (LC #610) — 2026-06-22

## What He Attempted
Clean first attempt — CASE WHEN applied independently with all three triangle conditions correct:

```sql
select x, y, z,
    case
        when x + y > z and y + z > x and z + x > y then 'Yes'
        else 'No'
    end as triangle
from triangle;
```

## Where He Got Stuck
Didn't remember the triangle inequality rule off the top of his head — needed it stated. Once told, wrote the query without any further prompting.

## Mistakes Made
None. Clean solve.

## Key Insight
Row-level conditional logic with no joins or aggregation needed — CASE WHEN is the only tool required. The output is one row per input row with an extra derived column.

## Complexity / Correctness Notes
O(n) single scan. No grouping, no joins. As simple as SQL gets for conditional labeling.

## Coach Notes for Next Session
CASE WHEN is solid — applied independently and correctly. No follow-up needed.
