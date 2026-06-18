Session: [024_2026-06-18_customers-all-products](../../safwaan/sessions/024_2026-06-18_customers-all-products.md)

## How It Felt
First instinct was to JOIN — redirected to think about counting. Once the counting framing clicked, fell into place quickly despite a few syntax mistakes.

## Key Insight
"Has all of X" = per-group COUNT(DISTINCT x) equals total COUNT of X. The total is a scalar subquery. No JOIN needed — the whole thing lives in GROUP BY + HAVING.

## Solution Walkthrough
You want customers who bought every product in the Product table.

The instinct is to JOIN Customer with Product and check for matches — but that gets complicated fast. The cleaner framing: a customer "has all products" if the number of distinct products they've bought equals the total number of products.

```sql
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product);
```

FROM → GROUP BY: one group per customer.
HAVING: keep only customers where their distinct product count matches the total. The scalar subquery `(SELECT COUNT(*) FROM Product)` runs once and gives you that total.

Why DISTINCT? A customer might buy the same product multiple times. COUNT(product_key) would overcount. COUNT(DISTINCT product_key) gives the actual number of unique products they've purchased.

## Pattern Introduced
"Bought all" / relational division: `HAVING COUNT(DISTINCT col) = (SELECT COUNT(*) FROM reference_table)`. Scalar subquery in HAVING (new context — previously seen in SELECT).

## Watch Out For
- COUNT(DISTINCT col) is required — raw COUNT would overcount repeated purchases
- Scalar subquery in HAVING needs parentheses: `= (SELECT ...)`
- No JOIN needed — this is a pure counting comparison problem

## Template
```sql
SELECT group_col
FROM table
GROUP BY group_col
HAVING COUNT(DISTINCT val_col) = (SELECT COUNT(*) FROM reference_table);
```

## Trace Through
Products: {A, B, C} → total count = 3

| customer_id | product_key |
|---|---|
| 1 | A |
| 1 | B |
| 1 | C |
| 2 | A |
| 2 | A |   ← duplicate

Customer 1: COUNT(DISTINCT product_key) = 3 = 3 ✓ → included
Customer 2: COUNT(DISTINCT product_key) = 1 ≠ 3 → excluded

## Complexity / Correctness
O(n log n) for GROUP BY + DISTINCT. Scalar subquery runs once.

## Submissions
https://leetcode.com/problems/customers-who-bought-all-products/submissions/2037736882

## Open Questions
None.
