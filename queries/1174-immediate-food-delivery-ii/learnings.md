Session: [016_2026-06-18_immediate-food-delivery-ii](../../safwaan/sessions/016_2026-06-18_immediate-food-delivery-ii.md)

## How It Felt
More involved — first time writing a subquery in the FROM clause. The logic was sound from the start (group by customer to find min order date, then check if immediate), but translating that into a subquery JOIN took a few steps to get right.

## Key Insight
When you need to filter rows based on a per-group aggregate (like "the row with the minimum date per customer"), you can't do it in one pass. The pattern is:

1. **Subquery to get the aggregate per group** — `SELECT customer_id, MIN(order_date) AS first_order_date FROM delivery GROUP BY customer_id`
2. **JOIN back to the original table** on both the group key AND the aggregate value — this filters down to exactly the rows you want (one per customer, their first order)
3. **Then compute your metric** across those filtered rows

The JOIN condition must use `order_date = first_order_date`, not `customer_pref_delivery_date = first_order_date`. The subquery gives you the min order date — you match it against `order_date` to get the actual first-order row.

## Solution Walkthrough
So the question is: what percentage of customers had their first order as an "immediate" delivery?

An immediate order is one where `order_date = customer_pref_delivery_date`. The first order per customer is the one with the minimum `order_date`.

You can't do both in one GROUP BY — if you group by customer to get MIN(order_date), you lose the row-level `customer_pref_delivery_date` needed to check if it was immediate.

**Step 1 — subquery:** Find each customer's first order date.
```sql
SELECT customer_id, MIN(order_date) AS first_order_date
FROM delivery
GROUP BY customer_id
```

**Step 2 — JOIN back:** Match this against the original table on customer_id AND order_date. This gives you exactly one row per customer — the first order row, with all its columns intact (including `customer_pref_delivery_date`).
```sql
FROM delivery
JOIN (...subquery...) AS d2
    ON delivery.customer_id = d2.customer_id
   AND delivery.order_date = d2.first_order_date
```

**Step 3 — compute:** Now each row in the result is a customer's first order. Check if it was immediate and compute the percentage:
```sql
ROUND(SUM(CASE WHEN customer_pref_delivery_date = first_order_date THEN 1 ELSE 0 END)::numeric / COUNT(*) * 100, 2)
```

Note: `customer_pref_delivery_date = first_order_date` works here because `first_order_date = order_date` (from the JOIN), and immediate means `order_date = customer_pref_delivery_date`.

## Pattern Introduced
- **Subquery in FROM (derived table)**: compute a per-group aggregate in a subquery, then JOIN it back to the original table to filter to specific rows
- **Two-condition JOIN**: `ON a.id = b.id AND a.date = b.min_date` — filters to only the rows that match the aggregate

## Watch Out For
- The JOIN condition must use `order_date = first_order_date`, not `customer_pref_delivery_date = first_order_date` — you're matching on the date that identifies the first order, not the preferred date
- Can't use `MIN()` inside `CASE WHEN` — aggregates and row-level expressions can't be mixed that way
- Integer division: `SUM(int) / COUNT(*)` = 0 when SUM < COUNT — cast with `::numeric`

## Template
```sql
-- Pattern: filter to per-group first/min row, then aggregate
SELECT ROUND(SUM(CASE WHEN condition THEN 1 ELSE 0 END)::numeric / COUNT(*) * 100, 2) AS percentage
FROM main_table
JOIN (
    SELECT group_col, MIN(date_col) AS first_date
    FROM main_table
    GROUP BY group_col
) AS sub ON main_table.group_col = sub.group_col
         AND main_table.date_col = sub.first_date;
```

## Alternative: Tuple IN Subquery (cleaner)

Instead of a derived-table JOIN, you can use tuple matching in WHERE:

```sql
SELECT ROUND(AVG(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END)::numeric * 100, 2) AS immediate_percentage
FROM delivery
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MIN(order_date)
    FROM delivery
    GROUP BY customer_id
);
```

`WHERE (customer_id, order_date) IN (subquery)` filters rows where that exact pair of values exists in the subquery result — here, only the (customer_id, first_order_date) pairs. It's equivalent to the two-condition JOIN but reads more naturally: "keep only rows whose (customer, date) is a first order."

MySQL note: MySQL allows `AVG(order_date = customer_pref_delivery_date)` directly because booleans are 1/0. In Postgres you need the CASE WHEN or `::integer` cast.

**When to use which:**
- Tuple IN: cleaner and more readable when filtering to a subset of rows defined by a subquery
- Derived-table JOIN: more flexible — lets you bring in computed columns from the subquery (like aliased min dates you want to reference elsewhere)

## Trace Through
Delivery (sample):
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
|-------------|-------------|------------|-----------------------------|
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 2           | 2019-08-02 | 2019-08-02  (immediate)     |
| 3           | 1           | 2019-08-11 | 2019-08-12                  |
| 4           | 3           | 2019-08-24 | 2019-08-24  (immediate)     |
| 5           | 3           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
| 7           | 4           | 2019-08-09 | 2019-08-09  (immediate)     |

Subquery (first order per customer):
| customer_id | first_order_date |
|-------------|-----------------|
| 1           | 2019-08-01      |
| 2           | 2019-08-02      |
| 3           | 2019-08-21      |
| 4           | 2019-08-09      |

After JOIN (first order rows only):
| customer_id | order_date | customer_pref | first_order_date | immediate? |
|-------------|------------|---------------|-----------------|------------|
| 1           | 2019-08-01 | 2019-08-02    | 2019-08-01      | No         |
| 2           | 2019-08-02 | 2019-08-02    | 2019-08-02      | Yes        |
| 3           | 2019-08-21 | 2019-08-22    | 2019-08-21      | No         |
| 4           | 2019-08-09 | 2019-08-09    | 2019-08-09      | Yes        |

SUM(immediate) = 2, COUNT(*) = 4 → 2/4 * 100 = 50.00%

## Complexity / Correctness
The subquery is O(n). The JOIN is O(n). Total O(n). Each customer appears exactly once in the subquery result (by GROUP BY), so the JOIN produces exactly one row per customer — no fan-out.

## Submissions
- https://leetcode.com/problems/immediate-food-delivery-ii/submissions/2037488158

## Open Questions
*(none)*
