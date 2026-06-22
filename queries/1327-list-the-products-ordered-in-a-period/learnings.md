Session: [037_2026-06-22_list-the-products-ordered-in-a-period](../../safwaan/sessions/037_2026-06-22_list-the-products-ordered-in-a-period.md)

## How It Felt
Solid. JOIN + WHERE + HAVING is fully internalized. The only pause was on date filtering and GROUP BY column choice — both resolved with minimal guidance.

## Key Insight
For month filtering, use `>= first_day AND < first_day_of_next_month` — portable, no need to know the month's length, handles leap years automatically.

## Solution Walkthrough
Join Products to Orders on product_id to get product names alongside order data. Filter to February 2020. Group by product_name (functionally equivalent to grouping by product_id since one maps to the other). SUM the units. HAVING filters groups where total < 100.

```sql
SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
INNER JOIN Orders o ON o.product_id = p.product_id
WHERE o.order_date >= '2020-02-01'
  AND o.order_date < '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;
```

The WHERE date filter goes before GROUP BY (filters rows). The HAVING SUM filter goes after GROUP BY (filters groups). This is the WHERE vs HAVING distinction in practice.

## Pattern Introduced
**Month range filter:** `col >= 'YYYY-MM-01' AND col < 'YYYY-(MM+1)-01'`

## Watch Out For
- Don't put `SUM(unit) >= 100` in WHERE — it runs before GROUP BY, before SUM exists. It must be in HAVING.
- Grouping by product_name instead of product_id is fine when names are unique, but if names aren't unique you'd want product_id.

## Template
```sql
SELECT name_col, SUM(qty_col) AS total
FROM ref_table
JOIN fact_table ON ref_table.id = fact_table.id
WHERE date_col >= 'start' AND date_col < 'end'
GROUP BY name_col
HAVING SUM(qty_col) >= threshold;
```

## Complexity / Correctness
O(n log n) — sort for GROUP BY. WHERE filter reduces rows before grouping.

## Submissions
https://leetcode.com/problems/list-the-products-ordered-in-a-period/submissions/2042379887

## Open Questions
None.
