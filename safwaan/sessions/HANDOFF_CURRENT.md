# Handoff — 2026-06-17 (Session 3, 5 problems)

## What Was Just Completed

| Session | Problem | LC | Key Pattern |
|---------|---------|-----|-------------|
| 010 | Not Boring Movies | #620 | WHERE + modulo + ORDER BY |
| 011 | Average Selling Price | #1251 | Weighted average + WHERE-kills-LEFT-JOIN + ::numeric + COALESCE |
| 012 | Project Employees I | #1075 | INNER JOIN + AVG + GROUP BY |
| 013 | Percentage of Users Attended a Contest | #1633 | GROUP BY + scalar subquery in SELECT |
| 014 | Queries Quality and Percentage | #1211 | CASE WHEN + conditional aggregation + ::numeric |

## Safwaan's Current State

**Solid:**
- INNER vs LEFT JOIN decision rule — automatic
- Anti-join pattern — automatic
- GROUP BY completeness — **three consecutive clean reps** (LC #1075, #1633, #1211). Call it solid.
- HAVING vs WHERE — used correctly
- CASE WHEN — introduced and used correctly in LC #1211
- Scalar subquery in SELECT — first seen in LC #1633

**Gaps to probe next session:**
- **COUNT(boolean) trap** — hit twice (LC #1934, #1211), still not recalled without prompting. Probe: "if I write COUNT(rating < 3), what does it count?"
- **::numeric cast** — applied independently on SUM in LC #1211, but still needed prompting for `AVG(int/int)` variant. Getting closer.
- **CASE WHEN cold recall** — probe: "how would you count rows where a condition is true inside an aggregation?" without hinting at CASE WHEN.
- **Scalar subquery** — seen once. Will he reach for it independently next time a global total is needed?
- **WHERE-kills-LEFT-JOIN** — seen once in LC #1251. Watch for it next time.

## Suggested Next Problems

- LC #1193 — Monthly Transactions I (Medium) — CASE WHEN + DATE_FORMAT/TO_CHAR, good consolidation
- LC #1174 — Immediate Food Delivery II (Medium) — MIN per group + conditional, good CASE WHEN rep
- LC #550 — Game Play Analysis IV (Medium) — self-join on date offset, good pattern revisit

## Coach Notes

- GROUP BY is now solid — three clean reps in a row. Stop watching for it.
- CASE WHEN landed well. The next problem with conditional aggregation is the real test of whether it was internalized.
- The ::numeric pattern is getting stickier — he applied it independently on the SUM without prompting. The `AVG(int/int)` variant (casting inside the argument) is slightly less obvious; probe it next time.
- COUNT(boolean) trap has now bitten twice. If it comes up a third time without recall, make it an explicit teaching moment about how COUNT works.
- Don't ask reflection questions at wrap-up — pull from what he says during the solve.
