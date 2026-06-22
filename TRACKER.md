# SQL Master Tracker

Last updated: 2026-06-22

## Pace
**Target:** TBD — set once first few sessions establish a rhythm
**Start date:** TBD
**Target completion:** TBD

---

## Summary
| Metric | Count |
|--------|-------|
| Total problems | 73 |
| ✅ Complete | 31 |
| ⚠️ Needs revisit | 0 |
| ⏳ Not started | 42 |

---

## Phase Overview
| # | Phase | Problems | Done | Target Date | Status |
|---|-------|----------|------|-------------|--------|
| 1 | SELECT Basics | 6 | 0 | TBD | ⏳ |
| 2 | String & Date Functions | 5 | 1 | TBD | ⏳ |
| 3 | Basic Aggregation Functions | 6 | 5 | TBD | ⏳ |
| 4 | Sorting and Grouping | 5 | 0 | TBD | ⏳ |
| 5 | Basic Joins | 5 | 3 | TBD | ⏳ |
| 6 | Advanced Select and Joins | 10 | 5 | TBD | ⏳ |
| 7 | Subqueries | 6 | 3 | TBD | ⏳ |
| 8 | Window Functions | 6 | 1 | TBD | ⏳ |
| 9 | Date/Time & Pivoting | 5 | 1 | TBD | ⏳ |
| 10 | Mixed / Hard Practice | 7 | 0 | TBD | ⏳ |

---

## Phase 1 — SELECT Basics ⏳

| # | Problem | Difficulty | LC | Pattern | Status | Solved | Learnings |
|---|---------|------------|----|---------|--------|--------|-----------|
| 1 | Combine Two Tables | Easy | [#175](https://leetcode.com/problems/combine-two-tables/) | SELECT + LEFT JOIN intro | ⏳ | — | — |
| 2 | Find Customer Referee | Easy | [#584](https://leetcode.com/problems/find-customer-referee/) | WHERE + IS NULL / NOT | ⏳ | — | — |
| 3 | Big Countries | Easy | [#595](https://leetcode.com/problems/big-countries/) | WHERE + OR | ⏳ | — | — |
| 4 | Recyclable and Low Fat Products | Easy | [#1757](https://leetcode.com/problems/recyclable-and-low-fat-products/) | WHERE + AND | ⏳ | — | — |
| 5 | Invalid Tweets | Easy | [#1683](https://leetcode.com/problems/invalid-tweets/) | WHERE + LENGTH | ⏳ | — | — |
| 6 | Article Views I | Easy | [#1148](https://leetcode.com/problems/article-views-i/) | SELECT DISTINCT | ⏳ | — | — |

## Phase 2 — String & Date Functions ⏳

| # | Problem | Difficulty | LC | Pattern | Status | Solved | Learnings |
|---|---------|------------|----|---------|--------|--------|-----------|
| 1 | Fix Names in a Table | Easy | [#1667](https://leetcode.com/problems/fix-names-in-a-table/) | UPPER/LOWER + CONCAT | ⏳ | — | — |
| 2 | Patients With a Condition | Easy | [#1527](https://leetcode.com/problems/patients-with-a-condition/) | LIKE pattern matching | ⏳ | — | — |
| 3 | Find Users With Valid E-Mails | Easy | [#1517](https://leetcode.com/problems/find-users-with-valid-emails/) | REGEXP | ⏳ | — | — |
| 4 | Calculate Special Bonus | Easy | [#1873](https://leetcode.com/problems/calculate-special-bonus/) | CASE WHEN | ⏳ | — | — |
| 5 | Replace Employee ID With The Unique Identifier | Easy | [#1378](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/) | LEFT JOIN, NULL passthrough | ✅ | 2026-06-17 | [learnings](queries/1378-replace-employee-id-with-the-unique-identifier/learnings.md) |

## Phase 3 — Basic Aggregation Functions ⏳

| # | Problem | Difficulty | LC | Pattern | Status | Solved | Learnings |
|---|---------|------------|----|---------|--------|--------|-----------|
| 1 | Find Total Time Spent by Each Employee | Easy | [#1741](https://leetcode.com/problems/find-total-time-spent-by-each-employee/) | GROUP BY + SUM | ⏳ | — | — |
| 2 | Classes More Than 5 Students | Easy | [#596](https://leetcode.com/problems/classes-more-than-5-students/) | GROUP BY + HAVING | ✅ | 2026-06-18 | [learnings](queries/596-classes-more-than-5-students/learnings.md) |
| 3 | Customer Placing the Largest Number of Orders | Easy | [#586](https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/) | GROUP BY + ORDER BY + LIMIT | ⏳ | — | — |
| 4 | Employee Bonus | Easy | [#577](https://leetcode.com/problems/employee-bonus/) | LEFT JOIN + filter | ✅ | 2026-06-17 | [learnings](queries/577-employee-bonus/learnings.md) |
| 5 | Managers with at Least 5 Direct Reports | Medium | [#570](https://leetcode.com/problems/managers-with-at-least-5-direct-reports/) | Self-JOIN + GROUP BY + HAVING | ✅ | 2026-06-17 | [learnings](queries/570-managers-with-at-least-5-direct-reports/learnings.md) |
| 6 | Count Salary Categories | Medium | [#1907](https://leetcode.com/problems/count-salary-categories/) | UNION for guaranteed output categories | ✅ | 2026-06-22 | [learnings](queries/1907-count-salary-categories/learnings.md) |
| — | Not Boring Movies *(bonus)* | Easy | [#620](https://leetcode.com/problems/not-boring-movies/) | WHERE + modulo + ORDER BY | ✅ | 2026-06-17 | [learnings](queries/620-not-boring-movies/learnings.md) |
| — | Average Selling Price *(bonus)* | Easy | [#1251](https://leetcode.com/problems/average-selling-price/) | LEFT JOIN + weighted average + COALESCE | ✅ | 2026-06-17 | [learnings](queries/1251-average-selling-price/learnings.md) |
| — | Percentage of Users Attended a Contest *(bonus)* | Easy | [#1633](https://leetcode.com/problems/percentage-of-users-attended-a-contest/) | GROUP BY + scalar subquery denominator | ✅ | 2026-06-17 | [learnings](queries/1633-percentage-of-users-attended-a-contest/learnings.md) |
| — | Queries Quality and Percentage *(bonus)* | Easy | [#1211](https://leetcode.com/problems/queries-quality-and-percentage/) | CASE WHEN + conditional aggregation + ::numeric | ✅ | 2026-06-17 | [learnings](queries/1211-queries-quality-and-percentage/learnings.md) |
| — | Immediate Food Delivery II *(bonus)* | Medium | [#1174](https://leetcode.com/problems/immediate-food-delivery-ii/) | Subquery in FROM + two-condition JOIN + CASE WHEN | ✅ | 2026-06-18 | [learnings](queries/1174-immediate-food-delivery-ii/learnings.md) |
| — | Number of Unique Subjects Taught by Each Teacher *(bonus)* | Easy | [#2356](https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/) | COUNT(DISTINCT) per group | ✅ | 2026-06-18 | [learnings](queries/2356-number-of-unique-subjects-taught-by-each-teacher/learnings.md) |
| — | User Activity for the Past 30 Days I *(bonus)* | Easy | [#1141](https://leetcode.com/problems/user-activity-for-the-past-30-days-i/) | COUNT DISTINCT + date range filter | ✅ | 2026-06-18 | [learnings](queries/1141-user-activity-for-the-past-30-days-i/learnings.md) |
| — | Find Followers Count *(bonus)* | Easy | [#1729](https://leetcode.com/problems/find-followers-count/) | GROUP BY + COUNT + ORDER BY | ✅ | 2026-06-18 | [learnings](queries/1729-find-followers-count/learnings.md) |

## Phase 4 — Sorting and Grouping ⏳

| # | Problem | Difficulty | LC | Pattern | Status | Solved | Learnings |
|---|---------|------------|----|---------|--------|--------|-----------|
| 1 | Second Highest Salary | Medium | [#176](https://leetcode.com/problems/second-highest-salary/) | DISTINCT + LIMIT/OFFSET or subquery | ⏳ | — | — |
| 2 | Department Highest Salary | Medium | [#184](https://leetcode.com/problems/department-highest-salary/) | Correlated subquery / window | ⏳ | — | — |
| 3 | Rank Scores | Medium | [#178](https://leetcode.com/problems/rank-scores/) | Dense ranking without RANK() | ⏳ | — | — |
| 4 | Department Top Three Salaries | Hard | [#185](https://leetcode.com/problems/department-top-three-salaries/) | Top-N-per-group | ⏳ | — | — |
| 5 | Exchange Seats | Medium | [#626](https://leetcode.com/problems/exchange-seats/) | CASE WHEN + odd/even pairing | ⏳ | — | — |

## Phase 5 — Basic Joins ⏳

| # | Problem | Difficulty | LC | Pattern | Status | Solved | Learnings |
|---|---------|------------|----|---------|--------|--------|-----------|
| 1 | Customers Who Never Order | Easy | [#183](https://leetcode.com/problems/customers-who-never-order/) | Anti-join (LEFT JOIN ... WHERE NULL / NOT IN) | ⏳ | — | — |
| 2 | Sales Person | Easy | [#607](https://leetcode.com/problems/sales-person/) | Multi-table JOIN + NOT IN | ⏳ | — | — |
| 3 | Rising Temperature | Easy | [#197](https://leetcode.com/problems/rising-temperature/) | Self-JOIN on date offset | ✅ | 2026-06-17 | [learnings](queries/197-rising-temperature/learnings.md) |
| 4 | Average Time of Process per Machine | Easy | [#1661](https://leetcode.com/problems/average-time-of-process-per-machine/) | Self-JOIN, start/end pairing | ✅ | 2026-06-17 | [learnings](queries/1661-average-time-of-process-per-machine/learnings.md) |
| 5 | Customer Who Visited but Did Not Make Any Transactions | Easy | [#1581](https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/) | Anti-join + GROUP BY | ✅ | 2026-06-17 | [learnings](queries/1581-customer-who-visited-but-did-not-make-any-transactions/learnings.md) |
| — | Confirmation Rate *(bonus)* | Medium | [#1934](https://leetcode.com/problems/confirmation-rate/) | LEFT JOIN + conditional aggregation + COALESCE | ✅ | 2026-06-17 | [learnings](queries/1934-confirmation-rate/learnings.md) |

## Phase 6 — Advanced Select and Joins ⏳

| # | Problem | Difficulty | LC | Pattern | Status | Solved | Learnings |
|---|---------|------------|----|---------|--------|--------|-----------|
| 1 | Product Sales Analysis I | Easy | [#1068](https://leetcode.com/problems/product-sales-analysis-i/) | JOIN | ✅ | 2026-06-17 | [learnings](queries/1068-product-sales-analysis-i/learnings.md) |
| 2 | Product Sales Analysis III | Medium | [#1070](https://leetcode.com/problems/product-sales-analysis-iii/) | JOIN + first-occurrence filter | ✅ | 2026-06-18 | [learnings](queries/1070-product-sales-analysis-iii/learnings.md) |
| 3 | Project Employees I | Easy | [#1075](https://leetcode.com/problems/project-employees-i/) | JOIN + AVG, rounding | ✅ | 2026-06-17 | [learnings](queries/1075-project-employees-i/learnings.md) |
| 4 | Project Employees III | Medium | [#1077](https://leetcode.com/problems/project-employees-iii/) | JOIN + top-N-per-group | ⏳ | — | — |
| 5 | Sales Analysis I | Easy | [#1082](https://leetcode.com/problems/sales-analysis-i/) | JOIN + aggregation | ⏳ | — | — |
| 6 | Sales Analysis III | Easy | [#1084](https://leetcode.com/problems/sales-analysis-iii/) | JOIN + date range filter | ⏳ | — | — |
| 7 | The Most Recent Three Orders | Medium | [#1532](https://leetcode.com/problems/the-most-recent-three-orders/) | JOIN + top-N-per-group | ⏳ | — | — |
| — | The Number of Employees Which Report to Each Employee *(bonus)* | Easy | [#1731](https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/) | Self-join + GROUP BY + ROUND(AVG) | ✅ | 2026-06-18 | [learnings](queries/1731-number-of-employees-which-report-to-each-employee/learnings.md) |
| — | Primary Department for Each Employee *(bonus)* | Easy | [#1789](https://leetcode.com/problems/primary-department-for-each-employee/) | UNION for two-case conditional selection | ✅ | 2026-06-18 | [learnings](queries/1789-primary-department-for-each-employee/learnings.md) |
| — | Product Price at a Given Date *(bonus)* | Medium | [#1164](https://leetcode.com/problems/product-price-at-a-given-date/) | Derived-table + anti-join UNION for default value | ✅ | 2026-06-22 | [learnings](queries/1164-product-price-at-a-given-date/learnings.md) |

## Phase 7 — Subqueries ⏳

| # | Problem | Difficulty | LC | Pattern | Status | Solved | Learnings |
|---|---------|------------|----|---------|--------|--------|-----------|
| 1 | Duplicate Emails | Easy | [#182](https://leetcode.com/problems/duplicate-emails/) | GROUP BY + HAVING (subquery alt.) | ⏳ | — | — |
| 2 | Employees Earning More Than Their Managers | Easy | [#181](https://leetcode.com/problems/employees-earning-more-than-their-managers/) | Self-JOIN / correlated subquery | ⏳ | — | — |
| 3 | Investments in 2016 | Medium | [#585](https://leetcode.com/problems/investments-in-2016/) | Subquery with multiple conditions | ⏳ | — | — |
| 4 | Triangle Judgement | Easy | [#610](https://leetcode.com/problems/triangle-judgement/) | CASE WHEN, no subquery needed (control) | ✅ | 2026-06-22 | [learnings](queries/610-triangle-judgement/learnings.md) |
| 5 | Consecutive Numbers | Medium | [#180](https://leetcode.com/problems/consecutive-numbers/) | Self-JOIN on row offset | ✅ | 2026-06-22 | [learnings](queries/180-consecutive-numbers/learnings.md) |
| 6 | Students and Examinations | Medium | [#1280](https://leetcode.com/problems/students-and-examinations/) | CROSS JOIN + LEFT JOIN + GROUP BY | ✅ | 2026-06-17 | [learnings](queries/1280-students-and-examinations/learnings.md) |
| — | Biggest Single Number *(bonus)* | Easy | [#619](https://leetcode.com/problems/biggest-single-number/) | GROUP BY + HAVING + outer MAX subquery | ✅ | 2026-06-18 | [learnings](queries/619-biggest-single-number/learnings.md) |
| — | Customers Who Bought All Products *(bonus)* | Medium | [#1045](https://leetcode.com/problems/customers-who-bought-all-products/) | HAVING COUNT(DISTINCT) = scalar subquery | ✅ | 2026-06-18 | [learnings](queries/1045-customers-who-bought-all-products/learnings.md) |

## Phase 8 — Window Functions ⏳

| # | Problem | Difficulty | LC | Pattern | Status | Solved | Learnings |
|---|---------|------------|----|---------|--------|--------|-----------|
| 1 | Nth Highest Salary | Medium | [#177](https://leetcode.com/problems/nth-highest-salary/) | DENSE_RANK() or LIMIT/OFFSET in a function | ⏳ | — | — |
| 2 | Running Total for Different Genders | Medium | [#1308](https://leetcode.com/problems/running-total-for-different-genders/) | SUM() OVER (PARTITION BY ... ORDER BY ...) | ⏳ | — | — |
| 3 | Game Play Analysis I | Easy | [#511](https://leetcode.com/problems/game-play-analysis-i/) | MIN() + GROUP BY (warm-up) | ⏳ | — | — |
| 4 | Game Play Analysis IV | Medium | [#550](https://leetcode.com/problems/game-play-analysis-iv/) | Derived-table subquery + date offset + fraction | ✅ | 2026-06-18 | [learnings](queries/550-game-play-analysis-iv/learnings.md) |
| — | Last Person to Fit in the Bus *(bonus)* | Medium | [#1204](https://leetcode.com/problems/last-person-to-fit-in-the-bus/) | SUM() OVER (ORDER BY) running total; subquery to filter on window result | ✅ | 2026-06-22 | [learnings](queries/1204-last-person-to-fit-in-the-bus/learnings.md) |
| 5 | Median Employee Salary | Hard | [#569](https://leetcode.com/problems/median-employee-salary/) | RANK()/ROW_NUMBER() within partition | ⏳ | — | — |
| 6 | Find Cumulative Salary of an Employee | Hard | [#579](https://leetcode.com/problems/find-cumulative-salary-of-an-employee/) | SUM() OVER with row range | ⏳ | — | — |

## Phase 9 — Date/Time & Pivoting ⏳

| # | Problem | Difficulty | LC | Pattern | Status | Solved | Learnings |
|---|---------|------------|----|---------|--------|--------|-----------|
| 1 | Convert Date Format | Easy | [#1853](https://leetcode.com/problems/convert-date-format/) | DATE_FORMAT | ⏳ | — | — |
| 2 | Reformat Department Table | Medium | [#1179](https://leetcode.com/problems/reformat-department-table/) | Pivot via conditional SUM/MAX | ⏳ | — | — |
| 3 | Monthly Transactions I | Medium | [#1193](https://leetcode.com/problems/monthly-transactions-i/) | TO_CHAR + GROUP BY + CASE WHEN | ✅ | 2026-06-18 | [learnings](queries/1193-monthly-transactions-i/learnings.md) |
| 4 | Monthly Transactions II | Medium | [#1205](https://leetcode.com/problems/monthly-transactions-ii/) | GROUP BY with mixed conditional aggregation | ⏳ | — | — |
| 5 | Rising Temperature (window-function angle) | Easy | [#197](https://leetcode.com/problems/rising-temperature/) | LAG-style framing | ⏳ | — | — |

## Phase 10 — Mixed / Hard Practice ⏳

| # | Problem | Difficulty | LC | Pattern | Status | Solved | Learnings |
|---|---------|------------|----|---------|--------|--------|-----------|
| 1 | Trips and Users | Hard | [#262](https://leetcode.com/problems/trips-and-users/) | Multi-condition JOIN + conditional aggregation | ⏳ | — | — |
| 2 | Human Traffic of Stadium | Hard | [#601](https://leetcode.com/problems/human-traffic-of-stadium/) | Consecutive-row detection | ⏳ | — | — |
| 3 | Movie Rating | Medium | [#1341](https://leetcode.com/problems/movie-rating/) | UNION + tie-break ordering | ⏳ | — | — |
| 4 | Friend Requests I: Overall Acceptance Rate | Easy→Medium | [#597](https://leetcode.com/problems/friend-requests-i-overall-acceptance-rate/) | Distinct counting across two tables | ⏳ | — | — |
| 5 | Friend Requests II: Who Has the Most Friends | Medium | [#602](https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/) | UNION ALL + GROUP BY + symmetry | ⏳ | — | — |
| 6 | Market Analysis I | Medium | [#1158](https://leetcode.com/problems/market-analysis-i/) | LEFT JOIN + conditional aggregation | ⏳ | — | — |
| 7 | Department Top Three Salaries (cold redo) | Hard | [#185](https://leetcode.com/problems/department-top-three-salaries/) | Top-N-per-group without window functions | ⏳ | — | — |
