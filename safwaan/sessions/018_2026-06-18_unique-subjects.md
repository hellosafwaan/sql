# Session: Number of Unique Subjects Taught by Each Teacher — 2026-06-18

## What He Attempted
Correctly identified GROUP BY teacher_id + COUNT(DISTINCT subject_id) after a brief pause where he thought he might need "two levels of grouping" for both teacher and subject.

## Where He Got Stuck
Briefly — wondered if subject needed its own GROUP BY level. Resolved it himself when asked what he needed per teacher.

## Mistakes Made
None. Clean first solve.

## Key Insight
COUNT(DISTINCT col) collapses duplicates within a group before counting — no need for a nested GROUP BY. One group level (teacher), one DISTINCT count inside it.

## Complexity / Correctness Notes
O(n) scan with GROUP BY. No NULL concerns — subject_id is a primary key column.

## Coach Notes for Next Session
Nothing to flag — clean solve, pattern absorbed.
