Session: [019_2026-06-18_user-activity-30-days](../../safwaan/sessions/019_2026-06-18_user-activity-30-days.md)

## How It Felt
Good instinct to build in two steps (aggregation first, then date filter). The date arithmetic was the stumbling block — several syntax issues stacked up.

## Key Insight
Three things to lock in for date-range filtering in Postgres:
1. Date literals need quotes: `'2019-07-27'`, not `2019-07-27`
2. Inclusive 30-day window ending on day X = subtract 29, not 30: day X-29 through day X
3. BETWEEN with a computed lower bound breaks in Postgres — use `>=` and `<=` instead, and cast the string to date with `::date` before subtracting an interval

## Solution Walkthrough
You want daily active users for a 30-day period ending 2019-07-27 inclusive. Break it in two:

**Step 1 — core aggregation:**
```sql
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
GROUP BY activity_date;
```
COUNT(DISTINCT user_id) because a user can have multiple activities on the same day.

**Step 2 — add the date filter:**
The 30-day window ending on 2019-07-27 inclusive starts on 2019-06-28 (29 days before the end date). Why 29? Because you're counting the end date itself as day 1 of the 30.

```sql
WHERE activity_date >= '2019-07-27'::date - INTERVAL '29 days'
  AND activity_date <= '2019-07-27'
```

Why not BETWEEN? In Postgres, `BETWEEN '2019-07-27' - INTERVAL '29 days' AND '2019-07-27'` has precedence issues — the parser misreads the expression. Safe rule: when the lower bound involves arithmetic, use `>=` and `<=`.

Why `::date`? A bare `'2019-07-27'` is just a string. Postgres needs it cast to date before it can subtract an interval from it.

## Pattern Introduced
Date range filter in Postgres: `col >= 'date'::date - INTERVAL 'N days' AND col <= 'date'`

## Watch Out For
- BETWEEN with arithmetic bounds → use >= / <= instead
- String date literal needs `::date` cast before interval arithmetic
- Inclusive N-day window: subtract N-1 days, not N

## Template
```sql
WHERE date_col >= 'end_date'::date - INTERVAL 'N-1 days'
  AND date_col <= 'end_date'
```

## Trace Through
Window: 2019-06-28 to 2019-07-27 (30 days inclusive).
`'2019-07-27'::date - INTERVAL '29 days'` = 2019-06-28. ✓

## Complexity / Correctness
O(n) scan with GROUP BY. COUNT(DISTINCT) adds a small dedup cost per group.

## Submissions
https://leetcode.com/problems/user-activity-for-the-past-30-days-i/submissions/2037586540

## Open Questions
None.
