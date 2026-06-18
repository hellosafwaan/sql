# Session: Immediate Food Delivery II (LC #1174) — 2026-06-18

## What He Attempted
**Attempt 1 (can't mix aggregate in CASE WHEN):**
```sql
SELECT customer_id, SUM(CASE WHEN MIN(order_date) = customer_pref_delivery_date THEN 1 ELSE 0 END)
FROM delivery
GROUP BY customer_id;
```

**Attempt 2 (wrong JOIN condition):**
```sql
SELECT *
FROM delivery
INNER JOIN (SELECT customer_id, MIN(order_date) AS first_order_date
            FROM delivery GROUP BY customer_id) AS d2
    ON delivery.customer_id = d2.customer_id
   AND delivery.customer_pref_delivery_date = d2.first_order_date;
```

**Attempt 3 (correct JOIN, missing ROUND/::numeric):**
```sql
SELECT SUM(CASE WHEN customer_pref_delivery_date = first_order_date THEN 1 ELSE 0 END) / COUNT(*)
FROM delivery
JOIN (...) AS d2 ON delivery.customer_id = d2.customer_id AND delivery.order_date = d2.first_order_date;
-- Got 0 due to integer division
```

**Attempt 4 → Accepted:**
```sql
SELECT ROUND(SUM(CASE WHEN customer_pref_delivery_date = first_order_date THEN 1 ELSE 0 END)::numeric
             / COUNT(*) * 100, 2) AS immediate_percentage
FROM delivery
JOIN (SELECT customer_id, MIN(order_date) AS first_order_date FROM delivery GROUP BY customer_id) AS d2
    ON delivery.customer_id = d2.customer_id AND delivery.order_date = d2.first_order_date;
```

## Where He Got Stuck
1. **MIN inside CASE WHEN** — tried to use aggregate inside a row-level expression. Guided to think of it as a subquery first.
2. **Wrong JOIN condition** — matched on `customer_pref_delivery_date = first_order_date` instead of `order_date = first_order_date`. Caught by question: "what column identifies the first-order row?"
3. **Integer division** — got 0; needed ::numeric prompt (fourth encounter total).

## Mistakes Made
- Can't nest aggregate (MIN) inside CASE WHEN
- Wrong JOIN condition — matched pref date instead of order date
- Integer division — still needs ::numeric reminder

## Key Insight
Two-step pattern: subquery to find the per-group aggregate, JOIN back to original table to recover the full row, then aggregate across the filtered rows.

## Complexity / Correctness Notes
Subquery O(n), JOIN O(n). One row per customer after JOIN — no fan-out risk.

## Coach Notes for Next Session
- **COUNT(boolean) trap**: he got it right when probed cold at session start — real improvement. Keep probing.
- **Subquery in FROM**: first time. Pattern was new but clicked once he understood the two-step approach. Probe on next problem requiring per-group filtering.
- **::numeric**: still needs prompting (fourth encounter). Getting closer but not automatic.
- **Wrong JOIN condition**: common mistake with this pattern — matching the wrong column to the aggregate. Watch for it on next subquery problem.
