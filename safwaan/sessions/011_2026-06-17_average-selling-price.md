# Session: Average Selling Price (LC #1251) — 2026-06-17

## What He Attempted
**Attempt 1:**
```sql
SELECT prices.product_id, AVG(prices.price * unitssold.units)
FROM prices
INNER JOIN unitssold ON prices.product_id = unitssold.product_id
WHERE unitssold.purchase_date BETWEEN prices.start_date AND prices.end_date;
-- Missing GROUP BY → runtime error
```

**Attempt 2 (after GROUP BY nudge):**
```sql
SELECT prices.product_id, AVG(prices.price) AS average_price
FROM prices
INNER JOIN unitssold ON prices.product_id = unitssold.product_id
WHERE unitssold.purchase_date BETWEEN prices.start_date AND prices.end_date
GROUP BY prices.product_id;
-- Wrong formula — AVG(price) ignores unit weighting
```

**Attempt 3 (correct formula):**
```sql
SELECT prices.product_id, SUM(prices.price * unitssold.units) / SUM(unitssold.units) AS average_price
FROM prices
INNER JOIN unitssold ON prices.product_id = unitssold.product_id
WHERE unitssold.purchase_date BETWEEN prices.start_date AND prices.end_date
GROUP BY prices.product_id;
-- INNER JOIN drops no-sale products; integer division truncates
```

**Attempt 4 (LEFT JOIN added):**
```sql
-- Still had BETWEEN in WHERE → WHERE nullified LEFT JOIN, products with no sales dropped
```

**Attempt 5 (BETWEEN moved to ON, ::numeric added, COALESCE added) → Accepted:**
```sql
SELECT p.product_id,
       COALESCE(ROUND(SUM(p.price * u.units)::numeric / SUM(u.units), 2), 0) AS average_price
FROM prices p
LEFT JOIN unitssold u
    ON p.product_id = u.product_id
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;
```

## Where He Got Stuck
1. **Formula** — went straight to `AVG(price * units)` then `AVG(price)`. Unblocked by concrete example: 100 units at $5 and 1 unit at $10 — what's the average price per unit?
2. **WHERE kills LEFT JOIN** — knew he needed LEFT JOIN for the no-sales case but kept BETWEEN in WHERE. Unblocked by: "What happens to a LEFT JOIN row where UnitsSold had no match?" → realized NULL fails the BETWEEN check → move it to ON.
3. **Integer division** — forgot `::numeric` from LC #1934. Unblocked by prompting him to recall the pattern (he couldn't, needed the direct answer).

## Mistakes Made
- **GROUP BY missing** — third occurrence. Still not automatic before running. He caught it himself from the error.
- **Wrong aggregation formula** — `AVG(price)` treats each price point equally regardless of units sold. Correct formula: `SUM(price * units) / SUM(units)`.
- **BETWEEN in WHERE after LEFT JOIN** — WHERE filter on right-table column eliminates NULL rows, turning LEFT JOIN into INNER JOIN. Must go in ON clause.
- **Integer division** — `SUM(int) / SUM(int)` truncates in Postgres. `::numeric` cast on numerator forces decimal division.

## Key Insight
Weighted average ≠ `AVG(col)`. And when you use LEFT JOIN to preserve unmatched rows, any filter on the right table that goes in WHERE will quietly destroy what LEFT JOIN just did — it needs to go in the ON clause instead.

## Complexity / Correctness Notes
The BETWEEN condition in ON ensures each UnitsSold row matches at most one Prices row (non-overlapping date ranges guaranteed by schema). No fan-out risk. COALESCE handles the NULL from `SUM(NULL) / SUM(NULL)` for no-sale products.

## Coach Notes for Next Session
- GROUP BY completeness: third time. Must become automatic before running, not after the error fires. Watch every aggregation problem.
- Integer division / `::numeric`: needs more reps before it's instinctive. He didn't remember it from LC #1934.
- WHERE-kills-LEFT-JOIN: new pattern, only seen once. Probe on next problem that combines LEFT JOIN + a range/date filter.
- Weighted average formula is now seen once — probe cold on next aggregation problem involving units/weights.
