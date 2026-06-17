# Session: Product Sales Analysis I — 2026-06-17

## What He Attempted
```sql
select Product.product_name, Sales.year, Sales.price
from Sales join Product on Sales.product_id = Product.product_id;
```
First try, immediately correct.

## Where He Got Stuck
Nowhere — solved cold.

## Mistakes Made
None.

## Key Insight
"Every sale is guaranteed to have a matching product. No orphaned rows to worry about, so INNER JOIN is the right call." He also articulated the decision framework: *do I need rows with no match, or only rows that match?* That question determines INNER vs LEFT.

## Complexity / Correctness Notes
Standard two-table INNER JOIN. No aggregation, no NULLs. Clean baseline problem.

## Coach Notes for Next Session
Confident on basic INNER JOIN and can state the INNER vs LEFT decision rule. Building the right mental model early.
