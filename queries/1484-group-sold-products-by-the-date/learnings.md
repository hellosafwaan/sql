Session: [036_2026-06-22_group-sold-products-by-the-date](../../safwaan/sessions/036_2026-06-22_group-sold-products-by-the-date.md)

## How It Felt
The grouping part was immediate. STRING_AGG was new — but once named, applying it with DISTINCT and ORDER BY was intuitive.

## Key Insight
`STRING_AGG` is the cross-row string aggregator — works like SUM but for strings. It collects all values in a group, joins them with the separator, and optionally sorts them with an ORDER BY inside the function call.

## Solution Walkthrough
Group by sell_date. Per group you need two things:
- Count of distinct products: `COUNT(DISTINCT product)`
- Alphabetically sorted comma-separated list: `STRING_AGG(DISTINCT product, ',' ORDER BY product)`

The ORDER BY inside STRING_AGG controls the order of the concatenated output — different from the outer query's ORDER BY.

```sql
SELECT sell_date,
       COUNT(DISTINCT product) AS num_sold,
       STRING_AGG(DISTINCT product, ',' ORDER BY product) AS products
FROM Activities
GROUP BY sell_date;
```

## Pattern Introduced
**String aggregation per group:** `STRING_AGG(col, separator ORDER BY col)` in Postgres.
MySQL equivalent: `GROUP_CONCAT(DISTINCT col ORDER BY col SEPARATOR ',')`

## Watch Out For
- `DISTINCT` inside STRING_AGG is Postgres-specific. MySQL's GROUP_CONCAT has its own syntax.
- The ORDER BY inside STRING_AGG is separate from the query-level ORDER BY.
- Don't confuse CONCAT (same row, multiple columns) with STRING_AGG (multiple rows, one column).

## Template
```sql
-- Per-group sorted comma-separated list (Postgres)
SELECT group_col,
       COUNT(DISTINCT value_col) AS cnt,
       STRING_AGG(DISTINCT value_col, ',' ORDER BY value_col) AS values_list
FROM table
GROUP BY group_col;
```

## Complexity / Correctness
O(n log n) — sort within each group for STRING_AGG ordering.

## Submissions
https://leetcode.com/problems/group-sold-products-by-the-date/submissions/2042256158

## Open Questions
None.
