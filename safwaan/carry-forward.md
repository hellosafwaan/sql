# SQL — Carry-Forward Questions

Open questions to probe in upcoming sessions. Mark answered items inline when they come up.

## Open

- **GROUP BY completeness** — included pre-emptively for the first time in LC #1075 (no runtime error needed). Watch whether this holds consistently going forward.
- **Role pinning revisit (LC #1661)** — can he explain from cold why `t1.timestamp < t2.timestamp` breaks on equal timestamps and why activity_type in the JOIN is the right fix?
- **COUNT(col) vs COUNT(*) in practice** — he understands the theory; will he apply it correctly next time a LEFT JOIN feeds into COUNT without a nudge?
- **Postgres `::numeric` cast** — will he remember this, or will he hit the same runtime error again?
- **CASE WHEN** — not yet learned. Introduce it next time conditional aggregation comes up. The `AVG(bool::integer)` trick works in Postgres but CASE WHEN is standard SQL and will appear everywhere.
- **COALESCE** — used correctly in LC #1251 after nudge. Will he reach for it instinctively next time a LEFT JOIN produces NULLs in an aggregate?
- **HAVING vs WHERE** — correctly used HAVING in LC #570 but may not have fully articulated the difference. Probe: "why can't you put COUNT(...) >= 5 in a WHERE clause?"
- **Scalar subquery in SELECT** — first seen in LC #1633. Will he reach for it independently next time a global total is needed as a divisor?
- **"Do I need this JOIN?"** — probe before he reaches for a JOIN: "does the output need rows from both tables, or just a count from one?"
- **WHERE-kills-LEFT-JOIN** — new pattern from LC #1251. Will he catch this independently next time a LEFT JOIN + range filter appears, or will he put the filter in WHERE again?
- **Weighted average formula** — `SUM(value * weight) / SUM(weight)` — seen once in LC #1251. Will he distinguish this from `AVG(col)` without prompting next time?
- **::numeric cast** — still not recalled automatically (needed direct answer in LC #1251, same as first time in LC #1934). Needs more reps.
