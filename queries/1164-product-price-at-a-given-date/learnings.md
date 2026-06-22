Session: [029_2026-06-22_product-price-at-a-given-date](../../safwaan/sessions/029_2026-06-22_product-price-at-a-given-date.md)

## How It Felt
Hardest problem of the session. The two-case UNION structure was identified correctly, but case 2 (anti-join for default price) needed a step-by-step walkthrough. The LEFT JOIN without WHERE IS NULL confusion was the main sticking point.

## Key Insight
Two types of products: those with a price history before the cutoff date (get their most recent price) and those without (get the default price of 10). These are mutually exclusive, so UNION is correct. Case 1 = derived-table pattern. Case 2 = anti-join pattern.

## Solution Walkthrough
**Case 1:** For each product, find the most recent price change on or before `2019-08-16`. Subquery groups by product_id and picks `MAX(change_date)` with a WHERE filter. Outer query joins back on both product_id and that max date to retrieve the actual `new_price`. This is the derived-table pattern applied again.

**Case 2:** Which products don't appear in the subquery at all? Those are products whose every price change happened after the cutoff — so their "price" as of the cutoff date is the default 10. Anti-join: LEFT JOIN all products to the subquery, WHERE subquery result IS NULL → those products had no match → price = 10.

**Why UNION and not UNION ALL?** No product can be in both groups (a product either has a change before the date or doesn't), so UNION and UNION ALL give the same result. UNION is fine here.

**Alternative (COALESCE):**
```sql
SELECT DISTINCT p.product_id, COALESCE(sub.new_price, 10) AS price
FROM (SELECT DISTINCT product_id FROM Products) p
LEFT JOIN (
    SELECT p1.product_id, p1.new_price
    FROM Products p1
    JOIN (
        SELECT product_id, MAX(change_date) AS recent_date
        FROM Products WHERE change_date <= '2019-08-16'
        GROUP BY product_id
    ) p2 ON p1.product_id = p2.product_id AND p1.change_date = p2.recent_date
) sub ON p.product_id = sub.product_id;
```
LEFT JOIN case 1's result to all products; NULLs (no price history) get COALESCE'd to 10. Same logic, no UNION needed.

## Pattern Introduced
UNION for two-case problems where one case uses a derived-table and the other uses an anti-join for a default value. Second application of this UNION pattern (first: LC #1789).

## Watch Out For
- LEFT JOIN without `WHERE right.col IS NULL` returns ALL rows — it doesn't filter to unmatched ones. The IS NULL filter is what makes it an anti-join.
- Self-joining on the same conditions (p1 join p2 on product_id and same change_date) is a no-op — each row just matches itself. The power of the derived-table join is that p2 has the MAX date, not the raw date.

## Template
```sql
-- Case 1: has history → derived-table to get latest value
SELECT t.id, t.value
FROM table t
JOIN (
    SELECT id, MAX(date_col) AS latest_date
    FROM table WHERE date_col <= 'cutoff'
    GROUP BY id
) sub ON sub.id = t.id AND sub.latest_date = t.date_col

UNION

-- Case 2: no history → default value via anti-join
SELECT DISTINCT t.id, <default> AS value
FROM table t
LEFT JOIN (SELECT id FROM table WHERE date_col <= 'cutoff') sub
    ON sub.id = t.id
WHERE sub.id IS NULL;
```

## Trace Through
```
product_id | new_price | change_date
1          | 20        | 2019-08-14
1          | 30        | 2019-08-15
1          | 35        | 2019-08-16
2          | 50        | 2019-08-14
2          | 65        | 2019-08-17  ← after cutoff
3          | 20        | 2019-08-18  ← after cutoff
```
Case 1 subquery (MAX date ≤ 2019-08-16):
- product 1 → 2019-08-16 → new_price = 35
- product 2 → 2019-08-14 → new_price = 50

Case 2 anti-join:
- product 3 has no rows in subquery → price = 10

Final: (1, 35), (2, 50), (3, 10)

## Complexity / Correctness
Case 1: two scans (subquery + outer join). Case 2: two scans (subquery + outer join). UNION adds dedup step. Total: ~4 table scans. Indexing `(product_id, change_date)` would help significantly.

## Submissions
https://leetcode.com/problems/product-price-at-a-given-date/submissions/2041961703

## Open Questions
- How would you solve this with a single query using window functions? (ROW_NUMBER OVER PARTITION BY product_id ORDER BY change_date DESC — Phase 8)
