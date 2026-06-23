Session: [000_2026-06-17_phase-1-select-basics](../../safwaan/sessions/000_2026-06-17_phase-1-select-basics.md)

## How It Felt
Clean problem. Two independent conditions that either one satisfies — straightforward OR filter.

## Key Insight
OR means a row passes if *at least one* condition is true. A country with a massive population but small area still qualifies. A country with a huge area but small population still qualifies. You're casting a wider net than AND.

## Solution Walkthrough
A "big country" is defined by the problem as one with area >= 3,000,000 km² OR population >= 25,000,000. These are separate thresholds — meeting either one is enough.

```sql
SELECT name, population, area
FROM World
WHERE area >= 3000000
   OR population >= 25000000;
```

FROM gives you the full World table. WHERE evaluates each row: does it have a large enough area? Or a large enough population? If either condition is true, the row makes it through. SELECT then picks the three output columns.

## Pattern Introduced
WHERE + OR — row filter where satisfying either condition qualifies the row.

## Watch Out For
AND vs OR confusion: AND is stricter (both must be true), OR is looser (either is enough). If you used AND here, you'd only get countries that are simultaneously massive AND populous — a much smaller set.

## Template
```sql
SELECT cols
FROM table
WHERE condition_a >= threshold_1
   OR condition_b >= threshold_2;
```

## Trace Through
| name | population | area | area>=3M | pop>=25M | passes? |
|------|-----------|------|---------|---------|---------|
| Afghanistan | 25500100 | 652230 | No | Yes | Yes |
| Albania | 2831741 | 28748 | No | No | No |
| Algeria | 37100000 | 2381741 | No | Yes | Yes |

## Complexity / Correctness
O(n) scan. No NULLs or duplicates to worry about.

## Submissions
https://leetcode.com/problems/big-countries/submissions/2036058355
Accepted — 7/7 test cases, 332ms

## Open Questions
None.
