# Session: Students and Examinations — 2026-06-17

## What He Attempted
```sql
select students.student_id, students.student_name, subjects.subject_name, count(examinations.student_id) as attended_exams
from students
    cross join subjects
    left join examinations on
        examinations.subject_name = subjects.subject_name and
        examinations.student_id = students.student_id
group by students.student_id, students.student_name, subjects.subject_name
order by students.student_id, subjects.subject_name;
```

## Where He Got Stuck
Two points:
1. GROUP BY: initially wrote `group by subjects.subject_name` only — needed explanation of why all non-aggregated SELECT columns must be in GROUP BY.
2. COUNT: first wrote `count(students.student_id)` — this counts every row including unmatched ones (all non-null), giving wrong counts. Guided to count `examinations.student_id` instead, which is NULL for unattended exams and correctly gives 0.

## Mistakes Made
1. GROUP BY only on subject_name — partial grouping, semantically wrong.
2. COUNT(students.student_id) instead of COUNT(examinations.student_id) — counted all rows instead of only matched ones.

## Key Insight
CROSS JOIN gives every possible student-subject combination as the base set. LEFT JOIN then attaches exam records where they exist, NULLs where they don't. COUNT(examinations.student_id) skips NULLs → students who never attended get 0.

## Complexity / Correctness Notes
CROSS JOIN × LEFT JOIN is the standard "all combinations with optional match" pattern. The COUNT(right_table.col) trick for getting 0-counts is a direct application of the COUNT(col) vs COUNT(*) distinction Safwaan had already identified in LC #1581.

## Coach Notes for Next Session
CROSS JOIN concept clicked quickly. GROUP BY rules needed explicit explanation — "all non-aggregated SELECT columns must appear in GROUP BY" isn't internalized yet, watch for this in aggregation problems. COUNT(col) vs COUNT(*) is now confirmed to matter in practice — the earlier theoretical discussion paid off.
