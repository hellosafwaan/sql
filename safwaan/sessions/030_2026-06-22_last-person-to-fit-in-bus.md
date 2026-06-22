# Session: Last Person to Fit in the Bus (LC #1204) — 2026-06-22

## What He Attempted
Had no idea how to start. After being taught the window function concept, built the solution:

```sql
select person_name from 
    (
        SELECT person_name, weight, turn, 
            SUM(weight) OVER (ORDER BY turn) AS running_weight
        FROM Queue
    )
where running_weight <= 1000
order by running_weight desc
limit 1;
```

## Where He Got Stuck
- No starting point — "this problem is super weird or complex to me"
- Understood the hand-simulation (running total until weight > 1000) immediately when prompted
- Didn't know window functions existed — needed the concept introduced
- Correctly knew he couldn't filter on `running_weight` in WHERE → reached for derived subquery
- Chose ORDER BY DESC LIMIT 1 cleanly once the structure was clear

## Mistakes Made
None after the concept was introduced. The logical steps were all his.

## Key Insight
Window functions (`SUM() OVER (ORDER BY turn)`) compute a running total per row without collapsing the table. Wrap in a subquery to filter on the computed column, then ORDER BY DESC LIMIT 1 to get the last valid row.

## Pattern Introduced
`SUM(col) OVER (ORDER BY col)` — running total window function. First window function encountered. Key distinction: `OVER` keeps all rows (no collapsing), unlike `GROUP BY` which reduces rows to one per group.

## Watch Out For
- Can't filter on a window function result in WHERE — must wrap in a subquery first.
- `ORDER BY` inside `OVER()` is the ordering for the running total, not the final output ordering.

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
turn | person_name | weight | running_weight
1    | A           | 300    | 300
2    | B           | 400    | 700
3    | C           | 200    | 900    ← last ≤ 1000
4    | D           | 150    | 1050   ← over limit
```
Filter WHERE ≤ 1000: A, B, C. ORDER BY running_weight DESC LIMIT 1 → C.

## Complexity / Correctness
O(n log n) due to the ORDER BY in the window function. Single table scan.

## Submissions
https://leetcode.com/problems/last-person-to-fit-in-the-bus/submissions/2042112937

## Open Questions
- What does `PARTITION BY` add to a window function? (Phase 8)
- How does `ROW_NUMBER() OVER (PARTITION BY ...)` differ from `SUM() OVER (...)`?
