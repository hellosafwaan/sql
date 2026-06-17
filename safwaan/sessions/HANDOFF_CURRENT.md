# Handoff — 2026-06-17 (Session 3, 4 problems)

## What Was Just Completed

| Session | Problem | LC | Key Pattern |
|---------|---------|-----|-------------|
| 010 | Not Boring Movies | #620 | WHERE + modulo + ORDER BY |
| 011 | Average Selling Price | #1251 | Weighted average + WHERE-kills-LEFT-JOIN + ::numeric + COALESCE |
| 012 | Project Employees I | #1075 | INNER JOIN + AVG + GROUP BY |
| 013 | Percentage of Users Attended a Contest | #1633 | GROUP BY + scalar subquery in SELECT |

## Safwaan's Current State

**Solid:**
- INNER vs LEFT JOIN decision rule — automatic
- Anti-join pattern — automatic
- GROUP BY completeness — **two consecutive clean reps** (LC #1075 and #1633) with no runtime error. Watch whether it holds.
- HAVING vs WHERE distinction — used correctly
- Weighted average formula — seen once, needs cold probe

**Gaps to probe next session:**
- **Scalar subquery in SELECT** — first seen in LC #1633. Will he reach for it independently next time a global total is needed?
- **"Do I need this JOIN?"** — still defaults to joining. Probe before he writes the FROM clause: does the output need rows from both tables?
- **::numeric cast** — still not recalled automatically. Third encounter likely coming up.
- **CASE WHEN** — still not encountered. LC #1211 is the ideal introduction.
- **WHERE-kills-LEFT-JOIN** — seen once in LC #1251. Watch for it next time LEFT JOIN + range filter appears.

## Suggested Next Problems

- LC #1211 — Queries Quality and Percentage (**CASE WHEN introduction** — ideal next problem)
- LC #1193 — Monthly Transactions I (conditional aggregation)

## Coach Notes

- Don't ask Safwaan reflection questions at wrap-up — he provides his thinking verbally as he works. Pull from that.
- LC #1211 is the right moment to introduce CASE WHEN. Don't offer the Postgres boolean shortcut.
- GROUP BY is looking more stable — two clean reps. One more and it's probably solid.
- The scalar subquery pattern is high-value and appeared naturally in LC #1633. Probe it cold next problem that needs a global aggregate.
