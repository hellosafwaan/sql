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

### GROUP BY completeness — recurring (2026-06-17, LC #1280 and LC #570)
Hit the same error twice in the same session: SELECT includes a non-aggregated column that's missing from GROUP BY. Postgres runtime error catches it both times. Not yet automatic — needs more reps before it becomes reflex.

### COUNT(col = 'value') doesn't do what you think (2026-06-17, LC #1934)
Used `COUNT(action = 'confirmed')` expecting it to count only confirmed rows. COUNT ignores boolean truth — it only checks non-NULL. The fix: `AVG((col = 'value')::integer)` for a fraction, or `SUM(CASE WHEN col = 'value' THEN 1 ELSE 0 END)` for a count.

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
- COUNT(col) vs COUNT(*) — conceptually solid, needs practice applying it automatically
- INNER vs LEFT JOIN decision rule

## What's Still Developing
- GROUP BY completeness — hit this error twice in one session (LC #1280 and #570). Must become reflex.
- CASE WHEN — not yet encountered. Next time conditional aggregation comes up, introduce it properly.
- PostgreSQL-specific syntax: `::numeric`, `::integer`, `INTERVAL '1 day'`, `COALESCE` — accumulating, needs reps
- Role pinning in self-joins — correct but took guided questions to arrive at; worth a cold revisit
