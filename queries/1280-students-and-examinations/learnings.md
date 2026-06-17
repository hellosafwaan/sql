Session: [007_2026-06-17_students-and-examinations](../../safwaan/sessions/007_2026-06-17_students-and-examinations.md)

## How It Felt
Tricky. The CROSS JOIN insight came quickly, but GROUP BY rules and the COUNT(col) gotcha needed explicit guidance. Once those two things clicked, the solution assembled cleanly.

## Key Insight
When you need every combination of two sets as your base (every student × every subject), CROSS JOIN is the tool. Then LEFT JOIN to attach optional data. COUNT(right_table.col) gives 0 for unmatched rows because NULL is skipped by COUNT — this is the COUNT(col) vs COUNT(*) distinction mattering in practice.

## Solution Walkthrough
The goal: for every student and every subject, count how many times that student attended that exam. Students who never attended a subject should show 0, not be missing.

Step 1 — CROSS JOIN to build the base set of all student-subject combinations:
```
FROM students CROSS JOIN subjects
```

This gives us rows like (Alice, Math), (Alice, Physics), (Alice, Programming), (Bob, Math), etc. — every student paired with every subject.

Step 2 — LEFT JOIN to attach exam records where they exist:
```
LEFT JOIN examinations ON
    examinations.subject_name = subjects.subject_name AND
    examinations.student_id = students.student_id
```

Both conditions are necessary: you need to match on both student AND subject, otherwise Alice's Math exams could end up attached to Bob's row.

After this join: student-subject combos that have exam records get one row per exam attempt. Combos with no exams get one row with NULL in all examinations columns.

Step 3 — GROUP BY to collapse multiple exam rows into one:
```
GROUP BY students.student_id, students.student_name, subjects.subject_name
```

All three columns must be here because they're all in SELECT and none are aggregates.

Step 4 — COUNT to get the count:
```
COUNT(examinations.student_id) as attended_exams
```

Because examinations.student_id is NULL for students who never attended, COUNT skips those rows and returns 0. If you used COUNT(*) or COUNT(students.student_id), you'd always get at least 1.

## Pattern Introduced
CROSS JOIN + LEFT JOIN for "all combinations with optional match" — standard shape for "for every X and every Y, how many Z?"

## Watch Out For
- COUNT(students.student_id) instead of COUNT(examinations.student_id) — the left table's column is never NULL so you'd always count at least 1, even for students who never attended.
- GROUP BY must include all non-aggregated columns in SELECT — student_id, student_name, and subject_name all need to be there.
- LEFT JOIN needs both match conditions (student_id AND subject_name) — missing one would fan out rows incorrectly.

## Template
```sql
SELECT a.id, a.name, b.name, COUNT(c.id) as count
FROM a
CROSS JOIN b
LEFT JOIN c ON c.a_id = a.id AND c.b_id = b.id
GROUP BY a.id, a.name, b.name
ORDER BY a.id, b.name;
```

## Trace Through
After CROSS JOIN: 4 students × 3 subjects = 12 rows.
After LEFT JOIN: each row gets exam records attached, or NULL if none.
Alice+Math has 3 exam records → 3 rows. Alice+Physics has 1. Alice+Programming has 0 → 1 row with NULL.
After GROUP BY + COUNT(examinations.student_id): Alice+Math=3, Alice+Physics=1, Alice+Programming=0, etc.

## Complexity / Correctness
O(students × subjects × exams). CROSS JOIN grows the intermediate set, so works fine when both base tables are small. For large tables, filtering before the CROSS JOIN helps.

## Submissions
https://leetcode.com/problems/students-and-examinations/submissions/2036363981

## Open Questions
None.
