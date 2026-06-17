Session: [012_2026-06-17_project-employees-i](../../safwaan/sessions/012_2026-06-17_project-employees-i.md)

## How It Felt
Easy and clean. Reasoned through the full approach before writing — join type, condition, grouping, aggregation — and got it right first try with no runtime errors.

## Key Insight
AVG(integer column) in Postgres automatically returns a numeric/decimal type — no `::numeric` cast needed. This is different from `SUM(int) / SUM(int)`, which stays integer. So `ROUND(AVG(experience_years), 2)` just works.

Also: GROUP BY included from the start — no runtime error needed to catch it. That's the target habit.

## Solution Walkthrough
So the question is: for each project, what's the average years of experience across all its employees?

The two tables are Project (which maps project IDs to employee IDs) and Employee (which holds each employee's name and experience). To get experience data onto the project rows, you need to join them.

**Why INNER JOIN?** The problem guarantees `experience_years` is NOT NULL, which means every employee in the Employee table has a valid record. And since Project references Employee via a foreign key, every employee listed in Project will definitely have a match in Employee. No rows will be dropped — INNER JOIN is the right call.

**JOIN condition:** `p.employee_id = e.employee_id` — that's the shared key between the two tables. After the join, each row has the project_id alongside that employee's experience_years.

**GROUP BY project_id:** You want one result row per project. GROUP BY collapses all the employee rows for a project into a single group, so the aggregate can run across them.

**SELECT:** `project_id` (the non-aggregated column — must be in GROUP BY) and `ROUND(AVG(experience_years), 2)` — Postgres's AVG on an integer column returns a numeric type automatically, so no `::numeric` cast needed here.

Final shape:
```sql
SELECT p.project_id, ROUND(AVG(e.experience_years), 2) AS average_years
FROM project p
INNER JOIN employee e ON p.employee_id = e.employee_id
GROUP BY p.project_id;
```

## Pattern Introduced
- `AVG(int_col)` in Postgres returns numeric automatically — `ROUND(AVG(...), 2)` works without `::numeric`
- Contrast: `SUM(int) / SUM(int)` stays integer and needs the cast

## Watch Out For
- Don't confuse this with the LC #1251 weighted average pattern — here you want a simple average across employees, not a revenue-weighted average
- `::numeric` is needed for division (`SUM/SUM`), not for `AVG`

## Template
```sql
SELECT grouping_col, ROUND(AVG(measure_col), 2) AS avg_measure
FROM table_a a
INNER JOIN table_b b ON a.id = b.id
GROUP BY grouping_col;
```

## Trace Through
Project:
| project_id | employee_id |
|------------|-------------|
| 1          | 1           |
| 1          | 2           |
| 1          | 3           |
| 2          | 1           |
| 2          | 4           |

Employee:
| employee_id | experience_years |
|-------------|-----------------|
| 1           | 3               |
| 2           | 5               |
| 3           | 0               |
| 4           | 6               |

After INNER JOIN:
| project_id | experience_years |
|------------|-----------------|
| 1          | 3               |
| 1          | 5               |
| 1          | 0               |
| 2          | 3               |
| 2          | 6               |

After GROUP BY + AVG + ROUND:
| project_id | average_years |
|------------|---------------|
| 1          | 2.67          |
| 2          | 4.50          |

## Complexity / Correctness
O(n) over joined rows. INNER JOIN is safe here because the foreign key relationship guarantees every project employee exists in the Employee table.

## Submissions
- https://leetcode.com/problems/project-employees-i/submissions/2036616027

## Open Questions
*(none)*
