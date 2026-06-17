# SQL — Mistake Patterns & Breakthroughs

## Mistake Patterns

### INNER JOIN as default (2026-06-17, LC #1378)
First instinct on a "show all X with their Y" problem was INNER JOIN — which drops rows with no match. Fixed immediately after seeing the actual output missing rows. This is a common beginner default; watch whether it recurs after a few more LEFT JOIN reps.

### Timestamp ordering as role proxy (2026-06-17, LC #1661)
Used `t1.timestamp < t2.timestamp` to distinguish start from end rows in a self-join. This works until timestamps are equal (zero-duration process), which caused a wrong answer. The fix: use the `activity_type` column directly in the JOIN condition. Lesson: when a column already encodes the role, use it — don't infer from ordering.

### Partial GROUP BY (2026-06-17, LC #1280)
Wrote `GROUP BY subjects.subject_name` when SELECT had `student_id`, `student_name`, and `subject_name`. Needed explicit explanation: every non-aggregated column in SELECT must appear in GROUP BY. Not yet automatic.

### COUNT(left_table.col) instead of COUNT(right_table.col) (2026-06-17, LC #1280)
Used `COUNT(students.student_id)` which is never NULL → always counts at least 1, even for students who never attended. Fixed to `COUNT(examinations.student_id)` which is NULL for unmatched rows → correctly returns 0. Had already articulated this distinction theoretically in LC #1581; needed a nudge to apply it in practice.

### GROUP BY completeness — recurring (2026-06-17, LC #1280, LC #570, LC #1251)
Hit this error three times across two sessions. SELECT includes a non-aggregated column that's missing from GROUP BY. Postgres runtime error catches it each time. Still not automatic before running — must become reflex.

### Over-joining when a subquery suffices (2026-06-17, LC #1633)
Reached for LEFT JOIN users + register to get unregistered users as NULLs. But the output was per contest — unregistered users don't appear at all. They only affect the denominator, which a scalar subquery handles cleanly. Fix: query Register directly, use `(SELECT COUNT(*) FROM users)` for the total. Default question to ask before joining: "does the output actually need rows from both tables, or just a count from one?"

### LIKE without wildcards = exact match (2026-06-17, LC #620)
Used `NOT LIKE 'boring'` expecting it to exclude rows where description *contains* "boring". LIKE without `%` or `_` is an exact string match — identical to `<> 'boring'`. Both queries actually pass; the mental model was the issue. For a "contains" check: `LIKE '%value%'`.

### WHERE filter on right-table column kills LEFT JOIN (2026-06-17, LC #1251)
Added LEFT JOIN to preserve products with no sales, then put BETWEEN in WHERE. WHERE filters happen after the join — NULL rows from unmatched products fail the BETWEEN condition and get dropped. Effectively turns LEFT JOIN back into INNER JOIN. Fix: move the filter into the ON clause.

### Weighted average ≠ AVG(col) (2026-06-17, LC #1251)
Used `AVG(price * units)` then `AVG(price)` — both wrong. The average price per unit is `SUM(price * units) / SUM(units)` — total revenue divided by total units. Clicked after the concrete example: 100 units at $5 and 1 unit at $10 gives ~$5.09, not $7.50.

### Integer division / ::numeric — still not instinctive (2026-06-17, LC #1251)
Hit the same Postgres integer division issue as LC #1934. Didn't recall the `::numeric` fix unprompted — needed the direct answer again. Pattern not yet automatic.

### COUNT(col = 'value') doesn't do what you think (LC #1934, #1211, #1193 — three times)
Used `COUNT(action = 'confirmed')`, `COUNT(rating < 3)`, `COUNT(state = 'approved')` expecting conditional counts. COUNT ignores boolean truth — it only checks non-NULL. Boolean expressions never return NULL, so COUNT counts every row. The fix: `SUM(CASE WHEN condition THEN 1 ELSE 0 END)`. Hit three times now — still not recalled without prompting. Must become automatic.

---

## Breakthroughs

### Anti-join pattern locked in fast (2026-06-17)
Applied the LEFT JOIN + IS NULL anti-join pattern correctly and independently on LC #1581, then again on LC #577 without any prompting. By the third application it was fully automatic.

### Role pinning insight (2026-06-17, LC #1661)
After several wrong turns with timestamp ordering, clicked on "use the column that tells you the role." This is a genuinely non-obvious insight that took some guided questions — but once it landed, it was clearly understood. Worth probing on revisit.

### Decision rule for INNER vs LEFT (2026-06-17)
Articulated the rule clearly after LC #1068: "Do I need rows with no match, or only rows that match?" This is the right mental model. Consistently applied correctly after that.

---

## What's Solid
- LEFT JOIN for NULL passthrough
- Anti-join pattern (LEFT JOIN + WHERE right_col IS NULL)
- Self-join structure and alias pattern
- CROSS JOIN for all-combinations base set
- COUNT(col) vs COUNT(*) — conceptually solid when he sees wrong output; not yet pre-emptive
- INNER vs LEFT JOIN decision rule
- GROUP BY completeness — four consecutive clean reps, call it solid
- CASE WHEN for conditional aggregation — used correctly independently

## What's Still Developing
- GROUP BY completeness — hit this error three times (LC #1280, #570, #1251). Must become reflex.
- CASE WHEN — not yet encountered. Next time conditional aggregation comes up, introduce it properly.
- PostgreSQL-specific syntax: `::numeric` cast — hit again in LC #1251, still not recalled automatically
- Role pinning in self-joins — correct but took guided questions to arrive at; worth a cold revisit
- WHERE-kills-LEFT-JOIN — new pattern from LC #1251, only seen once. Probe next time a LEFT JOIN + date filter appears.
- Weighted average formula — seen once in LC #1251. Probe cold next time units/weights appear in aggregation.
