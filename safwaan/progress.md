# Safwaan — Progress (SQL Track)

## Current Phase
**Phase 3 — Basic Aggregation Functions** (5/6 + bonuses). Also active: Phase 5 (3/5), Phase 6 (3/7), Phase 7 (1/6), Phase 8 (1/6), Phase 9 (1/5).

Next problems to continue in order:
- Phase 2: Fix Names (#1667), Patients With a Condition (#1527), Find Valid Emails (#1517), Calculate Special Bonus (#1873)
- Phase 3: Find Total Time Spent (#1741), Count Salary Categories (#1907)
- Phase 5: Customers Who Never Order (#183), Sales Person (#607)
- Phase 4: Second Highest Salary (#176), Department Highest Salary (#184), Rank Scores (#178)

For full curriculum and problem status → [TRACKER.md](../TRACKER.md)

---

## Recently Completed (2026-06-18 — Sessions 5, 7 problems)

- ✅ LC #2356 — Number of Unique Subjects Taught by Each Teacher (bonus)
- ✅ LC #1141 — User Activity for the Past 30 Days I (bonus)
- ✅ LC #1070 — Product Sales Analysis III (Phase 6)
- ✅ LC #596 — Classes More Than 5 Students (Phase 3)
- ✅ LC #1729 — Find Followers Count (bonus)
- ✅ LC #619 — Biggest Single Number (bonus)
- ✅ LC #1045 — Customers Who Bought All Products (bonus)

---

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
- [ ] Scalar subquery in HAVING — new this session (LC #1045)
- [ ] Date range filter in Postgres (::date cast + INTERVAL) — hit multiple issues this session
- [ ] SELECT / WHERE filtering
- [ ] String functions (UPPER/LOWER, CONCAT, LIKE, REGEXP)
- [ ] Window functions (PARTITION BY, ROW_NUMBER/RANK/DENSE_RANK, running totals)

---

## Notes
Strong session — 7 problems, mostly independent solves. Derived-table pattern fully internalized (3rd clean application). Two new patterns introduced: COUNT(DISTINCT) and HAVING with scalar subquery. Date arithmetic in Postgres still causes friction.
