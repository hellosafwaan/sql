# Safwaan — Progress (SQL Track)

## Current Phase
**Phase 9 — Date/Time & Pivoting** (1/5). Also active: Phase 5 (3/5), Phase 6 (2/7), Phase 3 (4/6 including bonus), Phase 7 (1/6). Several bonus problems from LeetCode SQL 50 Basic Aggregate Functions section completed.

Next problems to continue in order:
- Phase 2: Fix Names (#1667), Patients With a Condition (#1527), Find Valid Emails (#1517), Calculate Special Bonus (#1873)
- Phase 3: Find Total Time Spent (#1741), Classes More Than 5 Students (#596), Customer Placing Largest Orders (#586), Managers with 5 Reports (#570), Count Salary Categories (#1907)
- Phase 5: Customers Who Never Order (#183), Sales Person (#607)

For full curriculum and problem status → [TRACKER.md](../TRACKER.md)

---

## Recently Completed (2026-06-17 — Sessions 1–3)
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
- [ ] SELECT / WHERE filtering
- [ ] String functions (UPPER/LOWER, CONCAT, LIKE, REGEXP)
- [ ] GROUP BY + aggregation (COUNT/SUM/AVG)
- [ ] HAVING vs WHERE
- [ ] Subqueries (scalar, correlated, EXISTS)
- [ ] Window functions (PARTITION BY, ROW_NUMBER/RANK/DENSE_RANK, running totals)
- [ ] Date/time functions and pivoting

---

## Notes
Jumped into Phase 5/6/7 problems on day 1 without working through Phases 1-4 in order. Strong intuition for join type selection; GROUP BY rules and Postgres type casting (::numeric) needed explicit guidance.
