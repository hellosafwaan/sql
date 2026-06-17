Session: [010_2026-06-17_not-boring-movies](../../safwaan/sessions/010_2026-06-17_not-boring-movies.md)

## How It Felt
Quick and clean. The logic was straightforward — two filter conditions and an ORDER BY. The only friction was a misunderstanding about what LIKE actually does without wildcards, which was a quick correction.

## Key Insight
`LIKE 'boring'` (no `%` or `_`) is identical to `= 'boring'` — it does exact string matching, not "contains". The wildcard characters are what give LIKE its pattern-matching power: `%` for any sequence, `_` for a single character. So `NOT LIKE 'boring'` and `<> 'boring'` both would have passed. First instinct was wrong mental model ("LIKE means contains"), but the fix was immediate once caught.

## Solution Walkthrough
So the problem is just: filter the cinema table down to movies that meet two conditions, then sort. Nothing joined, nothing grouped.

Starting from `FROM cinema` — you have every row. Then WHERE applies both filters at once:

First condition: `id % 2 <> 0` — the modulo operator gives you the remainder when you divide by 2. If it's 0, the ID is even. So `<> 0` keeps only odd-numbered IDs.

Second condition: `description <> 'boring'` — direct string comparison. Watch out for LIKE here — `NOT LIKE 'boring'` looks like a "contains" check but actually does exact match since there's no `%`. Use `<>` for clarity.

Then `ORDER BY rating DESC` — highest rated movies first.

No joins, no aggregation. This one is purely about WHERE clause mechanics.

## Pattern Introduced
- Modulo for odd/even check: `id % 2 <> 0` (odd), `id % 2 = 0` (even)
- LIKE without wildcards = exact match (same as `=`)

## Watch Out For
- `NOT LIKE 'value'` looks like a "contains" exclusion but is really `<> 'value'` — include `%` if you want "does not contain": `NOT LIKE '%value%'`

## Template
```sql
SELECT cols
FROM table
WHERE numeric_col % 2 <> 0        -- odd-numbered rows
  AND string_col <> 'excluded'     -- exact string exclusion
ORDER BY sort_col DESC;
```

## Trace Through
Input (Cinema):

| id | movie | description | rating |
|----|-------|-------------|--------|
| 1  | War   | great 3D    | 8.9    |
| 2  | Science | fiction  | 8.5    |
| 3  | irish | boring     | 6.2    |
| 4  | Ice song | Fantacy  | 8.6  |
| 5  | House card | Interesting | 9.1 |

After WHERE (odd id AND not boring):
- id=1 ✅ (odd, not boring)
- id=2 ❌ (even)
- id=3 ❌ (boring)
- id=4 ❌ (even)
- id=5 ✅ (odd, not boring)

After ORDER BY rating DESC:
| 5  | House card | Interesting | 9.1 |
| 1  | War        | great 3D    | 8.9 |

## Complexity / Correctness
O(n) scan — single table, no joins or aggregation. Just filtering and sorting.

## Submissions
- https://leetcode.com/problems/not-boring-movies/submissions/2036524279

## Open Questions
*(none)*
