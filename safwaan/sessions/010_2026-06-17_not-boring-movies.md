# Session: Not Boring Movies (LC #620) — 2026-06-17

## What He Attempted
```sql
SELECT cinema.id, cinema.movie, cinema.description, cinema.rating
FROM cinema
WHERE (cinema.id % 2) <> 0
  AND description NOT LIKE 'boring'
ORDER BY rating DESC;
```

## Where He Got Stuck
Not truly stuck — solved first try. The only misstep was using `NOT LIKE 'boring'`, thinking it was a "contains" check. When he realized it didn't work as expected, he immediately switched to `<> 'boring'`. Both actually produce identical results (LIKE without wildcards is exact match), so his first query would have passed too.

## Mistakes Made
- **LIKE mental model**: thought `NOT LIKE 'boring'` excludes rows containing the word "boring" anywhere. In reality, LIKE without `%` or `_` is an exact string match — identical to `<>`. Corrected immediately on his own when he thought it through.

## Key Insight
LIKE without wildcards (`%` or `_`) is the same as `=`. The pattern-matching power of LIKE comes entirely from the wildcard characters. `NOT LIKE 'boring'` and `<> 'boring'` are equivalent. For "contains" matching you need `LIKE '%boring%'`.

## Complexity / Correctness Notes
Simple WHERE filter — O(n) scan. No joins or aggregation, so no GROUP BY or NULL concerns. ORDER BY is applied to the filtered result set.

## Coach Notes for Next Session
- No issues to probe here. Clean solve.
- GROUP BY completeness didn't come up (no aggregation). Will resurface next aggregation problem.
