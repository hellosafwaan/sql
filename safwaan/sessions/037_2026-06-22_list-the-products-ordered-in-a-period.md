# Session: List the Products Ordered in a Period — 2026-06-22

## What He Attempted
```sql
SELECT p.product_name, SUM(unit) AS unit
FROM Products p
INNER JOIN Orders o ON o.product_id = p.product_id
WHERE o.order_date >= '2020-02-01'
  AND o.order_date < '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;
```

## Where He Got Stuck
Momentarily unsure how to filter for February without knowing the day count. Chose `>= '2020-02-01' AND < '2020-03-01'` independently (correct and portable). Also worried that adding product_name to GROUP BY would change the results — reassured it doesn't when product_name is functionally determined by product_id.

## Mistakes Made
Initial draft had product_id instead of product_name in SELECT — corrected immediately when prompted.

## Key Insight
For month filtering, `>= first_day AND < first_day_of_next_month` is portable and avoids needing to know the month's length. Grouping by a functionally dependent column (product_name on product_id) is safe.

## Complexity / Correctness Notes
HAVING filters after aggregation — correct use here for the SUM >= 100 condition. WHERE filters before GROUP BY — correct for the date range.

## Coach Notes for Next Session
Date range filtering pattern (`>= X AND < Y`) is solid. WHERE vs HAVING used correctly here — note this as a clean application.
