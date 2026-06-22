# SQL — Pattern Index

Maps recurring patterns to the problems where they showed up. Check this at session start once today's problem is known — see CLAUDE.md's Pattern Recall protocol.

## WHERE / Filtering
- LC #620 — Not Boring Movies (WHERE + modulo for odd/even, `<>` vs `NOT LIKE` without wildcards)

## String Functions
- LC #1667 — Fix Names in a Table (UPPER/LOWER + SUBSTRING + CONCAT; SUBSTRING(1,1) vs MySQL quirk SUBSTRING(0,2))
- LC #1527 — Patients With a Condition (LIKE word-boundary: two patterns cover "first code" and "later code")
- LC #1517 — Find Users With Valid E-Mails (Postgres `~` regex operator; `^`, `$`, character classes, `\.` escape)
- LC #1484 — Group Sold Products By The Date (STRING_AGG(DISTINCT col, sep ORDER BY col); MySQL equiv: GROUP_CONCAT)

## Aggregation (GROUP BY / HAVING)
- LC #1581 — Customer Who Visited (GROUP BY after anti-join, COUNT)
- LC #1280 — Students and Examinations (GROUP BY all non-aggregated cols, COUNT(right_col))
- LC #570 — Managers with 5 Direct Reports (HAVING on aggregate — WHERE vs HAVING distinction)
- LC #596 — Classes More Than 5 Students (HAVING COUNT >= N, clean application)
- LC #1934 — Confirmation Rate (conditional aggregation: AVG(bool::integer), COALESCE for NULL fallback)
- LC #1251 — Average Selling Price (weighted average: SUM(price×units)/SUM(units), WHERE-kills-LEFT-JOIN, ::numeric cast, COALESCE for no-sale products)
- LC #1075 — Project Employees I (AVG(int) returns numeric in Postgres — no ::numeric needed; GROUP BY included pre-emptively first time)
- LC #1211 — Queries Quality and Percentage (CASE WHEN conditional aggregation, AVG(int::numeric/int) for ratio, ::numeric on SUM for percentage)
- LC #1045 — Customers Who Bought All Products (HAVING with scalar subquery comparison)

## DELETE with Self-join
- LC #196 — Delete Duplicate Emails (Postgres: DELETE FROM t1 USING t2 WHERE join + filter; MySQL: DELETE t1 FROM t1 JOIN t2)

## LIMIT / OFFSET (Nth row)
- LC #176 — Second Highest Salary (ORDER BY DESC + LIMIT 1 OFFSET N-1; wrap in outer SELECT for NULL passthrough)

## Joins (INNER / LEFT / Self-join / Anti-join)
- LC #1378 — Replace Employee ID (LEFT JOIN, NULL passthrough)
- LC #1068 — Product Sales Analysis I (INNER JOIN, basic two-table)
- LC #1581 — Customer Who Visited (anti-join: LEFT JOIN + WHERE right_col IS NULL)
- LC #197 — Rising Temperature (self-join on date offset)
- LC #1661 — Average Time of Process (self-join with role pinning via activity_type)
- LC #577 — Employee Bonus (anti-join with additional < filter)
- LC #1280 — Students and Examinations (CROSS JOIN + LEFT JOIN)
- LC #1731 — Number of Employees Which Report to Each Employee (self-join: manager vs reportee roles; GROUP BY + ROUND(AVG))

## CROSS JOIN
- LC #1280 — Students and Examinations (all-combinations base set)

## Subqueries (scalar / correlated / EXISTS)
- LC #1633 — Percentage of Users Attended a Contest (scalar subquery in SELECT as global denominator)
- LC #1174 — Immediate Food Delivery II (derived table in FROM: subquery to get per-group MIN, JOIN back on two conditions to recover full row)
- LC #550 — Game Play Analysis IV (same pattern + date offset: first_login + 1; fraction vs percentage distinction)
- LC #1070 — Product Sales Analysis III (third application of derived-table pattern: MIN(year) per product, two-condition JOIN)
- LC #619 — Biggest Single Number (outer SELECT MAX from filtered subquery)
- LC #1045 — Customers Who Bought All Products (scalar subquery in HAVING: HAVING COUNT(DISTINCT x) = (SELECT COUNT(*) FROM ref))

## Window Functions
*(none yet)*

## Date/Time & Pivoting
- LC #1193 — Monthly Transactions I (TO_CHAR(date, 'YYYY-MM') for month grouping; must appear in GROUP BY)

## COUNT(DISTINCT col)
- LC #2356 — Number of Unique Subjects (COUNT(DISTINCT subject_id) per teacher group)
- LC #1141 — User Activity 30 Days (COUNT(DISTINCT user_id) per day)
- LC #1045 — Customers Who Bought All Products (COUNT(DISTINCT product_key) in HAVING)

## COUNT(col) vs COUNT(*)
- LC #1581 — Customer Who Visited (theoretical — both equivalent here)
- LC #1280 — Students and Examinations (practical — COUNT(examinations.student_id) needed for 0s)

## "Bought All" / Relational Division
- LC #1045 — Customers Who Bought All Products (HAVING COUNT(DISTINCT col) = (SELECT COUNT(*) FROM ref_table))

## Outer Aggregate Over Filtered Subquery
- LC #619 — Biggest Single Number (SELECT MAX(num) FROM (subquery with HAVING) — no JOIN needed; MAX() on empty = NULL)

## PostgreSQL-specific
- LC #1661 — ROUND(avg(...)::numeric, 3) — Postgres requires ::numeric cast for ROUND with decimal places
- LC #197 — date + 1 works in LeetCode's PG mode; real Postgres needs INTERVAL '1 day'
- LC #1251 — integer division truncates: SUM(int)/SUM(int) = int; cast numerator with ::numeric
- LC #1141 — BETWEEN with arithmetic lower bound fails; use >= / <= ; need ::date cast before INTERVAL subtraction

## Weighted Average
- LC #1251 — Average Selling Price (SUM(value × weight) / SUM(weight); not AVG(col))

## Date Range Filtering (Postgres)
- LC #1141 — User Activity 30 Days (col >= 'date'::date - INTERVAL 'N days' AND col <= 'date'; inclusive window = N-1 days back)

## UNION / UNION ALL
- LC #1789 — Primary Department for Each Employee (UNION for two-case conditional selection; UNION deduplicates, UNION ALL keeps all rows)
- LC #1164 — Product Price at a Given Date (UNION combining derived-table case 1 with anti-join case 2 for default value)

## Two-Case Conditional Selection
- LC #1789 — Primary Department for Each Employee (case 1: explicit flag; case 2: single-department employee → combine with UNION)
- LC #1164 — Product Price at a Given Date (case 1: derived-table for most recent price; case 2: anti-join for default price = 10)

## Consecutive Row Detection (Self-join on id offset)
- LC #180 — Consecutive Numbers (alias table 3x, chain id + 1 in JOIN, WHERE for equal values, DISTINCT for dedup)

## Window Functions
- LC #1204 — Last Person to Fit in the Bus (SUM(weight) OVER (ORDER BY turn) for running total; wrap in subquery to filter on result)

## UNION for Guaranteed Output Categories
- LC #1907 — Count Salary Categories (hardcode category per SELECT, UNION to combine; COUNT(*) on empty = 0 ensures row always appears)
