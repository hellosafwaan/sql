Session: [003_2026-06-17_customer-who-visited-no-transactions](../../safwaan/sessions/003_2026-06-17_customer-who-visited-no-transactions.md)

## How It Felt
Solid. Reasoned through the whole approach out loud before writing a single line — arrived at LEFT JOIN + IS NULL independently. No wrong turns.

## Key Insight
When a table only has a row for something that *happened*, the absence of a row means it *didn't happen*. Transactions only has rows for actual transactions. So "no transaction" = "no row in Transactions". LEFT JOIN visits with Transactions → NULL on the right side = visit with no transaction. Filter on that NULL, then GROUP BY customer to count how many times they visited without buying.

## Solution Walkthrough
The question is: which customers visited but never bought anything, and how many times?

Transactions only contains rows when a transaction actually happened. So if a visit has no transaction, it simply won't appear in Transactions. This means: if we LEFT JOIN Visits with Transactions on visit_id, every visit gets a row in the result — but visits with no transaction will have NULL in all Transactions columns.

Step 1 — LEFT JOIN to expose the NULLs:
```
FROM visits LEFT JOIN transactions ON visits.visit_id = transactions.visit_id
```

Step 2 — filter to only the no-transaction visits:
```
WHERE transactions.transaction_id IS NULL
```

Step 3 — count how many such visits each customer had:
```
GROUP BY visits.customer_id
```

Step 4 — SELECT the customer and their count:
```
SELECT visits.customer_id, count(visits.customer_id) as count_no_trans
```

## Pattern Introduced
**Anti-join**: find rows in table A with no match in table B.
Template:
```sql
LEFT JOIN B ON A.key = B.key
WHERE B.any_column IS NULL
```

## Watch Out For
- `COUNT(visits.customer_id)` and `COUNT(*)` are equivalent here because customer_id is never NULL. But the habit to build: if the column you're counting could be NULL in the result, use `COUNT(right_table.col)` not `COUNT(*)`.
- Make sure the IS NULL check is on the right table's column, not the left table's column.

## Template
```sql
SELECT left_table.key, COUNT(left_table.col) as count
FROM left_table
LEFT JOIN right_table ON left_table.key = right_table.key
WHERE right_table.any_col IS NULL
GROUP BY left_table.key;
```

## Trace Through
After LEFT JOIN: visit 1 (Alice, has transaction), visit 2 (Bob, has transaction), visits 4/6/7/8 (customer 30, 96, 54, 54 — no transactions → NULL on right).
After WHERE IS NULL: only the 4 no-transaction rows remain.
After GROUP BY: customer 54 → 2 visits, customer 30 → 1, customer 96 → 1.

## Complexity / Correctness
O(n) with index on visit_id. COUNT(visits.customer_id) correct here; COUNT(*) would also work.

## Submissions
https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/submissions/2036269655

## Open Questions
None.
