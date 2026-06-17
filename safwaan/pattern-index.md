# SQL — Pattern Index

Maps recurring patterns to the problems where they showed up. Check this at session start once today's problem is known — see CLAUDE.md's Pattern Recall protocol.

## WHERE / Filtering
- LC #620 — Not Boring Movies (WHERE + modulo for odd/even, `<>` vs `NOT LIKE` without wildcards)

## String Functions
*(none yet)*

## Aggregation (GROUP BY / HAVING)
- LC #1581 — Customer Who Visited (GROUP BY after anti-join, COUNT)
- LC #1280 — Students and Examinations (GROUP BY all non-aggregated cols, COUNT(right_col))
- LC #570 — Managers with 5 Direct Reports (HAVING on aggregate — WHERE vs HAVING distinction)
- LC #1934 — Confirmation Rate (conditional aggregation: AVG(bool::integer), COALESCE for NULL fallback)
- LC #1251 — Average Selling Price (weighted average: SUM(price×units)/SUM(units), WHERE-kills-LEFT-JOIN, ::numeric cast, COALESCE for no-sale products)
- LC #1075 — Project Employees I (AVG(int) returns numeric in Postgres — no ::numeric needed; GROUP BY included pre-emptively first time)

## Joins (INNER / LEFT / Self-join / Anti-join)
- LC #1378 — Replace Employee ID (LEFT JOIN, NULL passthrough)
- LC #1068 — Product Sales Analysis I (INNER JOIN, basic two-table)
- LC #1581 — Customer Who Visited (anti-join: LEFT JOIN + WHERE right_col IS NULL)
- LC #197 — Rising Temperature (self-join on date offset)
- LC #1661 — Average Time of Process (self-join with role pinning via activity_type)
- LC #577 — Employee Bonus (anti-join with additional < filter)
- LC #1280 — Students and Examinations (CROSS JOIN + LEFT JOIN)

## CROSS JOIN
- LC #1280 — Students and Examinations (all-combinations base set)

## Subqueries (scalar / correlated / EXISTS)
*(none yet)*

## Window Functions
*(none yet)*

## Date/Time & Pivoting
*(none yet)*

## COUNT(col) vs COUNT(*)
- LC #1581 — Customer Who Visited (theoretical — both equivalent here)
- LC #1280 — Students and Examinations (practical — COUNT(examinations.student_id) needed for 0s)

## PostgreSQL-specific
- LC #1661 — ROUND(avg(...)::numeric, 3) — Postgres requires ::numeric cast for ROUND with decimal places
- LC #197 — date + 1 works in LeetCode's PG mode; real Postgres needs INTERVAL '1 day'
- LC #1251 — integer division truncates: SUM(int)/SUM(int) = int; cast numerator with ::numeric

## Weighted Average
- LC #1251 — Average Selling Price (SUM(value × weight) / SUM(weight); not AVG(col))
