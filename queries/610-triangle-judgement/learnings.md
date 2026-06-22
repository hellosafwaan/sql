Session: [027_2026-06-22_triangle-judgement](../../safwaan/sessions/027_2026-06-22_triangle-judgement.md)

## How It Felt
Clean. Knew it was CASE WHEN immediately. Needed the triangle inequality stated, then wrote it without any further help.

## Key Insight
Row-level labeling — no joins, no aggregation, no subqueries. Just evaluate a condition per row and output a label. This is pure CASE WHEN.

## Solution Walkthrough
The triangle inequality says three sides form a valid triangle if and only if the sum of any two sides is greater than the third. All three conditions must hold simultaneously:
- x + y > z
- y + z > x
- x + z > y

CASE WHEN evaluates these per row and outputs 'Yes' or 'No'. Every row in the input gets exactly one row in the output.

## Pattern Introduced
Row-level CASE WHEN labeling — no joins or aggregation needed when the condition and output are purely within a single row.

## Watch Out For
The triangle inequality requires ALL THREE conditions — it's AND, not OR. Missing one lets through invalid triangles (e.g. sides 1, 2, 10 would pass if you only checked x + y > z).

## Template
```sql
SELECT col1, col2, ...,
    CASE WHEN <condition> THEN 'Yes' ELSE 'No' END AS label
FROM table;
```

## Trace Through
```
x=3, y=4, z=5: 3+4>5 ✓, 4+5>3 ✓, 3+5>4 ✓ → Yes
x=1, y=2, z=3: 1+2>3? No (1+2=3, not >3) → No
```

## Complexity / Correctness
O(n) single table scan, no joins or grouping.

## Submissions
https://leetcode.com/problems/triangle-judgement/submissions/2038010612

## Open Questions
None.
