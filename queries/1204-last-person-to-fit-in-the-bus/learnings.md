Session: [030_2026-06-22_last-person-to-fit-in-bus](../../safwaan/sessions/030_2026-06-22_last-person-to-fit-in-bus.md)

## How It Felt
Completely stuck at first — no idea how to approach it. Once window functions were explained, the logic clicked fast and the structure came together cleanly.

## Key Insight
This is a running total problem. Board people in turn order, accumulating weight. The last person who fits is the one whose running total is still ≤ 1000.

`SUM(weight) OVER (ORDER BY turn)` computes the running total per row without collapsing the table. Each row keeps all its columns plus gets a new `running_weight` column showing the cumulative weight at that point.

Can't filter on the window function in WHERE directly — wrap the whole thing in a subquery, then filter on the outer query.

## Solution Walkthrough
The key question is: what's the cumulative weight when each person boards? If you order by turn and keep a running sum, each row tells you the total weight on the bus *after* that person boards.

`SUM(weight) OVER (ORDER BY turn)` does exactly this — it's like saying "for each row, sum all weights from turn 1 up to this row's turn." The `OVER` is what makes it a window function — without it, SUM collapses everything to one number; with `OVER (ORDER BY turn)`, it produces a running total per row.

Then: filter to rows where running_weight ≤ 1000. Among those, the last person is the one with the highest running total (ORDER BY DESC LIMIT 1).

## Pattern Introduced
Running total window function: `SUM(col) OVER (ORDER BY order_col)`. First window function seen. The difference from regular aggregates: `OVER` keeps every row intact — no collapsing. The result is a new column alongside existing data.

## Watch Out For
- Window function results can't go in WHERE — wrap in a subquery first.
- `ORDER BY` inside `OVER()` controls the running total direction, not the final output sort.
- `OVER (ORDER BY turn)` without `PARTITION BY` means one running total across the whole table. With `PARTITION BY col`, it resets per group (Phase 8).

## Template
```sql
SELECT col
FROM (
    SELECT col,
           SUM(val) OVER (ORDER BY order_col) AS running_total
    FROM table
) sub
WHERE running_total <= limit
ORDER BY running_total DESC
LIMIT 1;
```

## Trace Through
```
turn | person | weight | running_weight
1    | Marie  | 200    | 200
2    | Diana  | 500    | 700
3    | Tobias | 200    | 900
4    | Alex   | 200    | 1100  ← over limit
```
Filter ≤ 1000: Marie, Diana, Tobias. ORDER BY DESC LIMIT 1 → Tobias.

## Complexity / Correctness
O(n log n) — the window function requires sorting by turn. Single pass over the table.

## Submissions
https://leetcode.com/problems/last-person-to-fit-in-the-bus/submissions/2042112937

## Open Questions
- What does adding `PARTITION BY` do? (Phase 8)
- How would `ROW_NUMBER()` or `RANK()` OVER differ from `SUM()` OVER?
