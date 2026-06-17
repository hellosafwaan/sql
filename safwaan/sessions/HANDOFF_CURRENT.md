# Handoff — 2026-06-17 (Session 3, 2 problems)

## What Was Just Completed

Basic Aggregate Functions (LeetCode SQL 50 section), first two problems.

| Session | Problem | LC | Key Pattern |
|---------|---------|-----|-------------|
| 010 | Not Boring Movies | #620 | WHERE + modulo + ORDER BY |
| 011 | Average Selling Price | #1251 | Weighted average + WHERE-kills-LEFT-JOIN + ::numeric + COALESCE |

## Safwaan's Current State

**Solid:**
- INNER vs LEFT JOIN decision rule — automatic
- Anti-join pattern (LEFT JOIN + WHERE IS NULL) — automatic
- Self-join structure and alias pattern
- CROSS JOIN for all-combinations base set
- HAVING vs WHERE distinction — used correctly
- COALESCE — used with nudge, building
- Weighted average formula — seen once (LC #1251), needs cold probe

**Gaps to probe next session:**
- **GROUP BY completeness** — three occurrences now (LC #1280, #570, #1251). Still fires after runtime error, not before. Must become pre-flight check.
- **WHERE-kills-LEFT-JOIN** — first occurrence in LC #1251. Will he catch it independently next time?
- **::numeric cast** — not recalled unprompted in LC #1251 (second encounter). Needs more reps.
- **CASE WHEN** — still not encountered. Introduce it the moment conditional aggregation comes up.
- **Weighted average formula** — probe: "if I asked you to compute average price per unit sold, what aggregation formula would you use?"

## Suggested Next Problems

Continuing Basic Aggregate Functions (LeetCode SQL 50):
- LC #1075 — Project Employees I (JOIN + AVG, good rounding rep)
- LC #1633 — Percentage of Users Attended a Contest (GROUP BY + COUNT fraction)
- LC #1211 — Queries Quality and Percentage (CASE WHEN will be natural here — ideal introduction point)
- LC #1193 — Monthly Transactions I (conditional aggregation — CASE WHEN)

## Coach Notes

- GROUP BY is the most urgent mechanical fix. Consider probing it explicitly before Safwaan runs next time: "Before you run — check your SELECT. Any non-aggregated columns missing from GROUP BY?"
- LC #1211 (Queries Quality and Percentage) is the ideal CASE WHEN introduction — the problem naturally invites it.
- The WHERE-kills-LEFT-JOIN pattern is high-value and easy to miss silently. Worth flagging if it comes up without error.
- Safwaan's self-correction is improving — he caught GROUP BY himself from the error message in LC #1251. The goal is catching it before running.
