Session: [000_2026-06-17_phase-1-select-basics](../../safwaan/sessions/000_2026-06-17_phase-1-select-basics.md)

## How It Felt
Looked simple at first. The natural instinct is `WHERE referee_id != 2` — but that silently drops customers with no referee at all. Needed to think about what NULL means in a comparison.

## Key Insight
`NULL != 2` does not return TRUE — it returns NULL. SQL treats any comparison with NULL as unknown, and WHERE only keeps rows where the condition is TRUE. So a customer with `referee_id = NULL` gets filtered out even though they were never referred by customer 2. To keep them, you have to say it explicitly: `IS NULL OR != 2`.

This is the NULL trap. It's not a typo — it's how SQL's three-valued logic works. You can't detect NULL with `=` or `!=`. You need `IS NULL` / `IS NOT NULL`.

## Solution Walkthrough
So the question is: find customers not referred by customer 2. That means two groups: customers with no referee at all (referee_id IS NULL), and customers referred by someone other than 2 (referee_id != 2).

If you only write `WHERE referee_id != 2`, here's what happens with a NULL row: SQL evaluates `NULL != 2`. That's unknown, not true. The row doesn't pass. You've silently lost every customer with no referee — exactly the people you want most.

The fix is to make the NULL case explicit with OR:

```sql
SELECT name
FROM Customer
WHERE referee_id IS NULL
   OR referee_id != 2;
```

This says: pass the row if there's no referee at all, OR if there's a referee who isn't customer 2. Both cases covered.

## Pattern Introduced
NULL handling in WHERE — `NULL != value` evaluates to NULL (not TRUE). Use `IS NULL` / `IS NOT NULL` to test for absence of a value.

## Watch Out For
- `= NULL` and `!= NULL` are always wrong. The only correct syntax is `IS NULL` / `IS NOT NULL`.
- This bites hardest on LEFT JOIN results — the right-side columns for unmatched rows are NULL, and filtering them with `col != value` silently drops them.

## Template
```sql
-- "not equal to X or no value at all"
WHERE col IS NULL OR col != X

-- "only rows with a value, excluding X"
WHERE col IS NOT NULL AND col != X
```

## Trace Through
| customer_id | name | referee_id | passes? |
|------------|------|-----------|---------|
| 1 | Will | NULL | Yes (IS NULL) |
| 2 | Jane | NULL | Yes (IS NULL) |
| 3 | Alex | 2 | No |
| 4 | Bill | NULL | Yes (IS NULL) |
| 5 | Zack | 1 | Yes (!= 2) |
| 6 | Mark | 2 | No |

Output: Will, Jane, Bill, Zack.

## Complexity / Correctness
O(n) scan. The key correctness issue is NULL — every other approach without IS NULL produces a wrong answer.

## Submissions
https://leetcode.com/problems/find-customer-referee/submissions/2036055797
Accepted — 7/7 test cases, 332ms

## Open Questions
None.
