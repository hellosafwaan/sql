# Session: Percentage of Users Attended a Contest (LC #1633) — 2026-06-17

## What He Attempted
**Attempt 1:**
```sql
SELECT r.contest_id, (COUNT(r.user_id) / COUNT(u.user_id)) * 100 AS percentage
FROM users AS u
LEFT JOIN register AS r ON u.user_id = r.user_id
GROUP BY r.contest_id;
```
Wrong: LEFT JOIN unnecessary; denominator counts per group not total; integer division.

**Attempt 2 (after guided questions) → Accepted:**
```sql
SELECT r.contest_id,
       ROUND(COUNT(r.user_id) * 100.0 / (SELECT COUNT(*) FROM users), 2) AS percentage
FROM register AS r
GROUP BY r.contest_id
ORDER BY percentage DESC, r.contest_id ASC;
```

## Where He Got Stuck
1. **Unnecessary LEFT JOIN** — instinct was to join Users + Register so unregistered users appear. Unblocked by: "do you need those users in your output?" — realised the output is per contest, not per user.
2. **Wrong denominator** — `COUNT(u.user_id)` inside a grouped query counts per group, not total. Unblocked by explaining that numerator and denominator would be equal per group (always 100%). Fix: scalar subquery `(SELECT COUNT(*) FROM users)`.

## Mistakes Made
- **Over-joining** — reached for LEFT JOIN when the Register table already had all needed rows; unregistered users only affect the denominator (handled by subquery)
- **Per-group denominator** — `COUNT(col)` inside GROUP BY gives the group count, not the table total

## Key Insight
A scalar subquery in SELECT — `(SELECT COUNT(*) FROM users)` — returns one fixed number that every row divides by. This is the right tool when you need a global aggregate as part of a per-group calculation.

## Complexity / Correctness Notes
Scalar subquery runs once. O(n) over Register. No join needed, no fan-out risk.

## Coach Notes for Next Session
- First introduction to scalar subquery in SELECT — probe cold on next problem where a global total is needed.
- The "do I actually need this JOIN?" question is worth making a habit. He accepted the redirect quickly once asked.
- GROUP BY included correctly without prompting again — second consecutive clean rep.
