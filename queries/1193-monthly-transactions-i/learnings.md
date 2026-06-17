Session: [015_2026-06-18_monthly-transactions-i](../../safwaan/sessions/015_2026-06-18_monthly-transactions-i.md)

## How It Felt
Mostly clean. CASE WHEN applied correctly on the first try. The only real mistakes were the COUNT(boolean) trap (again) and COUNT(country) skipping NULLs when country itself was null.

## Key Insight
Two patterns combined here:

**1. TO_CHAR for month grouping.** To group by month in Postgres, convert the date to a string first: `TO_CHAR(trans_date, 'YYYY-MM')`. This gives you `'2019-01'` style strings that GROUP BY can collapse correctly. It also goes in the GROUP BY itself — the expression must match exactly.

**2. CASE WHEN for conditional totals.** To get counts and sums for only a subset of rows (here, approved transactions), use:
- `SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END)` → approved count
- `SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END)` → approved total

**3. COUNT(*) vs COUNT(col).** Always use `COUNT(*)` for total row count. `COUNT(col)` skips NULLs — so if `country` is NULL for a row, `COUNT(country)` returns 0 for that group instead of 1.

## Solution Walkthrough
So the problem wants a monthly summary per country: total transactions, approved-only transactions, and the corresponding amounts.

No join needed — the Transactions table has everything.

Start with `TO_CHAR(trans_date, 'YYYY-MM')` to extract the month. Then GROUP BY both month and country — every unique (month, country) pair becomes one output row.

For the counts and sums:
- `COUNT(*)` — total rows in the group, regardless of NULLs
- `SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END)` — adds 1 for approved, 0 for declined
- `SUM(amount)` — total amount for all transactions in the group
- `SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END)` — adds amount for approved only

Note: `TO_CHAR(trans_date, 'YYYY-MM')` must appear in both SELECT and GROUP BY.

```sql
SELECT
    TO_CHAR(trans_date, 'YYYY-MM') AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM transactions
GROUP BY TO_CHAR(trans_date, 'YYYY-MM'), country;
```

## Pattern Introduced
- `TO_CHAR(date_col, 'YYYY-MM')` — extract year-month string for grouping in Postgres
- CASE WHEN applied to both count (THEN 1 ELSE 0) and sum (THEN amount ELSE 0) in same query

## Watch Out For
- `COUNT(col)` skips NULLs — use `COUNT(*)` when you want total rows including rows where that column is NULL
- `COUNT(condition)` counts every row (TRUE and FALSE are both non-NULL) — use `SUM(CASE WHEN ...)` instead
- `TO_CHAR(...)` expression must appear identically in both SELECT and GROUP BY

## Template
```sql
SELECT
    TO_CHAR(date_col, 'YYYY-MM') AS month,
    group_col,
    COUNT(*) AS total_count,
    SUM(CASE WHEN condition THEN 1 ELSE 0 END) AS conditional_count,
    SUM(amount_col) AS total_amount,
    SUM(CASE WHEN condition THEN amount_col ELSE 0 END) AS conditional_amount
FROM table
GROUP BY TO_CHAR(date_col, 'YYYY-MM'), group_col;
```

## Trace Through
Input (Case 2):
| id  | country | state    | amount | trans_date |
|-----|---------|----------|--------|------------|
| 121 | US      | approved | 1000   | 2018-12-18 |
| 122 | US      | declined | 2000   | 2018-12-19 |
| 123 | US      | approved | 2000   | 2019-01-01 |
| 124 | null    | approved | 2000   | 2019-01-07 |

After GROUP BY month + country:
- (2018-12, US): COUNT(*)=2, approved=1, total=3000, approved_total=1000
- (2019-01, US): COUNT(*)=1, approved=1, total=2000, approved_total=2000
- (2019-01, null): COUNT(*)=1, approved=1, total=2000, approved_total=2000

## Complexity / Correctness
O(n) single pass. No joins. CASE WHEN evaluated per row inside each aggregation.

## Submissions
- https://leetcode.com/problems/monthly-transactions-i/submissions/2036867550

## Open Questions
*(none)*
