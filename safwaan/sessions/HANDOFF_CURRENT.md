# Handoff — 2026-06-17 (Session 3, 3 problems)

## What Was Just Completed

Basic Aggregate Functions (LeetCode SQL 50), plus Project Employees I.

| Session | Problem | LC | Key Pattern |
|---------|---------|-----|-------------|
| 010 | Not Boring Movies | #620 | WHERE + modulo + ORDER BY |
| 011 | Average Selling Price | #1251 | Weighted average + WHERE-kills-LEFT-JOIN + ::numeric + COALESCE |
| 012 | Project Employees I | #1075 | INNER JOIN + AVG + GROUP BY |

## Safwaan's Current State

**Solid:**
- INNER vs LEFT JOIN decision rule — automatic
- Anti-join pattern — automatic
- Self-join structure
- CROSS JOIN
- HAVING vs WHERE distinction
- GROUP BY completeness — **included pre-emptively first time in LC #1075, no error needed**. Watch whether it holds.

**Gaps to probe next session:**
- **GROUP BY** — one clean rep. Probe: does it hold on the next aggregation problem without any nudge?
- **WHERE-kills-LEFT-JOIN** — first seen in LC #1251. Will he catch it next time independently?
- **::numeric cast** — still not automatic. Two encounters, neither recalled unprompted.
- **CASE WHEN** — still not encountered. LC #1211 (Queries Quality and Percentage) is the ideal introduction.
- **Weighted average formula** — seen once. Probe cold next time units/weights appear.
- **AVG vs SUM/SUM** — `AVG(int)` returns numeric in Postgres (no cast needed); `SUM(int)/SUM(int)` stays integer (cast needed). First distinction made explicit in LC #1075.

## Suggested Next Problems

Continuing Basic Aggregate Functions (LeetCode SQL 50):
- LC #1633 — Percentage of Users Attended a Contest (GROUP BY + COUNT fraction — good rounding rep)
- LC #1211 — Queries Quality and Percentage (**ideal CASE WHEN introduction**)
- LC #1193 — Monthly Transactions I (conditional aggregation with CASE WHEN)

## Coach Notes

- LC #1075 was the first clean first-try solve with GROUP BY included pre-emptively. That's a meaningful milestone — note if it holds.
- LC #1211 is the right moment to introduce CASE WHEN properly. Don't offer the Postgres boolean shortcut first.
- The ::numeric pattern needs one more explicit rep before it becomes instinctive.
