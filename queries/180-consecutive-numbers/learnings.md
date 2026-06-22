Session: [028_2026-06-22_consecutive-numbers](../../safwaan/sessions/028_2026-06-22_consecutive-numbers.md)

## How It Felt
Didn't know how to start — GROUP BY was the first instinct, which doesn't capture adjacency. Once the self-join pattern clicked (from LC #197), built it cleanly.

## Key Insight
To check three consecutive rows, alias the table three times and chain id offsets in the JOIN. The WHERE enforces that all three have the same value. DISTINCT handles runs of more than 3 (e.g. four consecutive 1s would produce multiple matching triplets).

## Solution Walkthrough
Think of `l1` as the starting row. `l2` is the next row (`id = l1.id + 1`), `l3` is the one after that (`id = l2.id + 1 = l1.id + 2`). The WHERE ensures all three have the same `num`. Any row that can be the start of a run of three gives a result — DISTINCT collapses duplicates.

Why not GROUP BY? Grouping collapses rows and loses their position. You can't tell if `num = 1` appeared three times consecutively or scattered across the table — you'd just see `num = 1, count = 3`.

## Pattern Introduced
Self-join for consecutive row detection — alias the table N times, chain id offsets in JOIN conditions, filter on equal values in WHERE. DISTINCT always needed since multiple starting positions for the same run produce duplicate results.

## Watch Out For
- The id offset direction: `l2.id = l1.id + 1` (l2 is one ahead of l1), not `l1.id = l2.id + 1`.
- Always add DISTINCT — a number appearing 4+ times consecutively would produce multiple result rows without it.
- This assumes `id` is truly consecutive (no gaps). If ids can have gaps, the approach breaks — you'd need a window function instead.

## Template
```sql
SELECT DISTINCT l1.num AS ConsecutiveNums
FROM Logs l1
JOIN Logs l2 ON l2.id = l1.id + 1
JOIN Logs l3 ON l3.id = l2.id + 1
WHERE l1.num = l2.num AND l2.num = l3.num;
```

## Trace Through
```
id | num
1  | 1
2  | 1
3  | 1
4  | 2
```
l1=row1, l2=row2, l3=row3: num matches (1=1=1) → ConsecutiveNums = 1
l1=row2, l2=row3, l3=row4: num doesn't match (1≠2) → no result
DISTINCT → just one row: ConsecutiveNums = 1

## Complexity / Correctness
O(n) with an index on `id`. Without an index, O(n²) or worse due to nested lookups.

## Submissions
https://leetcode.com/problems/consecutive-numbers/submissions/2038025232

## Open Questions
- How would you solve this using LAG/LEAD window functions? (Window functions phase)
