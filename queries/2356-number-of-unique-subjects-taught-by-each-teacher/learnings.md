Session: [018_2026-06-18_unique-subjects](../../safwaan/sessions/018_2026-06-18_unique-subjects.md)

## How It Felt
Straightforward. Brief moment of wondering if subject needed its own GROUP BY level — resolved it himself.

## Key Insight
COUNT(DISTINCT col) handles deduplication within a group. No need for nested grouping — just one GROUP BY level (teacher) with DISTINCT inside the COUNT.

## Solution Walkthrough
So, you've got a Teacher table where a teacher can teach the same subject in different departments — meaning the same (teacher_id, subject_id) pair might appear multiple times. You want unique subjects per teacher.

The natural instinct is to GROUP BY teacher_id. Now inside that group, how do you count only unique subjects? COUNT(subject_id) would count every row, duplicates included. COUNT(DISTINCT subject_id) collapses duplicates first, then counts. That's the whole problem.

```sql
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;
```

After GROUP BY: one group per teacher. COUNT(DISTINCT subject_id): unique subjects in that group. Done.

## Pattern Introduced
COUNT(DISTINCT col) — count unique values within a group without needing nested grouping.

## Watch Out For
Don't confuse COUNT(col) with COUNT(DISTINCT col). The first counts every non-NULL row; the second deduplicates first.

## Template
```sql
SELECT group_col, COUNT(DISTINCT value_col) AS unique_count
FROM table
GROUP BY group_col;
```

## Trace Through
| teacher_id | subject_id | dept_id |
|---|---|---|
| 1 | Math | A |
| 1 | Math | B |   ← same subject, different dept
| 1 | Physics | A |

GROUP BY teacher_id=1: COUNT(DISTINCT subject_id) = 2 (Math, Physics)

## Complexity / Correctness
O(n) with GROUP BY. No NULL concerns — subject_id is part of the primary key.

## Submissions
https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/submissions/2037568309

## Open Questions
None.
