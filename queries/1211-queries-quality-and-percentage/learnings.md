Session: [014_2026-06-17_queries-quality-and-percentage](../../safwaan/sessions/014_2026-06-17_queries-quality-and-percentage.md)

## How It Felt
More friction than the last few — two separate integer division issues, and the COUNT(boolean) trap came up again. CASE WHEN was introduced here for the first time, which was the key new tool.

## Key Insight
**CASE WHEN** is the standard SQL way to do conditional aggregation:
```sql
SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END)
```
This returns 1 for rows that match, 0 for rows that don't. SUM adds up the 1s — giving you a count of matching rows. It's the correct replacement for `COUNT(condition)`, which doesn't work because COUNT only checks for NULL, not false.

## Solution Walkthrough
So the problem asks for two computed metrics per query group: quality (how good the results are on average, based on rating-to-position ratio) and poor_query_percentage (how many results had a low rating).

**No JOIN needed** — the Queries table has everything. Just `FROM queries GROUP BY query_name`.

**Quality:** For each row, compute `rating / position` — but both are integers, so `5 / 2 = 2` in Postgres, not `2.5`. Cast one side: `rating::numeric / position`. Then `AVG(...)` gives the average ratio per group. Wrap in `ROUND(..., 2)`.

**Poor query percentage:** You need to count rows where `rating < 3`, then divide by total rows in the group, times 100.

First instinct was `COUNT(rating < 3)` — but COUNT only skips NULLs. `rating < 3` evaluates to TRUE or FALSE (never NULL), so COUNT counts every row regardless. Wrong.

The fix is **CASE WHEN**: `SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END)` — returns 1 for matching rows, 0 for others, SUM adds the 1s. Then divide by `COUNT(*)` for total rows, multiply by 100. Add `::numeric` to force decimal division, `ROUND(..., 2)` for output.

```sql
SELECT query_name,
       ROUND(AVG(rating::numeric / position), 2) AS quality,
       ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END)::numeric * 100 / COUNT(*), 2) AS poor_query_percentage
FROM queries
GROUP BY query_name;
```

## Pattern Introduced
- **CASE WHEN for conditional aggregation**: `SUM(CASE WHEN condition THEN 1 ELSE 0 END)` = count of rows matching condition
- Standard SQL — works in MySQL, Postgres, SQLite, everywhere. Prefer this over Postgres-specific boolean tricks.

## Watch Out For
- `COUNT(condition)` doesn't count matching rows — it counts non-NULLs, which is every row when condition is boolean. Use `SUM(CASE WHEN ...)` instead.
- `int / int` does integer division — cast with `::numeric` or multiply by `1.0`
- `AVG(int_col)` returns numeric automatically in Postgres, but `AVG(int/int)` does the integer division *before* AVG sees it — so cast inside the AVG

## Template
```sql
-- Conditional count
SUM(CASE WHEN condition THEN 1 ELSE 0 END)

-- Conditional percentage
ROUND(SUM(CASE WHEN condition THEN 1 ELSE 0 END)::numeric * 100 / COUNT(*), 2)

-- Ratio average (avoiding integer division)
ROUND(AVG(numerator::numeric / denominator), 2)
```

## Trace Through
Dog rows: (5/1=5.0, 5/2=2.5, 1/200=0.005) → AVG = 7.505/3 = 2.50
Cat rows: (2/5=0.4, 3/3=1.0, 4/7=0.571) → AVG = 1.971/3 = 0.66

Dog poor (rating<3): only Mule (rating=1) → 1/3 * 100 = 33.33
Cat poor (rating<3): only Shirazi (rating=2) → 1/3 * 100 = 33.33

## Complexity / Correctness
O(n) single pass over Queries. No joins, no subqueries. CASE WHEN evaluated per row inside the aggregation.

## Submissions
- https://leetcode.com/problems/queries-quality-and-percentage/submissions/2036720563

## Open Questions
*(none)*
