Session: [000_2026-06-17_phase-1-select-basics](../../safwaan/sessions/000_2026-06-17_phase-1-select-basics.md)

## How It Felt
First problem ever. Straightforward — scan the table, return product_ids that satisfy two conditions at once. No ambiguity about what the query needed to do.

## Key Insight
AND means both conditions must be true for the row to make it through. The columns are enum-style ('Y'/'N'), so the filter is just a direct equality check on each. No tricks here — this is what WHERE is for.

## Solution Walkthrough
So you have a Products table with a `low_fats` column and a `recyclable` column, both storing 'Y' or 'N'. You want product_ids where both are 'Y'.

The FROM gets you every row. The WHERE clause then acts as a gate: `low_fats = 'Y'` passes only rows where that column is 'Y', and `AND recyclable = 'Y'` further narrows to rows where that's also 'Y'. Anything failing either condition gets dropped. What's left is exactly the rows you want. SELECT grabs just the product_id column from those.

```sql
SELECT product_id
FROM Products
WHERE low_fats = 'Y'
  AND recyclable = 'Y';
```

## Pattern Introduced
WHERE + AND — multi-condition row filter. All conditions must be satisfied.

## Watch Out For
Nothing subtle here. The one thing to note: AND is stricter than OR. If you accidentally wrote OR you'd get products that are *either* low fat *or* recyclable — a much larger set.

## Template
```sql
SELECT col
FROM table
WHERE condition_a = 'value'
  AND condition_b = 'value';
```

## Trace Through
| product_id | low_fats | recyclable | passes? |
|-----------|----------|------------|---------|
| 0 | Y | N | No (recyclable fails) |
| 1 | Y | Y | Yes |
| 2 | N | Y | No (low_fats fails) |
| 3 | N | N | No |
| 4 | Y | Y | Yes |

Output: product_ids 1 and 4.

## Complexity / Correctness
O(n) scan — every row checked once. No NULLs in this table, no JOIN fan-out risk.

## Submissions
https://leetcode.com/problems/recyclable-and-low-fat-products/submissions/2036051066
Accepted — 19/19 test cases, 262ms

## Open Questions
None.
