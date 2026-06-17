Session: [011_2026-06-17_average-selling-price](../../safwaan/sessions/011_2026-06-17_average-selling-price.md)

## How It Felt
Tricky — multiple layers to get right, and multiple wrong turns before it clicked. The formula itself wasn't obvious, and then fixing the formula revealed the LEFT JOIN issue, which revealed the WHERE-kills-LEFT-JOIN issue, which revealed the integer division issue. Each fix unlocked the next problem.

## Key Insight
Three things stacked together that are each easy to miss:

1. **Weighted average ≠ AVG(price)**. If 100 units sold at $5 and 1 unit sold at $10, AVG(price) gives $7.50 but the real average price per unit is ~$5.09. The correct formula: `SUM(price * units) / SUM(units)` — total revenue divided by total units.

2. **WHERE on a right-table column kills your LEFT JOIN**. Moving BETWEEN to the WHERE clause filters out the NULL rows that LEFT JOIN preserved — it effectively turns LEFT JOIN back into INNER JOIN. The fix: put the range condition in the ON clause instead, so unmatched rows survive as NULLs.

3. **Integer division truncates before ROUND sees anything**. `SUM(int) / SUM(int)` in Postgres returns an integer — ROUND(6, 2) is still 6. Add `::numeric` to the numerator to force decimal division.

## Solution Walkthrough
So you have two tables: Prices (what each product cost during a date range) and UnitsSold (when units were bought). The ask is: for each product, what was the average price per unit — weighted by how many units sold at each price point? And if a product has zero sales, report 0.

Start with `FROM prices LEFT JOIN unitssold` — Prices is the base table because the problem says every product should appear in the result, even with no sales. The join condition has two parts: same product, and the purchase date falls within that product's price window. Crucially, **the BETWEEN goes in the ON clause**, not WHERE. If it goes in WHERE, NULL rows from no-sale products get filtered out, and you've accidentally written an INNER JOIN.

After the join, you have rows like: (product_id, price, units, purchase_date). For products with no sales, units and purchase_date are NULL.

Then `GROUP BY product_id` collapses all rows per product into one group.

In SELECT, compute `SUM(price * units) / SUM(units)` — the weighted average. But Postgres does integer division by default, so add `::numeric` to the numerator to get decimals. Wrap in `ROUND(..., 2)` for 2 decimal places. Wrap the whole thing in `COALESCE(..., 0)` so that products with no sales (where both SUMs are NULL) return 0 instead of NULL.

Final shape:
```sql
SELECT p.product_id,
       COALESCE(ROUND(SUM(p.price * u.units)::numeric / SUM(u.units), 2), 0) AS average_price
FROM prices p
LEFT JOIN unitssold u
    ON p.product_id = u.product_id
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;
```

## Pattern Introduced
- **Weighted average**: `SUM(value * weight) / SUM(weight)` — not `AVG(value)`
- **JOIN condition vs WHERE**: filter on the right table goes in ON when using LEFT JOIN; putting it in WHERE nullifies the outer join
- **Integer division in Postgres**: `int / int = int`, cast one side with `::numeric` to get decimals

## Watch Out For
- `AVG(price)` ≠ weighted average — it ignores how many units were sold at each price
- BETWEEN in WHERE after LEFT JOIN → silently becomes INNER JOIN (no error, just wrong rows)
- ROUND(int_expr, 2) truncates because the expression is still integer — cast first

## Template
```sql
SELECT base.id,
       COALESCE(ROUND(SUM(base.value * other.weight)::numeric / SUM(other.weight), 2), 0) AS weighted_avg
FROM base_table base
LEFT JOIN other_table other
    ON base.id = other.id
    AND other.date_col BETWEEN base.start_date AND base.end_date
GROUP BY base.id;
```

## Trace Through
Prices:
| product_id | start_date | end_date   | price |
|------------|------------|------------|-------|
| 1          | 2019-02-17 | 2019-02-28 | 5     |
| 1          | 2019-03-01 | 2019-03-22 | 20    |
| 2          | 2019-02-01 | 2019-02-20 | 15    |
| 2          | 2019-02-21 | 2019-03-31 | 30    |

UnitsSold:
| product_id | purchase_date | units |
|------------|---------------|-------|
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |

After LEFT JOIN + ON condition:
| product_id | price | units |
|------------|-------|-------|
| 1          | 5     | 100   |  (2019-02-25 in [02-17, 02-28])
| 1          | 20    | 15    |  (2019-03-01 in [03-01, 03-22])
| 2          | 15    | 200   |  (2019-02-10 in [02-01, 02-20])
| 2          | 30    | 30    |  (2019-03-22 in [02-21, 03-31])

After GROUP BY + SUM formula:
- product 1: (5×100 + 20×15) / (100+15) = (500+300)/115 = 800/115 ≈ 6.96
- product 2: (15×200 + 30×30) / (200+30) = (3000+900)/230 = 3900/230 ≈ 16.96

## Complexity / Correctness
O(n) over the joined rows. The BETWEEN condition in ON is evaluated per row during the join, so each UnitsSold row matches at most one Prices row (non-overlapping date ranges guaranteed by the schema). No fan-out / no duplicate rows inflating the sums.

## Submissions
- https://leetcode.com/problems/average-selling-price/submissions/2036590748

## Open Questions
*(none)*
