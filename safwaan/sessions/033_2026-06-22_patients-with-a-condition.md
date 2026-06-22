# Session: Patients With a Condition — 2026-06-22

## What He Attempted
Verbal: "I need to match DIAB1 at the start of the string OR after a space, because if it's mid-string there's always a space before it."

Written:
```sql
SELECT *
FROM Patients
WHERE conditions LIKE 'DIAB1%'
   OR conditions LIKE '% DIAB1%';
```

## Where He Got Stuck
Didn't get stuck. Needed one clarification on LIKE syntax (no `=` sign), but the two-case reasoning was fully his.

## Mistakes Made
Initial write used `LIKE = 'DIAB1%'` — syntax correction only, no logic correction needed.

## Key Insight
"If DIAB1 is at the start, no space before it. If it's in the middle, there's always a space before it." Got the false-positive case (SADIAB100) instinctively — he understood that matching mid-string without a space anchor would catch invalid entries.

## Complexity / Correctness Notes
Two LIKE conditions with OR covers all valid positions. REGEXP `(^| )DIAB1` is an equivalent single expression but not necessary here. Both are O(n) full scans — no index on varchar patterns.

## Coach Notes for Next Session
Pattern is solid. LIKE + two-case reasoning for word-boundary matching is a transferable skill.
