# Handoff — 2026-06-22 (Sessions 7–8, 5 problems)

## What Was Completed This Session

| Session | Problem | LC | Key Pattern |
|---------|---------|-----|-------------|
| 027 | Triangle Judgement | #610 | CASE WHEN row-level labeling — clean first attempt |
| 028 | Consecutive Numbers | #180 | Triple self-join on id offset; needed LC #197 reminder |
| 029 | Product Price at a Given Date | #1164 | UNION: derived-table (most recent price) + anti-join (default = 10) |
| 030 | Last Person to Fit in the Bus | #1204 | First window function: SUM() OVER (ORDER BY) running total |
| 031 | Count Salary Categories | #1907 | UNION for guaranteed output categories; COUNT(*) on empty = 0 |

## Safwaan's Current State

**Solid:**
- CASE WHEN — fully independent
- Derived-table subquery — 5+ applications, automatic
- GROUP BY completeness — automatic
- COUNT(DISTINCT col) — automatic
- INNER vs LEFT JOIN decision rule — automatic
- Anti-join (simple standalone cases) — automatic
- UNION for two-case problems — 3 applications, solidifying
- COUNT(*) on empty set = 0 — understands this correctly

**Gaps to probe next session:**
- **Window functions** — brand new this session (LC #1204). `SUM() OVER (ORDER BY)` introduced. Probe cold next time a running total appears.
- **Anti-join in composite context** — needed full walkthrough in LC #1164. Probe: "what does LEFT JOIN return without WHERE IS NULL?"
- **Self-join for consecutive rows** — needed LC #197 reminder in LC #180. Probe cold next adjacency detection problem.
- **UNION vs UNION ALL** — probe cold: "which one deduplicates?"
- **WHERE vs HAVING** — still not fully automatic. Probe before next count-based filter.
- **COUNT(boolean) trap** — probe one more time before retiring.
- **Postgres date arithmetic** — not tested this session. Probe before next date-filter problem.

## Suggested Next Problems

From curriculum in order:
- LC #183 — Customers Who Never Order (anti-join cold rep)
- LC #607 — Sales Person (multi-table anti-join)
- LC #176 — Second Highest Salary (Phase 4 start)
- LC #511 — Game Play Analysis I (Phase 8 warm-up, MIN + GROUP BY — easy entry to window function phase)

## Coach Notes

- Window functions properly start in Phase 8 — LC #1204 was a preview. When Phase 8 begins, PARTITION BY will be the new concept to introduce carefully (it resets the window per group).
- Phase 3 is now 5/6 complete — only LC #1741 (Find Total Time Spent) remaining.
- Phase 7 is 3/6 complete — remaining: LC #182 (Duplicate Emails), LC #181 (Employees Earning More Than Managers), LC #585 (Investments in 2016).
- LC #1907 used UNION instead of the expected CASE WHEN bucketing approach — Safwaan's approach is valid and arguably more reliable (zero-count guarantee). Worth noting CASE WHEN + reference table as an alternative when window functions are in scope.
