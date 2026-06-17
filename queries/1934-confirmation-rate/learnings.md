Session: [009_2026-06-17_confirmation-rate](../../safwaan/sessions/009_2026-06-17_confirmation-rate.md)

## How It Felt
Harder than expected. The core logic (LEFT JOIN + group by user) came quickly, but getting the conditional count right took several iterations. Introduced three new tools in one problem: conditional aggregation, COALESCE, and the ::integer cast trick.

## Key Insight
`COUNT(col = 'value')` doesn't work — COUNT only checks for non-NULL, it ignores whether the boolean is true or false. The Postgres way to count rows matching a condition: `AVG((col = 'value')::integer)` — cast the boolean to 0/1 then average, which gives the fraction of matching rows. Wrap in COALESCE to replace NULL (users with no rows) with 0.

## Solution Walkthrough
We want: for each user, what fraction of their confirmation requests were 'confirmed'? Users with no requests get 0.

Step 1 — LEFT JOIN so users with no confirmations are included:
```sql
FROM signups
LEFT JOIN confirmations ON signups.user_id = confirmations.user_id
```

Step 2 — GROUP BY user:
```sql
GROUP BY signups.user_id
```

Step 3 — compute the rate. The trap: `COUNT(action = 'confirmed')` counts all non-NULL rows, not just the 'confirmed' ones. Instead, cast the boolean comparison to integer (true→1, false→0) and take the average:
```sql
AVG((confirmations.action = 'confirmed')::integer)
```

This gives 0.33 for a user with 1 confirmed out of 3, 0 for all timeouts, 1.0 for all confirmed.

Step 4 — users with no confirmations: AVG of zero rows = NULL. Fix with COALESCE:
```sql
COALESCE(AVG(...), 0)
```

Step 5 — round to 2 decimal places:
```sql
ROUND(COALESCE(AVG(...), 0), 2)
```

## Pattern Introduced
**Conditional aggregation** — computing a fraction of rows that match a condition. Standard SQL uses `CASE WHEN`:
```sql
SUM(CASE WHEN col = 'value' THEN 1 ELSE 0 END) / COUNT(*)
```
Postgres shortcut: `AVG((col = 'value')::integer)`

**COALESCE(value, fallback)** — returns the first non-NULL argument. Essential when a LEFT JOIN can produce NULL in an aggregated result.

## Watch Out For
- `COUNT(col = 'value')` is wrong — COUNT ignores boolean truth, only checks non-NULL.
- `AVG(boolean)` without `::integer` cast fails in Postgres — must cast first.
- Users with zero rows in the right table after LEFT JOIN produce NULL from AVG — always COALESCE when the left table might have unmatched rows.
- `COALESCE` is spelled with two E's: C-O-A-L-E-S-C-E.

## Template
```sql
SELECT l.user_id,
    ROUND(COALESCE(AVG((r.col = 'target_value')::integer), 0), 2) as rate
FROM left_table l
LEFT JOIN right_table r ON l.id = r.id
GROUP BY l.user_id;
```

## Trace Through
User 6: no rows in Confirmations → AVG(NULL) = NULL → COALESCE → 0.00
User 3: 2 rows, both 'timeout' → AVG(0, 0) = 0 → ROUND → 0.00
User 7: 3 rows, all 'confirmed' → AVG(1, 1, 1) = 1.0 → ROUND → 1.00
User 2: 2 rows, 1 confirmed + 1 timeout → AVG(1, 0) = 0.5 → ROUND → 0.50

## Complexity / Correctness
O(n) with index on user_id. The `AVG(bool::integer)` approach is Postgres-specific — standard SQL uses CASE WHEN, which is portable across all dialects.

## Submissions
https://leetcode.com/problems/confirmation-rate/submissions/2036452810

## Open Questions
- Learn `CASE WHEN` properly — it's the standard way to do conditional values and will appear often.
