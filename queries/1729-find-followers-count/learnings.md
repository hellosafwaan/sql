Session: [022_2026-06-18_followers-count](../../safwaan/sessions/022_2026-06-18_followers-count.md)

## How It Felt
Routine. Forgot ORDER BY on first write.

## Key Insight
Always check the output spec for required ordering — LeetCode marks wrong if ORDER BY is missing when the problem states it.

## Solution Walkthrough
Count followers per user — one row per user, count of their followers.

```sql
SELECT user_id, COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id ASC;
```

Straightforward GROUP BY + COUNT. The only gotcha is not forgetting the ORDER BY.

## Pattern Introduced
None new — consolidation of COUNT + GROUP BY.

## Watch Out For
Read the output spec. ORDER BY is sometimes required and LeetCode won't accept the result without it.

## Template
```sql
SELECT group_col, COUNT(val_col) AS count_alias
FROM table
GROUP BY group_col
ORDER BY group_col;
```

## Complexity / Correctness
O(n log n) with ORDER BY.

## Submissions
https://leetcode.com/problems/find-followers-count/submissions/2037691796

## Open Questions
None.
