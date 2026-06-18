Session: [023_2026-06-18_biggest-single-number](../../safwaan/sessions/023_2026-06-18_biggest-single-number.md)

## How It Felt
Felt weird at first. Got tangled up trying to do everything in one GROUP BY, then reached for an unnecessary JOIN before landing on the clean two-step.

## Key Insight
Two-step: filter to single numbers with GROUP BY + HAVING, then wrap in an outer SELECT MAX() to pick the largest. No JOIN needed when you're just selecting from a subquery. And MAX() on an empty set returns NULL automatically — the edge case is free.

## Solution Walkthrough
A "single number" appears exactly once. You need the largest one.

**Step 1 — find all single numbers:**
```sql
SELECT num
FROM MyNumbers
GROUP BY num
HAVING COUNT(num) = 1
```

This gives you all values that appear exactly once.

**Step 2 — take the max of those:**
```sql
SELECT MAX(num) AS num
FROM (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(num) = 1
) AS singles;
```

Why not JOIN? You're not pulling columns from a second table — you're just aggregating a set of numbers. Wrapping in a SELECT MAX() is all you need.

Why does NULL work? If no single numbers exist, the subquery returns zero rows. MAX() on zero rows = NULL. No COALESCE required.

## Pattern Introduced
Outer aggregate over a filtered subquery. When you need "max/min of a filtered subset", don't JOIN — just SELECT MAX() FROM (filtered subquery).

## Watch Out For
- Don't try to do both filtering and MAX in one GROUP BY query — it doesn't collapse to a single row
- MAX() on empty set = NULL in both Postgres and MySQL

## Template
```sql
SELECT MAX(col) AS result
FROM (
    SELECT col
    FROM table
    GROUP BY col
    HAVING COUNT(*) = 1  -- or whatever filter
) AS filtered;
```

## Trace Through
| num |
|-----|
| 8   |
| 8   |
| 3   |
| 7   |
| 7   |

Single numbers: {3} (8 appears twice, 7 appears twice)
MAX(3) = 3

If table = {8, 8, 7, 7}: no singles → subquery returns empty → MAX() = NULL ✓

## Complexity / Correctness
O(n log n) for GROUP BY. MAX() over subquery is O(k) where k = count of single numbers.

## Submissions
https://leetcode.com/problems/biggest-single-number/submissions/2037718040

## Open Questions
None.
