# Handoff — 2026-06-22 (Session 9, 7 problems)

## What Was Completed This Session

| Session | Problem | LC | Key Pattern |
|---------|---------|-----|-------------|
| 032 | Fix Names in a Table | #1667 | SUBSTRING + UPPER/LOWER + CONCAT — knew the approach, just needed function name |
| 033 | Patients With a Condition | #1527 | Two LIKE patterns for word-boundary match — fully his reasoning |
| 034 | Delete Duplicate Emails | #196 | DELETE with self-join; Postgres USING syntax given |
| 035 | Second Highest Salary | #176 | LIMIT/OFFSET introduced; outer SELECT null passthrough explained |
| 036 | Group Sold Products By The Date | #1484 | STRING_AGG introduced; DISTINCT placement corrected |
| 037 | List the Products Ordered in a Period | #1327 | JOIN + date range + HAVING — solid independent solve |
| 038 | Find Users With Valid E-Mails | #1517 | First regex problem — full syntax explained, applied correctly |

## Safwaan's Current State

**Solid:**
- CASE WHEN, GROUP BY completeness, COUNT(DISTINCT), anti-join, derived-table subquery — all automatic
- INNER vs LEFT JOIN decision rule — automatic
- String functions: UPPER, LOWER, CONCAT — knows them; SUBSTRING needs the name given once
- LIKE word-boundary patterns — two-case reasoning fully internalized
- WHERE vs HAVING — used correctly without a reminder in LC #1327 (may be solidifying)
- Date range filtering: `>= first_day AND < next_month` — applied independently

**New this session (probe before assuming known):**
- Regex: `~` operator, `^`/`$` anchors, `[char-class]`, `\.` escape — brand new, don't expect cold recall
- STRING_AGG — brand new; probe cold if "comma-separated list" appears
- DELETE ... USING (Postgres) — brand new
- LIMIT/OFFSET for Nth row — new; should stick with one more rep
- Scalar subquery null passthrough (outer SELECT → NULL when empty) — new context

**Still developing:**
- UNION vs UNION ALL — probe cold: "which one deduplicates?"
- Window functions (SUM OVER ORDER BY) — brand new in LC #1204 last session; probe cold
- Self-join for consecutive rows — probe cold next adjacency problem
- Postgres date arithmetic (::date + INTERVAL) — not tested this session; probe before next date problem
- COUNT(boolean) trap — one more cold probe before retiring

## Suggested Next Problems

Phase 2 (one remaining):
- LC #1873 — Calculate Special Bonus (CASE WHEN + modulo — easy win, closes Phase 2)

Phase 4 (just started):
- LC #184 — Department Highest Salary (correlated subquery / window — good complexity jump)

Phase 5 (anti-join cold reps):
- LC #183 — Customers Who Never Order
- LC #607 — Sales Person

## Coach Notes

- Phase 2 is now 4/5 — only Calculate Special Bonus (#1873) remains. CASE WHEN is already solid so it should be fast.
- String functions are now known vocabulary. Regex is not — treat it as fresh territory next time it appears.
- WHERE vs HAVING used correctly twice in a row now — if LC #1873 is clean too, retire that probe.
- This was a high-volume session (7 problems). Safwaan handled the variety well — string, DELETE, aggregation, regex all in one sitting.
