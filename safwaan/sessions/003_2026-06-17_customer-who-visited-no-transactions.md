# Session: Customer Who Visited but Did Not Make Any Transactions — 2026-06-17

## What He Attempted
```sql
select visits.customer_id, count(visits.customer_id) as count_no_trans
from visits
left join transactions on visits.visit_id = transactions.visit_id
where transactions.transaction_id is null
group by visits.customer_id;
```
Correct on first attempt (after some small syntax errors during testing).

## Where He Got Stuck
Spent time reasoning through LEFT vs INNER before writing — arrived at LEFT JOIN independently with solid reasoning. No real sticking point.

## Mistakes Made
Minor syntax errors during testing (not tracked), nothing conceptual.

## Key Insight
"The only way we know a transaction was never made is that the transactions table has no record for that visit. LEFT JOIN gives us all visits; NULL on the transaction side means no transaction. We filter on that NULL to find the no-transaction visitors."

Also raised COUNT(col) vs COUNT(*) proactively — recognized that both work here because customer_id is never NULL, but understood the distinction.

## Complexity / Correctness Notes
Anti-join pattern: LEFT JOIN + WHERE right_table.col IS NULL. COUNT(visits.customer_id) and COUNT(*) are equivalent here since customer_id is non-null, but COUNT(col) is the safer habit when NULLs might appear.

## Coach Notes for Next Session
Anti-join pattern is solid. COUNT(col) vs COUNT(*) distinction understood conceptually — will surface again when it actually matters (likely in an aggregation problem with LEFT JOIN).
