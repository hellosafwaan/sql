# Session: Customers Who Bought All Products — 2026-06-18

## What He Attempted
First instinct was to JOIN Customer with Product. Redirected: "you don't need a JOIN — think about what you're counting." Then correctly landed on GROUP BY customer_id + HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product).

## Where He Got Stuck
Initially missed that this is a counting comparison problem, not a join problem.

## Mistakes Made
- Stray comma after customer_id in SELECT
- Missing parentheses around the scalar subquery in HAVING
- Initially wrote COUNT(product_key) without DISTINCT — would overcount if a customer bought the same product twice

## Key Insight
"Bought all products" = per-customer COUNT(DISTINCT product_key) equals the total product count, which is a scalar subquery. No JOIN needed — the comparison happens entirely within GROUP BY + HAVING.

## Complexity / Correctness Notes
DISTINCT is load-bearing here: without it, a customer who bought product A twice would inflate their count and potentially match falsely.

## Coach Notes for Next Session
- "Do I need this JOIN?" pattern — good to reinforce. Two problems this session where a JOIN was the wrong first instinct (LC #619, LC #1045).
- COUNT(DISTINCT col) in HAVING is now a solid pattern.
- Scalar subquery in HAVING: new context (previous uses were in SELECT). Worth probing cold next time.
