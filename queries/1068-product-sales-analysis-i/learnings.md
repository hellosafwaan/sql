Session: [002_2026-06-17_product-sales-analysis-i](../../safwaan/sessions/002_2026-06-17_product-sales-analysis-i.md)

## How It Felt
Easy. Solved cold first try. Felt like a straightforward application of INNER JOIN — both tables always have a matching row, so no ambiguity about join type.

## Key Insight
Every row in Sales has a product_id that is guaranteed to exist in Product. So INNER JOIN is correct — you're not worried about losing rows, you're just enriching each sale record with the product name. The decision rule: *do I need rows with no match, or only rows that match?*

## Solution Walkthrough
We have Sales (all the individual sales transactions) and Product (the product catalog). The goal is to return product_name, year, and price for every sale.

product_name lives in Product; year and price live in Sales. So we need to bring them together. Since every sale has a product_id and every product_id in Sales exists in Product, INNER JOIN is the right call — no rows will be lost.

```sql
FROM Sales JOIN Product ON Sales.product_id = Product.product_id
```

After the join, every row has both the product name and the sale details. SELECT picks the three columns we need.

## Pattern Introduced
Basic INNER JOIN — joining two tables on a shared key when you know every row has a match.

## Watch Out For
If you used LEFT JOIN here instead, you'd get the same result — but it signals "some rows might not match" which is misleading. Use INNER JOIN when you know both sides always have a match.

## Template
```sql
SELECT t2.descriptive_col, t1.col1, t1.col2
FROM t1
JOIN t2 ON t1.foreign_key = t2.primary_key;
```

## Trace Through
Sales has 3 rows. Product has 3 rows. INNER JOIN on product_id pairs each sale with its product name. Result: 3 rows, one per sale.

## Complexity / Correctness
O(n) with an index on product_id. No NULLs, no aggregation.

## Submissions
https://leetcode.com/problems/product-sales-analysis-i/submissions/2036248603

## Open Questions
None.
