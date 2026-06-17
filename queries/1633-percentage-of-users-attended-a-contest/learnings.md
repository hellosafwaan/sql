Session: [013_2026-06-17_percentage-of-users-attended-a-contest](../../safwaan/sessions/013_2026-06-17_percentage-of-users-attended-a-contest.md)

## How It Felt
A few wrong turns on the join and the denominator, but the logic clicked once the right questions were asked. The key lesson was about when you actually need a JOIN vs. when one table already has everything.

## Key Insight
Two things:

1. **Don't reach for a JOIN when one table already has what you need.** The Register table already contains all contest-user pairs. Users who never registered don't appear in the output at all — they only affect the denominator (total count). So there's no need to pull in the Users table with a JOIN; a scalar subquery handles the denominator cleanly.

2. **Scalar subquery in SELECT.** `(SELECT COUNT(*) FROM users)` runs once and returns a single number — the total user count across the whole table. You can use it directly as a divisor in any expression in SELECT. Every row in the result divides by the same total, which is exactly what you want for a percentage.

## Solution Walkthrough
So the question is: for each contest, what percentage of all users registered?

The formula is `(users in contest / total users) * 100`, rounded to 2 decimal places.

**Where's the data?** Register has one row per (contest, user) pair — every registration is there. Total users are in the Users table, but only as a count, not as rows you need to join against.

**First wrong turn — LEFT JOIN.** The instinct was to LEFT JOIN Users with Register so unregistered users show up as NULLs. But unregistered users don't belong in the output at all. The output is one row per contest — not one row per user. Unregistered users just make the denominator larger, which is handled by the subquery. Drop the JOIN.

**Second wrong turn — wrong denominator.** Inside a grouped query, `COUNT(u.user_id)` counts the users in each group — so for a contest with 3 registrations, both numerator and denominator are 3, giving 100% every time. The denominator needs to be a fixed global number: the total user count. That's what `(SELECT COUNT(*) FROM users)` gives you — a scalar that doesn't change per group.

**The fix:** Query Register directly. GROUP BY contest_id gives one group per contest. COUNT(user_id) in the numerator counts registrations per contest. The scalar subquery in the denominator gives the fixed total. Multiply by 100.0 (not 100, to avoid integer division) and ROUND to 2.

```sql
SELECT r.contest_id,
       ROUND(COUNT(r.user_id) * 100.0 / (SELECT COUNT(*) FROM users), 2) AS percentage
FROM register AS r
GROUP BY r.contest_id
ORDER BY percentage DESC, r.contest_id ASC;
```

## Pattern Introduced
- **Scalar subquery in SELECT**: `(SELECT COUNT(*) FROM table)` returns a single number usable as a divisor
- **Don't over-JOIN**: if one table has all the rows you need and the other table only contributes a count, use a subquery for the count instead of joining

## Watch Out For
- `COUNT(col) / COUNT(col)` grouped by the same key always gives 1 — numerator and denominator are the same per group
- `* 100` on integers does integer math in some dialects — use `* 100.0` to force decimal output (Postgres handles this fine with ROUND but good habit)

## Template
```sql
SELECT group_col,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM base_table), 2) AS percentage
FROM detail_table
GROUP BY group_col
ORDER BY percentage DESC, group_col ASC;
```

## Trace Through
Users: 6 total (user_ids 1–6)
Register (sample):
| contest_id | user_id |
|------------|---------|
| 215        | 1       |
| 215        | 2       |
| 215        | 3       |
| 209        | 2       |
| 209        | 4       |

After GROUP BY contest_id:
- contest 215: COUNT = 3, total = 6 → 3/6 * 100 = 50.00%
- contest 209: COUNT = 2, total = 6 → 2/6 * 100 = 33.33%

ORDER BY percentage DESC → 215 first, 209 second.

## Complexity / Correctness
The scalar subquery runs once. Main query is O(n) over Register rows. No fan-out risk since Register has one row per (contest, user) pair.

## Submissions
- https://leetcode.com/problems/percentage-of-users-attended-a-contest/submissions/2036665491

## Open Questions
*(none)*
