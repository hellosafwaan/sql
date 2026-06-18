# Session: Find Followers Count — 2026-06-18

## What He Attempted
GROUP BY user_id + COUNT(follower_id). Forgot ORDER BY user_id on the first write.

## Where He Got Stuck
Nowhere — just needed a reminder about ORDER BY.

## Mistakes Made
Omitted ORDER BY user_id ASC (required by problem statement).

## Key Insight
Always check the output spec for required ordering — LeetCode will reject a correct aggregation if the ORDER BY is missing when specified.

## Complexity / Correctness Notes
Clean O(n) aggregation.

## Coach Notes for Next Session
Nothing notable.
