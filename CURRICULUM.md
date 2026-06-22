# SQL Curriculum — LeetCode Database Track

Goal: Interview-ready SQL (analytics + backend interview rounds)
Total: 10 phases, ~76 problems
Dialect: MySQL (LeetCode's default) — flag dialect-specific syntax (e.g. `IFNULL` vs `COALESCE`, `DATEDIFF`) when it comes up.

> Note: LeetCode occasionally renumbers or retires problems. If a link 404s, search the title on leetcode.com/problemset/database/ instead of guessing a new number.

---

## Phase 1 — SELECT Basics
**Why this order:** Filtering, projection, `WHERE`, `IS NULL`, basic comparison — the absolute floor before anything else makes sense.
**Interview weight:** 🔴 Very High
**Problems:** 6 total (E: 6 / M: 0 / H: 0)

| # | Problem | Difficulty | LeetCode | Pattern |
|---|---------|------------|----------|---------|
| 1 | Combine Two Tables | Easy | [LC #175](https://leetcode.com/problems/combine-two-tables/) | SELECT + LEFT JOIN intro |
| 2 | Find Customer Referee | Easy | [LC #584](https://leetcode.com/problems/find-customer-referee/) | WHERE + IS NULL / NOT |
| 3 | Big Countries | Easy | [LC #595](https://leetcode.com/problems/big-countries/) | WHERE + OR |
| 4 | Recyclable and Low Fat Products | Easy | [LC #1757](https://leetcode.com/problems/recyclable-and-low-fat-products/) | WHERE + AND |
| 5 | Invalid Tweets | Easy | [LC #1683](https://leetcode.com/problems/invalid-tweets/) | WHERE + LENGTH |
| 6 | Article Views I | Easy | [LC #1148](https://leetcode.com/problems/article-views-i/) | SELECT DISTINCT |

---

## Phase 2 — String & Date Functions
**Why this order:** Real data is messy — string cleanup and date handling come up constantly before aggregation is even relevant.
**Interview weight:** 🟡 High
**Problems:** 5 total (E: 5 / M: 0 / H: 0)

| # | Problem | Difficulty | LeetCode | Pattern |
|---|---------|------------|----------|---------|
| 1 | Fix Names in a Table | Easy | [LC #1667](https://leetcode.com/problems/fix-names-in-a-table/) | UPPER/LOWER + CONCAT |
| 2 | Patients With a Condition | Easy | [LC #1527](https://leetcode.com/problems/patients-with-a-condition/) | LIKE pattern matching |
| 3 | Find Users With Valid E-Mails | Easy | [LC #1517](https://leetcode.com/problems/find-users-with-valid-emails/) | REGEXP |
| 4 | Calculate Special Bonus | Easy | [LC #1873](https://leetcode.com/problems/calculate-special-bonus/) | CASE WHEN |
| 5 | Replace Employee ID With The Unique Identifier | Easy | [LC #1378](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/) | LEFT JOIN, NULL passthrough |
| — | Delete Duplicate Emails *(bonus)* | Easy | [LC #196](https://leetcode.com/problems/delete-duplicate-emails/) | DELETE with self-join; Postgres USING syntax |

---

## Phase 3 — Basic Aggregation Functions
**Why this order:** COUNT, SUM, AVG, GROUP BY, HAVING — the core toolkit for "summarize this table" questions, which is most of what SQL interviews actually test.
**Interview weight:** 🔴 Very High
**Problems:** 6 total (E: 5 / M: 1 / H: 0)

| # | Problem | Difficulty | LeetCode | Pattern |
|---|---------|------------|----------|---------|
| 1 | Find Total Time Spent by Each Employee | Easy | [LC #1741](https://leetcode.com/problems/find-total-time-spent-by-each-employee/) | GROUP BY + SUM |
| 2 | Classes More Than 5 Students | Easy | [LC #596](https://leetcode.com/problems/classes-more-than-5-students/) | GROUP BY + HAVING |
| 3 | Customer Placing the Largest Number of Orders | Easy | [LC #586](https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/) | GROUP BY + ORDER BY + LIMIT |
| 4 | Employee Bonus | Easy | [LC #577](https://leetcode.com/problems/employee-bonus/) | LEFT JOIN + filter |
| 5 | Managers with at Least 5 Direct Reports | Medium | [LC #570](https://leetcode.com/problems/managers-with-at-least-5-direct-reports/) | Self-JOIN + GROUP BY + HAVING |
| 6 | Count Salary Categories | Medium | [LC #1907](https://leetcode.com/problems/count-salary-categories/) | CASE WHEN + GROUP BY (bucketing) |
| — | Not Boring Movies *(bonus)* | Easy | [LC #620](https://leetcode.com/problems/not-boring-movies/) | WHERE + modulo + ORDER BY |
| — | Average Selling Price *(bonus)* | Easy | [LC #1251](https://leetcode.com/problems/average-selling-price/) | LEFT JOIN + weighted average + COALESCE |
| — | Percentage of Users Attended a Contest *(bonus)* | Easy | [LC #1633](https://leetcode.com/problems/percentage-of-users-attended-a-contest/) | GROUP BY + scalar subquery denominator |
| — | Number of Unique Subjects Taught by Each Teacher *(bonus)* | Easy | [LC #2356](https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/) | COUNT(DISTINCT) per group |
| — | User Activity for the Past 30 Days I *(bonus)* | Easy | [LC #1141](https://leetcode.com/problems/user-activity-for-the-past-30-days-i/) | COUNT DISTINCT + date range filter |
| — | Find Followers Count *(bonus)* | Easy | [LC #1729](https://leetcode.com/problems/find-followers-count/) | GROUP BY + COUNT + ORDER BY |
| — | Group Sold Products By The Date *(bonus)* | Easy | [LC #1484](https://leetcode.com/problems/group-sold-products-by-the-date/) | STRING_AGG + COUNT(DISTINCT) per group |
| — | List the Products Ordered in a Period *(bonus)* | Easy | [LC #1327](https://leetcode.com/problems/list-the-products-ordered-in-a-period/) | JOIN + date range filter + HAVING |

---

## Phase 4 — Sorting and Grouping
**Why this order:** Ranking and "top N per group" questions are an extremely common interview shape — they need ORDER BY, LIMIT/OFFSET, and a first taste of correlated logic.
**Interview weight:** 🔴 Very High
**Problems:** 5 total (E: 1 / M: 4 / H: 0)

| # | Problem | Difficulty | LeetCode | Pattern |
|---|---------|------------|----------|---------|
| 1 | Second Highest Salary | Medium | [LC #176](https://leetcode.com/problems/second-highest-salary/) | DISTINCT + LIMIT/OFFSET or subquery |
| 2 | Department Highest Salary | Medium | [LC #184](https://leetcode.com/problems/department-highest-salary/) | Correlated subquery / window |
| 3 | Rank Scores | Medium | [LC #178](https://leetcode.com/problems/rank-scores/) | Dense ranking without RANK() |
| 4 | Department Top Three Salaries | Hard | [LC #185](https://leetcode.com/problems/department-top-three-salaries/) | Top-N-per-group |
| 5 | Exchange Seats | Medium | [LC #626](https://leetcode.com/problems/exchange-seats/) | CASE WHEN + odd/even pairing |

---

## Phase 5 — Basic Joins
**Why this order:** INNER/LEFT/RIGHT JOIN, anti-joins ("find rows with no match") — the single highest-frequency interview pattern after aggregation.
**Interview weight:** 🔴 Very High
**Problems:** 5 total (E: 3 / M: 2 / H: 0)

| # | Problem | Difficulty | LeetCode | Pattern |
|---|---------|------------|----------|---------|
| 1 | Customers Who Never Order | Easy | [LC #183](https://leetcode.com/problems/customers-who-never-order/) | Anti-join (LEFT JOIN ... WHERE NULL / NOT IN) |
| 2 | Sales Person | Easy | [LC #607](https://leetcode.com/problems/sales-person/) | Multi-table JOIN + NOT IN |
| 3 | Rising Temperature | Easy | [LC #197](https://leetcode.com/problems/rising-temperature/) | Self-JOIN on date offset |
| 4 | Average Time of Process per Machine | Easy | [LC #1661](https://leetcode.com/problems/average-time-of-process-per-machine/) | Self-JOIN, start/end pairing |
| 5 | Customer Who Visited but Did Not Make Any Transactions | Easy | [LC #1581](https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/) | Anti-join + GROUP BY |

---

## Phase 6 — Advanced Select and Joins
**Why this order:** Multi-table joins with three or more tables, and joins that feed straight into aggregation — the shape of most "real" analytics questions.
**Interview weight:** 🟡 High
**Problems:** 7 total (E: 4 / M: 3 / H: 0)

| # | Problem | Difficulty | LeetCode | Pattern |
|---|---------|------------|----------|---------|
| 1 | Product Sales Analysis I | Easy | [LC #1068](https://leetcode.com/problems/product-sales-analysis-i/) | JOIN |
| 2 | Product Sales Analysis III | Medium | [LC #1070](https://leetcode.com/problems/product-sales-analysis-iii/) | JOIN + first-occurrence filter |
| 3 | Project Employees I | Easy | [LC #1075](https://leetcode.com/problems/project-employees-i/) | JOIN + AVG, rounding |
| 4 | Project Employees III | Medium | [LC #1077](https://leetcode.com/problems/project-employees-iii/) | JOIN + top-N-per-group |
| 5 | Sales Analysis I | Easy | [LC #1082](https://leetcode.com/problems/sales-analysis-i/) | JOIN + aggregation |
| 6 | Sales Analysis III | Easy | [LC #1084](https://leetcode.com/problems/sales-analysis-iii/) | JOIN + date range filter |
| 7 | The Most Recent Three Orders | Medium | [LC #1532](https://leetcode.com/problems/the-most-recent-three-orders/) | JOIN + top-N-per-group |
| — | The Number of Employees Which Report to Each Employee *(bonus)* | Easy | [LC #1731](https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/) | Self-join + GROUP BY + ROUND(AVG) |
| — | Primary Department for Each Employee *(bonus)* | Easy | [LC #1789](https://leetcode.com/problems/primary-department-for-each-employee/) | UNION for two-case conditional selection |
| — | Product Price at a Given Date *(bonus)* | Medium | [LC #1164](https://leetcode.com/problems/product-price-at-a-given-date/) | Derived-table + anti-join UNION for default value |

---

## Phase 7 — Subqueries
**Why this order:** Nested SELECTs, correlated subqueries, `EXISTS`/`NOT EXISTS`, `IN`/`NOT IN` — the toolkit that replaces a lot of join gymnastics once it clicks.
**Interview weight:** 🔴 Very High
**Problems:** 6 total (E: 3 / M: 3 / H: 0)

| # | Problem | Difficulty | LeetCode | Pattern |
|---|---------|------------|----------|---------|
| 1 | Duplicate Emails | Easy | [LC #182](https://leetcode.com/problems/duplicate-emails/) | GROUP BY + HAVING (subquery alt.) |
| 2 | Employees Earning More Than Their Managers | Easy | [LC #181](https://leetcode.com/problems/employees-earning-more-than-their-managers/) | Self-JOIN / correlated subquery |
| 3 | Investments in 2016 | Medium | [LC #585](https://leetcode.com/problems/investments-in-2016/) | Subquery with multiple conditions |
| 4 | Triangle Judgement | Easy | [LC #610](https://leetcode.com/problems/triangle-judgement/) | CASE WHEN, no subquery needed (control) |
| 5 | Consecutive Numbers | Medium | [LC #180](https://leetcode.com/problems/consecutive-numbers/) | Self-JOIN on row offset |
| 6 | Students and Examinations | Medium | [LC #1280](https://leetcode.com/problems/students-and-examinations/) | CROSS JOIN + LEFT JOIN + GROUP BY |
| — | Biggest Single Number *(bonus)* | Easy | [LC #619](https://leetcode.com/problems/biggest-single-number/) | GROUP BY + HAVING + outer MAX subquery |
| — | Customers Who Bought All Products *(bonus)* | Medium | [LC #1045](https://leetcode.com/problems/customers-who-bought-all-products/) | HAVING COUNT(DISTINCT) = scalar subquery |

---

## Phase 8 — Window Functions
**Why this order:** Not in the original "SQL 50" but essential for 2024+ interviews — running totals, ranking, lag/lead. Builds directly on Phase 4's manual ranking tricks, now with the real tool.
**Interview weight:** 🔴 Very High
**Problems:** 6 total (E: 0 / M: 5 / H: 1)

| # | Problem | Difficulty | LeetCode | Pattern |
|---|---------|------------|----------|---------|
| 1 | Nth Highest Salary | Medium | [LC #177](https://leetcode.com/problems/nth-highest-salary/) | DENSE_RANK() or LIMIT/OFFSET in a function |
| 2 | Running Total for Different Genders | Medium | [LC #1308](https://leetcode.com/problems/running-total-for-different-genders/) | SUM() OVER (PARTITION BY ... ORDER BY ...) |
| 3 | Game Play Analysis I | Easy | [LC #511](https://leetcode.com/problems/game-play-analysis-i/) | MIN() + GROUP BY (warm-up) |
| 4 | Game Play Analysis IV | Medium | [LC #550](https://leetcode.com/problems/game-play-analysis-iv/) | Self-JOIN on date offset + ROUND |
| — | Last Person to Fit in the Bus *(bonus)* | Medium | [LC #1204](https://leetcode.com/problems/last-person-to-fit-in-the-bus/) | SUM() OVER (ORDER BY) running total |
| 5 | Median Employee Salary | Hard | [LC #569](https://leetcode.com/problems/median-employee-salary/) | RANK()/ROW_NUMBER() within partition |
| 6 | Find Cumulative Salary of an Employee | Hard | [LC #579](https://leetcode.com/problems/find-cumulative-salary-of-an-employee/) | SUM() OVER with row range |

---

## Phase 9 — Date/Time & Pivoting
**Why this order:** Month-over-month, retention windows, and reshaping rows into columns — common in product-analytics-flavored interviews.
**Interview weight:** 🟡 High
**Problems:** 5 total (E: 1 / M: 4 / H: 0)

| # | Problem | Difficulty | LeetCode | Pattern |
|---|---------|------------|----------|---------|
| 1 | Convert Date Format | Easy | [LC #1853](https://leetcode.com/problems/convert-date-format/) | DATE_FORMAT |
| 2 | Reformat Department Table | Medium | [LC #1179](https://leetcode.com/problems/reformat-department-table/) | Pivot via conditional SUM/MAX |
| 3 | Monthly Transactions I | Medium | [LC #1193](https://leetcode.com/problems/monthly-transactions-i/) | DATE_FORMAT + GROUP BY |
| 4 | Monthly Transactions II | Medium | [LC #1205](https://leetcode.com/problems/monthly-transactions-ii/) | GROUP BY with mixed conditional aggregation |
| 5 | Rising Temperature *(revisit from Phase 5, different angle: LAG-style framing)* | Easy | [LC #197](https://leetcode.com/problems/rising-temperature/) | Window function alt. to self-join |

---

## Phase 10 — Mixed / Hard Practice
**Why this order:** Capstone phase — multi-step problems combining joins, subqueries, conditional aggregation, and window functions in one query. Closest to a real interview's hardest SQL round.
**Interview weight:** 🟡 High
**Problems:** 7 total (E: 0 / M: 5 / H: 2)

| # | Problem | Difficulty | LeetCode | Pattern |
|---|---------|------------|----------|---------|
| 1 | Trips and Users | Hard | [LC #262](https://leetcode.com/problems/trips-and-users/) | Multi-condition JOIN + conditional aggregation |
| 2 | Human Traffic of Stadium | Hard | [LC #601](https://leetcode.com/problems/human-traffic-of-stadium/) | Consecutive-row detection |
| 3 | Movie Rating | Medium | [LC #1341](https://leetcode.com/problems/movie-rating/) | UNION + tie-break ordering |
| 4 | Friend Requests I: Overall Acceptance Rate | Easy→Medium | [LC #597](https://leetcode.com/problems/friend-requests-i-overall-acceptance-rate/) | Distinct counting across two tables |
| 5 | Friend Requests II: Who Has the Most Friends | Medium | [LC #602](https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/) | UNION ALL + GROUP BY + symmetry |
| 6 | Market Analysis I | Medium | [LC #1158](https://leetcode.com/problems/market-analysis-i/) | LEFT JOIN + conditional aggregation |
| 7 | Department Top Three Salaries *(revisit)* | Hard | [LC #185](https://leetcode.com/problems/department-top-three-salaries/) | Cold redo — top-N-per-group without window functions |
