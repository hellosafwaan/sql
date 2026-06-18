# Session: User Activity for the Past 30 Days I — 2026-06-18

## What He Attempted
Built it in two stages: first wrote the core aggregation (GROUP BY activity_date + COUNT DISTINCT user_id), then added the date filter. Good instinct to separate concerns.

## Where He Got Stuck
Date arithmetic. Three distinct issues:
1. Missing quotes around the date literal (2019-07-27 vs '2019-07-27')
2. Off-by-one: used -30 instead of -29 (30-day window ending on 2019-07-27 inclusive starts at 2019-06-28, which is 29 days before)
3. BETWEEN with arithmetic in the lower bound caused a Postgres precedence error — the parser tried to interpret the interval expression as part of the BETWEEN operand differently than expected

Also discovered mid-problem that LeetCode was running Postgres, not MySQL (tried MySQL INTERVAL 29 DAY syntax, got a different error).

## Mistakes Made
- Missing quotes on date literal
- -30 instead of -29 for inclusive 30-day window
- Used BETWEEN with a computed lower bound (Postgres precedence issue)
- Tried MySQL INTERVAL syntax on a Postgres problem

## Key Insight
When the lower bound of BETWEEN involves date arithmetic, Postgres has precedence issues. Default to >= / <= instead. Also need ::date cast: `'2019-07-27'::date - INTERVAL '29 days'` — bare string doesn't carry type info.

## Complexity / Correctness Notes
The inclusive window: a "30-day period ending on day X" = days X-29 through X. So subtract 29, not 30.

## Coach Notes for Next Session
- `::date` cast before INTERVAL subtraction — still not automatic. Watch for it.
- BETWEEN with arithmetic lower bound = use >= / <= instead. Good rule of thumb to lock in.
