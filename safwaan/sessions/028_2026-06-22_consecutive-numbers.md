# Session: Consecutive Numbers (LC #180) — 2026-06-22

## What He Attempted
Didn't know how to start — first instinct was GROUP BY. After being pointed toward the self-join pattern (LC #197), built the query:

```sql
select distinct l1.num as ConsecutiveNums
from logs l1
join logs l2 on l2.id = l1.id + 1
join logs l3 on l3.id = l2.id + 1
where l1.num = l2.num and l2.num = l3.num;
```

## Where He Got Stuck
- Initial instinct: GROUP BY the same nums — doesn't capture adjacency.
- Needed the prompt "think back to LC #197" to recall the self-join pattern.
- Got the id offset direction slightly wrong first (`l1.id = l2.id + 1` instead of `l2.id = l1.id + 1`) — self-corrected with one question.

## Mistakes Made
- GROUP BY as first instinct for consecutive rows — doesn't work because GROUP BY collapses rows and loses position information.
- Minor: initial join condition had the offset backwards. Caught with one question.

## Key Insight
"Three consecutive rows" → alias the table three times, chain the id offset in the JOIN condition. The WHERE enforces equal values across all three. DISTINCT handles the case where the same number appears consecutively in multiple places.

## Complexity / Correctness Notes
Triple self-join is O(n³) in the worst case, but with an index on `id` it reduces to O(n). A window function approach (LAG/LEAD) would also work and is often more readable once those are in the toolkit.

## Coach Notes for Next Session
- Self-join for consecutive rows is now introduced. Probe cold next time adjacency detection appears.
- The GROUP BY instinct for "find repeated values" is understandable but wrong here — might recur on future consecutive-row problems.
