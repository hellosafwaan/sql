# Session: Biggest Single Number — 2026-06-18

## What He Attempted
First attempt put MAX(num) inside the GROUP BY query with HAVING COUNT = 1 — which returns one row per single number, not the overall max. Then overcorrected to an unnecessary JOIN: inner-joined the subquery of single numbers back to MyNumbers to get the max. Accepted but over-engineered.

## Where He Got Stuck
The jump from "find all single numbers" to "find the largest of them" — first tried to solve both in one GROUP BY query, then reached for a JOIN when a simple outer SELECT MAX would do.

## Mistakes Made
- Tried to MAX and filter in one GROUP BY (doesn't collapse to one row)
- Unnecessary JOIN: joined subquery back to original table when just selecting from the subquery suffices

## Key Insight
Two-step: subquery filters to single numbers (GROUP BY + HAVING COUNT = 1), outer SELECT MAX picks the largest. No JOIN needed — you're not pulling columns from a second table. And MAX() on an empty set returns NULL automatically, so the edge case is free.

## Complexity / Correctness Notes
MAX() on empty set = NULL in both MySQL and Postgres. No COALESCE needed.

## Coach Notes for Next Session
"Do I need this JOIN?" — probe before he reaches for one. He over-reached for a JOIN here when a simple subquery in FROM was sufficient.
