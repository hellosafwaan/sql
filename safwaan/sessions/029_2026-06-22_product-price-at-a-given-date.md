# Session: Product Price at a Given Date (LC #1164) — 2026-06-22

## What He Attempted
Correctly identified the two-step structure: get the most recent price change per product on or before the date, then handle products with no changes (default = 10). Built the derived-table subquery for case 1 independently. Needed guidance for case 2.

Final solution:
```sql
select p1.product_id, p1.new_price as price
from products p1
    inner join (
        select product_id, max(change_date) as recent_price
        from products
        where change_date <= '2019-08-16'
        group by product_id
    ) as p2 on p2.product_id = p1.product_id and p2.recent_price = p1.change_date

union

select distinct p.product_id, 10 as price
from products p
left join (
    select product_id from products where change_date <= '2019-08-16'
) sub on sub.product_id = p.product_id
where sub.product_id is null;
```

## Where He Got Stuck
- Case 1: first tried self-joining on the same conditions (p1 and p2 both from Products, joined on product_id and change_date = change_date), which is a no-op join — each row just matches itself.
- Case 2: needed the anti-join pattern explained. Did not know that LEFT JOIN without WHERE IS NULL returns all rows. After tracing through the sample data, understood it.

## Mistakes Made
- Self-join mistake: tried `JOIN products p2 ON p2.product_id = p1.product_id AND p2.change_date = p1.change_date` — this joins each row to itself, adds no information.
- Left the WHERE IS NULL out of the initial case 2 attempt — understood why it was needed after seeing what the output looked like without it.

## Key Insight
Two-case problem: products with a price history on or before the date get their most recent price (derived-table pattern). Products with no history at all get the default price of 10 (anti-join pattern). UNION combines both cases — UNION works here since no product can be in both groups.

Alternative: instead of UNION, you could LEFT JOIN case 1's result back to all distinct product_ids and use COALESCE(price, 10). Same logic, different structure.

## Complexity / Correctness Notes
Case 1 requires two scans (subquery + outer join). Case 2 requires two scans (subquery + outer join). UNION adds a dedup step. Could be optimized with a single pass using window functions (ROW_NUMBER OVER PARTITION BY product_id ORDER BY change_date DESC), but that's Phase 8 territory.

## Coach Notes for Next Session
- Anti-join pattern needed a walkthrough — it's been a while since he applied it in this context (case 2 as anti-join, not just "find unmatched rows"). Worth a cold probe next time.
- UNION for two-case problems: second application (first was LC #1789). Solidifying.
- The COALESCE alternative is worth introducing when window functions arrive.
