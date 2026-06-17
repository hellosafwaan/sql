# Handoff — 2026-06-17 (Sessions 1–2, 9 problems)

## What Was Just Completed

Full Basic Joins section of the LeetCode SQL 50, plus 2 bonus problems. 9 problems total across two batches.

| Session | Problem | LC | Key Pattern |
|---------|---------|-----|-------------|
| 001 | Replace Employee ID | #1378 | LEFT JOIN, NULL passthrough |
| 002 | Product Sales Analysis I | #1068 | INNER JOIN |
| 003 | Customer Who Visited (No Transactions) | #1581 | Anti-join + GROUP BY |
| 004 | Rising Temperature | #197 | Self-join on date offset |
| 005 | Average Time of Process per Machine | #1661 | Self-join + role pinning |
| 006 | Employee Bonus | #577 | Anti-join + OR filter |
| 007 | Students and Examinations | #1280 | CROSS JOIN + LEFT JOIN + COUNT(col) |
| 008 | Managers with at Least 5 Direct Reports | #570 | Self-join + GROUP BY + HAVING |
| 009 | Confirmation Rate | #1934 | LEFT JOIN + conditional aggregation + COALESCE |

## Safwaan's Current State

**Solid:**
- INNER vs LEFT JOIN decision rule — automatic
- Anti-join pattern (LEFT JOIN + WHERE IS NULL) — automatic, no prompting needed
- Self-join structure and alias pattern
- CROSS JOIN for all-combinations base set
- HAVING vs WHERE distinction — used correctly, may not be fully articulated yet
- COALESCE — introduced, on his radar

**Gaps to probe next session:**
- GROUP BY completeness — hit this error twice today (LC #1280 and #570). Will it be automatic next time?
- CASE WHEN — not yet encountered. Introduce it next time conditional aggregation comes up.
- HAVING vs WHERE — probe: "why can't you put COUNT(...) >= 5 in WHERE?"
- COUNT(col = 'value') trap — confirm he understands why it doesn't work
- Role pinning cold recall — can he explain the LC #1661 lesson from scratch?

## Suggested Next Problems

LeetCode SQL 50 continues with "Basic Aggregation" section:
- LC #1251 — Average Selling Price
- LC #1075 — Project Employees I
- LC #1633 — Percentage of Users Attended a Contest
- LC #1211 — Queries Quality and Percentage

Or pick up the curriculum where it's missing coverage — Phases 1–2 (SELECT basics, string functions) are untouched.

## Coach Notes

- Strong first day overall. JOIN patterns are clearly clicking.
- GROUP BY completeness is the main mechanical gap — watch for it every time aggregation appears.
- CASE WHEN is the most important thing not yet seen. Introduce it the moment it's relevant rather than offering the Postgres boolean shortcut again.
- Prefers to batch problems in one session and wrap up at the end — format is working well.
