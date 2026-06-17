# Session: Confirmation Rate — 2026-06-17

## What He Attempted
First attempt (wrong COUNT approach):
```sql
select signups.user_id, count(confirmations.action = 'confirmed')/count(confirmations.user_id)
from signups 
left join confirmations on signups.user_id = confirmations.user_id
group by signups.user_id;
```

Then tried `AVG(confirmations.action = 'confirmed')` — Postgres error: `avg(boolean)` doesn't exist.

Then `AVG((confirmations.action = 'confirmed')::integer)` — worked but NULL for user with no confirmations and no rounding.

Then `COALESCE(AVG(...), 0)` — fixed NULL but no rounding. Then added `ROUND(..., 2)` — accepted.

Final:
```sql
select signups.user_id,
    round(coalesce(avg((confirmations.action = 'confirmed')::integer), 0), 2) as confirmation_rate
from signups
left join confirmations on signups.user_id = confirmations.user_id
group by signups.user_id;
```

## Where He Got Stuck
- `COUNT(expr = 'value')` — didn't know COUNT ignores the boolean result
- Didn't know `CASE WHEN` (the standard approach) — introduced `AVG(bool::integer)` as a simpler Postgres alternative
- NULL from AVG on zero rows — needed COALESCE introduced

## Mistakes Made
1. `COUNT(confirmations.action = 'confirmed')` — COUNT only checks non-NULL, ignores boolean truth value
2. `AVG(boolean)` without cast — Postgres type error
3. Missing COALESCE — NULL for users with no confirmations
4. Typo: `COALESE` instead of `COALESCE`
5. `ROUND(...)` without second argument — missing decimal places

## Key Insight
`AVG((col = 'value')::integer)` is an elegant Postgres trick: cast the boolean comparison to 0/1, then average — gives you the fraction of rows where the condition is true.

`COALESCE(value, fallback)` replaces NULL with a default — essential when LEFT JOIN produces NULL in an aggregated column.

## Complexity / Correctness Notes
CASE WHEN is the standard SQL way to do conditional aggregation. The `AVG(bool::integer)` trick is Postgres-specific and elegant but not portable. Worth learning CASE WHEN next time it comes up.

## Coach Notes for Next Session
First encounter with conditional aggregation. CASE WHEN not yet learned — worth introducing as a concept before the next aggregation problem that needs it. COALESCE is now on his radar. Multiple small syntax errors (typo, missing ROUND argument) — these are normal friction, not conceptual gaps.
