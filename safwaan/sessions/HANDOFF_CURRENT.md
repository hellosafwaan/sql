# Handoff — 2026-06-18 (Session 5, 7 problems)

## What Was Completed This Session

| Session | Problem | LC | Key Pattern |
|---------|---------|-----|-------------|
| 018 | Number of Unique Subjects | #2356 | COUNT(DISTINCT col) per group |
| 019 | User Activity for the Past 30 Days I | #1141 | COUNT DISTINCT + Postgres date range filter |
| 020 | Product Sales Analysis III | #1070 | Derived-table subquery + two-condition JOIN (3rd application) |
| 021 | Classes More Than 5 Students | #596 | GROUP BY + HAVING COUNT >= N |
| 022 | Find Followers Count | #1729 | GROUP BY + COUNT + ORDER BY |
| 023 | Biggest Single Number | #619 | Outer SELECT MAX from filtered subquery; MAX() on empty = NULL |
| 024 | Customers Who Bought All Products | #1045 | HAVING COUNT(DISTINCT) = scalar subquery in HAVING |

## Safwaan's Current State

**Solid:**
- GROUP BY completeness — 5+ clean reps, call it done
- Derived-table subquery pattern — 3 clean applications (#1174, #550, #1070), self-connected on 3rd. Solid.
- COUNT(DISTINCT col) — applied independently in 3 problems this session
- INNER vs LEFT JOIN decision rule — automatic
- Anti-join pattern — automatic
- CASE WHEN — applies independently
- HAVING vs WHERE distinction — clean

**Gaps to probe next session:**
- **COUNT(boolean) trap** — got it wrong cold at session start today. Still needs explicit probe before each aggregation problem. "If I write COUNT(status = 'confirmed'), what does it count?"
- **Postgres date arithmetic** — `'date'::date - INTERVAL 'N days'` and why BETWEEN fails with computed bounds. Multiple issues hit this session. Probe before next date-filter problem.
- **Off-by-one in inclusive date windows** — N-day window inclusive = subtract N-1. Probe cold.
- **Scalar subquery in HAVING** — new context (previously only in SELECT). Probe: "where else can a scalar subquery live besides SELECT?"
- **"Do I need this JOIN?"** — reached for JOIN unnecessarily twice this session (LC #619, #1045). Before each new problem: "does the output need rows from a second table?"
- **WHERE-kills-LEFT-JOIN** — seen once (LC #1251). Not reinforced this session.

## Suggested Next Problems

From curriculum in order:
- LC #183 — Customers Who Never Order (anti-join cold rep — very fast)
- LC #607 — Sales Person (multi-table anti-join)
- LC #1907 — Count Salary Categories (CASE WHEN bucketing — good consolidation)
- LC #176 — Second Highest Salary (Phase 4 start: DISTINCT + LIMIT/OFFSET or subquery)

## Coach Notes

- COUNT(boolean) — still not automatic. Probe cold every session start.
- The "do I need a JOIN?" probe is now important — he over-reached twice in one session.
- Postgres date arithmetic: when the next date-filter problem comes up, pause before he writes and probe whether he recalls the ::date cast and >= / <= pattern.
- Derived-table subquery is fully locked in — no need to probe anymore.
