# Session 000: Phase 1 — SELECT Basics — 2026-06-17

> Retroactively logged. These 5 problems were solved before formal session tracking began —
> done as a warmup batch at the very start of the SQL track (12:52–13:04 on June 17th).

## Problems Solved

| LC | Problem | Submitted |
|----|---------|-----------|
| #1757 | Recyclable and Low Fat Products | 12:52 |
| #584 | Find Customer Referee | 12:55 |
| #595 | Big Countries | 12:55 |
| #1148 | Article Views I | 13:01 |
| #1683 | Invalid Tweets | 13:04 |

## What He Attempted
All five solved on first attempt with clean, accepted submissions. No wrong answers.

## Where He Got Stuck
Nothing major — these are the simplest possible WHERE filter problems. The one with any conceptual depth was LC #584, where `referee_id != 2` would silently drop NULL rows. Used `IS NULL OR != 2` correctly.

## Mistakes Made
None logged — these were clean solves before tracking was in place.

## Key Insight
The standout conceptual moment in this batch was LC #584 (Find Customer Referee): `NULL != 2` does not return TRUE — it returns NULL. SQL's three-valued logic means any comparison with NULL is unknown, and WHERE only passes TRUE. To catch NULL rows you need `IS NULL` explicitly. This is the first exposure to SQL's NULL semantics in a WHERE filter.

LC #1148 (Article Views I): used GROUP BY author_id instead of SELECT DISTINCT — both work, DISTINCT is more idiomatic when no aggregation is needed.

## Coach Notes for Next Session
- These problems are all done. Phase 1 is now 5/6 complete (only LC #175 Combine Two Tables remaining).
- NULL handling from LC #584 is the one concept to revisit — it will surface again in LEFT JOIN contexts. Keep an eye on whether he reaches for `IS NULL` instinctively in future WHERE filters or needs reminding.
- No patterns from this batch need active probing — they're all simple enough to be self-reinforcing.
