# Session: Product Sales Analysis III — 2026-06-18

## What He Attempted
Correctly identified that he needed MIN(year) per product_id. Wrote the subquery independently. Got stuck on how to surface quantity and price without corrupting the GROUP BY.

## Where He Got Stuck
"If I add quantity/price to GROUP BY, my group by will get messed up." — correct instinct. Needed one prompt to connect to the derived-table pattern from LC #1174 and #550.

## Mistakes Made
- First JOIN draft had only one condition (product_id), missing the year match. This would have returned all years for each product, not just the first.
- Forgot to alias MIN(year) — needed the alias to reference it in the JOIN condition.

## Key Insight
Third clean application of the derived-table subquery pattern: subquery gets MIN per group, JOIN back on (group key + aggregate value) to recover the full row. He connected the pattern himself after one prompt.

## Complexity / Correctness Notes
O(n log n) for the inner GROUP BY + outer JOIN. The two-condition JOIN is load-bearing — without `AND s2.first_year = sales.year`, you get a fan-out of all years per product.

## Coach Notes for Next Session
Pattern is solid — three applications, self-connected on third. Mark as internalized.
