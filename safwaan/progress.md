# Safwaan — Progress (SQL Track)

## Current Phase
**Phase 2 — String & Date Functions** (4/5 — only Calculate Special Bonus #1873 remaining). **Phase 3** complete (5/6 + bonuses). Also active: Phase 4 (1/5), Phase 5 (3/5), Phase 6 (3/7), Phase 7 (3/6), Phase 8 (1/6), Phase 9 (1/5).

Next problems to continue in order:
- Phase 2: Calculate Special Bonus (#1873) — only one remaining
- Phase 3: Find Total Time Spent (#1741)
- Phase 4: Department Highest Salary (#184), Rank Scores (#178)
- Phase 5: Customers Who Never Order (#183), Sales Person (#607)

For full curriculum and problem status → [TRACKER.md](../TRACKER.md)

---

## Recently Completed (2026-06-22 — Session 9, 7 problems)

- ✅ LC #1667 — Fix Names in a Table (Phase 2) — SUBSTRING + UPPER/LOWER + CONCAT
- ✅ LC #1527 — Patients With a Condition (Phase 2) — two LIKE patterns for word-boundary match
- ✅ LC #196 — Delete Duplicate Emails (bonus) — DELETE USING self-join (Postgres)
- ✅ LC #176 — Second Highest Salary (Phase 4) — LIMIT/OFFSET + scalar subquery null handling
- ✅ LC #1484 — Group Sold Products By The Date (bonus) — STRING_AGG + COUNT(DISTINCT)
- ✅ LC #1327 — List the Products Ordered in a Period (bonus) — JOIN + date range + HAVING
- ✅ LC #1517 — Find Users With Valid E-Mails (Phase 2) — first regex problem; `~` operator

---

## Previously Completed (2026-06-22 — Sessions 7–8, 5 problems)

- ✅ LC #610 — Triangle Judgement (Phase 7) — clean first-attempt CASE WHEN
- ✅ LC #180 — Consecutive Numbers (Phase 7) — triple self-join on id offset
- ✅ LC #1164 — Product Price at a Given Date (bonus) — derived-table + anti-join UNION
- ✅ LC #1204 — Last Person to Fit in the Bus (bonus) — first window function: SUM() OVER (ORDER BY)
- ✅ LC #1907 — Count Salary Categories (Phase 3) — UNION for guaranteed output categories

---

## Previously Completed (2026-06-18 — Sessions 5–6, 9 problems)

- ✅ LC #1731 — The Number of Employees Which Report to Each Employee (bonus)
- ✅ LC #1789 — Primary Department for Each Employee (bonus)
- ✅ LC #2356 — Number of Unique Subjects Taught by Each Teacher (bonus)
- ✅ LC #1141 — User Activity for the Past 30 Days I (bonus)
- ✅ LC #1070 — Product Sales Analysis III (Phase 6)
- ✅ LC #596 — Classes More Than 5 Students (Phase 3)
- ✅ LC #1729 — Find Followers Count (bonus)
- ✅ LC #619 — Biggest Single Number (bonus)
- ✅ LC #1045 — Customers Who Bought All Products (bonus)

## Previously Completed (2026-06-17 — Sessions 1–4)

- ✅ LC #2356 — Number of Unique Subjects Taught by Each Teacher (bonus)
- ✅ LC #1141 — User Activity for the Past 30 Days I (bonus)
- ✅ LC #1070 — Product Sales Analysis III (Phase 6)
- ✅ LC #596 — Classes More Than 5 Students (Phase 3)
- ✅ LC #1729 — Find Followers Count (bonus)
- ✅ LC #619 — Biggest Single Number (bonus)
- ✅ LC #1045 — Customers Who Bought All Products (bonus)

## Previously Completed (2026-06-17 — Pre-session warmup, Phase 1 batch)

- ✅ LC #1757 — Recyclable and Low Fat Products (Phase 1) — WHERE + AND
- ✅ LC #584 — Find Customer Referee (Phase 1) — NULL trap: IS NULL OR != 2
- ✅ LC #595 — Big Countries (Phase 1) — WHERE + OR
- ✅ LC #1148 — Article Views I (Phase 1) — SELECT DISTINCT + self-reference filter
- ✅ LC #1683 — Invalid Tweets (Phase 1) — WHERE + LENGTH

## Previously Completed (2026-06-17 — Sessions 1–4)
- ✅ LC #1378 — Replace Employee ID With The Unique Identifier (Phase 2)
- ✅ LC #1068 — Product Sales Analysis I (Phase 6)
- ✅ LC #1581 — Customer Who Visited but Did Not Make Any Transactions (Phase 5)
- ✅ LC #197 — Rising Temperature (Phase 5)
- ✅ LC #1661 — Average Time of Process per Machine (Phase 5)
- ✅ LC #577 — Employee Bonus (Phase 3)
- ✅ LC #1280 — Students and Examinations (Phase 7)
- ✅ LC #570 — Managers with at Least 5 Direct Reports (Phase 3)
- ✅ LC #1934 — Confirmation Rate (bonus)
- ✅ LC #620 — Not Boring Movies (bonus)
- ✅ LC #1251 — Average Selling Price (bonus)
- ✅ LC #1075 — Project Employees I (Phase 6)
- ✅ LC #1633 — Percentage of Users Attended a Contest (bonus)
- ✅ LC #1211 — Queries Quality and Percentage (bonus)
- ✅ LC #1193 — Monthly Transactions I (Phase 9)
- ✅ LC #1174 — Immediate Food Delivery II (bonus)
- ✅ LC #550 — Game Play Analysis IV (Phase 8)

---

## Concepts Mastered
- [x] INNER JOIN vs LEFT JOIN — decision rule internalized
- [x] Anti-join pattern (LEFT JOIN + WHERE right_col IS NULL)
- [x] Self-join for row comparison (date offset, start/end pairing)
- [x] Role pinning in JOIN condition (activity_type = 'start'/'end')
- [x] CROSS JOIN for all-combinations base set
- [x] COUNT(col) vs COUNT(*) — understands the NULL-skipping distinction
- [x] GROUP BY completeness — solid (5+ clean reps)
- [x] CASE WHEN — applies independently
- [x] Derived-table subquery pattern — solid (3 clean applications: #1174, #550, #1070)
- [x] COUNT(DISTINCT col) — applies independently
- [ ] COUNT(boolean) trap — still not automatic without probe
- [ ] Scalar subquery in HAVING — new in session 5 (LC #1045)
- [ ] Date range filter in Postgres (::date cast + INTERVAL) — hit multiple issues in session 5
- [ ] UNION vs UNION ALL — introduced this session (LC #1789); got it right when prompted about overlap
- [ ] SELECT / WHERE filtering
- [x] String functions (UPPER/LOWER, SUBSTRING, CONCAT, LIKE word-boundary patterns) — solid
- [ ] Regex (`~` operator, character classes, anchors) — introduced this session; new territory
- [ ] Window functions (PARTITION BY, ROW_NUMBER/RANK/DENSE_RANK, running totals)

---

## Notes
Strong session — 7 problems, mostly independent solves. Derived-table pattern fully internalized (3rd clean application). Two new patterns introduced: COUNT(DISTINCT) and HAVING with scalar subquery. Date arithmetic in Postgres still causes friction.

Session 6 — 2 problems. UNION introduced (LC #1789). Derived-table pattern applied independently a 4th time (LC #1731). FLOOR vs ROUND clarified. COUNT(boolean) trap answered correctly cold for the first time.

Session 7–8 — 5 problems. Triangle Judgement clean first-attempt. Consecutive Numbers via triple self-join (needed LC #197 reminder). Product Price at a Given Date hardest problem yet — two-case UNION combining derived-table and anti-join, needed guidance on case 2. Last Person to Fit in Bus — first window function introduced (SUM OVER ORDER BY). Count Salary Categories — clean first attempt via UNION.
