# Handoff — 2026-06-18 (Session 3, 6 problems)

## What Was Completed This Session

| Session | Problem | LC | Key Pattern |
|---------|---------|-----|-------------|
| 010 | Not Boring Movies | #620 | WHERE + modulo + ORDER BY |
| 011 | Average Selling Price | #1251 | Weighted average + WHERE-kills-LEFT-JOIN + ::numeric + COALESCE |
| 012 | Project Employees I | #1075 | INNER JOIN + AVG + GROUP BY |
| 013 | Percentage of Users Attended a Contest | #1633 | GROUP BY + scalar subquery in SELECT |
| 014 | Queries Quality and Percentage | #1211 | CASE WHEN + conditional aggregation + ::numeric |
| 015 | Monthly Transactions I | #1193 | TO_CHAR + GROUP BY + CASE WHEN (count & sum variants) |

## Safwaan's Current State

**Solid:**
- INNER vs LEFT JOIN decision rule — automatic
- Anti-join pattern — automatic
- GROUP BY completeness — four consecutive clean reps, call it solid
- CASE WHEN for conditional aggregation — applied independently in LC #1193
- Weighted average formula — seen twice now
- COALESCE — used with nudge, building

**Key gaps for next session:**
- **COUNT(boolean) trap** — THREE occurrences (LC #1934, #1211, #1193). Still not recalled without explicit explanation each time. This is the #1 priority to nail next session. Probe before he writes any aggregate: "if you write COUNT(condition), what does that count?"
- **::numeric cast** — still not recalled for `AVG(int/int)` variant without prompting. The `SUM::numeric` version is getting more instinctive.
- **WHERE-kills-LEFT-JOIN** — seen once in LC #1251. Watch for next LEFT JOIN + range filter.
- **Scalar subquery in SELECT** — first seen in LC #1633. Probe cold next time a global total is needed.
- **TO_CHAR syntax** — first seen in LC #1193. Will he recall `TO_CHAR(date, 'YYYY-MM')` next time?

## Suggested Next Problems

- LC #1174 — Immediate Food Delivery II (Medium) — MIN per group + CASE WHEN, good reps
- LC #550 — Game Play Analysis IV (Medium) — date offset + ratio, good ::numeric rep
- LC #1907 — Count Salary Categories (Medium) — CASE WHEN bucketing, good consolidation

## Coach Notes

- COUNT(boolean) trap is the single most repeated mistake across the whole track. Before the next aggregation problem, probe it cold: "what does COUNT(condition) count?" Don't wait for the mistake.
- GROUP BY is solid — stop watching for it actively.
- CASE WHEN is now in his toolkit — LC #1193 confirmed it. The next test is whether he reaches for it without prompting on a new problem.
- Don't ask reflection questions at wrap-up — pull from what he says during the solve.
