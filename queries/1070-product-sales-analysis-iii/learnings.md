Session: [020_2026-06-18_product-sales-iii](../../safwaan/sessions/020_2026-06-18_product-sales-iii.md)

## How It Felt
Got stuck on the classic "I have the aggregate but I can't get the full row" problem. Connected the pattern from LC #1174 and #550 after one prompt.

## Key Insight
Third application of the derived-table subquery pattern: when you need the MIN/MAX per group AND the non-aggregated columns that go with it, you can't just add those columns to GROUP BY. Instead — subquery gets the aggregate per group, JOIN back on (group key + aggregate value) to recover the full row.

## Solution Walkthrough
You need the first year each product was sold, plus the quantity and price from that year.

The obvious instinct is to GROUP BY product_id and MIN(year). But then where do quantity and price come from? You can't add them to GROUP BY without fragmenting the groups. You can't put them in SELECT without grouping by them.

The fix: two-step.

**Step 1 — subquery gets the first year per product:**
```sql
SELECT product_id, MIN(year) AS first_year
FROM sales
GROUP BY product_id
```

**Step 2 — JOIN back to the original table to recover quantity and price:**
```sql
SELECT sales.product_id, s2.first_year, sales.quantity, sales.price
FROM sales
INNER JOIN (
    SELECT product_id, MIN(year) AS first_year
    FROM sales
    GROUP BY product_id
) AS s2
    ON s2.product_id = sales.product_id
   AND s2.first_year = sales.year;
```

The two-condition JOIN is the critical part: `ON product_id = product_id AND first_year = year`. Without the year condition, you'd get all years for each product instead of just the first one.

## Pattern Introduced
Derived-table subquery (third application): subquery gets aggregate per group → JOIN back on (group key + aggregate value) → recover full row.

## Watch Out For
- The JOIN needs TWO conditions: group key AND the aggregate value matching the original column
- Alias the aggregate in the subquery (`MIN(year) AS first_year`) or you can't reference it in the ON clause

## Template
```sql
SELECT t.*, s.agg_val
FROM original_table t
INNER JOIN (
    SELECT group_col, AGG(val_col) AS agg_val
    FROM original_table
    GROUP BY group_col
) AS s
    ON s.group_col = t.group_col
   AND s.agg_val = t.val_col;
```

## Trace Through
| product_id | year | quantity | price |
|---|---|---|---|
| 1 | 2008 | 10 | 5 |
| 1 | 2009 | 5 | 3 |
| 2 | 2011 | 15 | 9 |

Subquery: product 1 → first_year=2008, product 2 → first_year=2011
JOIN: keeps only rows where year = first_year → rows 1 and 3

## Complexity / Correctness
O(n log n) for the inner GROUP BY + outer hash join. Multiple rows per product in the first year are all returned (not aggregated).

## Submissions
https://leetcode.com/problems/product-sales-analysis-iii/submissions/2037676559

## Open Questions
None.
