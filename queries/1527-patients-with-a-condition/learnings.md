Session: [033_2026-06-22_patients-with-a-condition](../../safwaan/sessions/033_2026-06-22_patients-with-a-condition.md)

## How It Felt
Clean. The two-case reasoning ("at the start OR after a space") came naturally from thinking about it like a word-boundary check.

## Key Insight
A space-delimited list doesn't have a split function in SQL — but `LIKE` can simulate word-boundary matching with two patterns: one for the first word (`'DIAB1%'`) and one for any word after a space (`'% DIAB1%'`).

## Solution Walkthrough
The conditions column looks like `'DIAB100 MYOP10'` — space-separated codes. You want codes that **start with** DIAB1, not just contain it (so SADIAB100 is invalid).

Two cases:
1. DIAB1 is the **first code**: `conditions LIKE 'DIAB1%'` — matches from the start of the string
2. DIAB1 is a **later code**: always has a space before it → `conditions LIKE '% DIAB1%'`

Put them together with OR. The `%` wildcard matches any sequence of characters (including none), so `DIAB1%` matches DIAB100, DIAB1XYZ, etc.

## Pattern Introduced
**Word-boundary LIKE:** two patterns to cover "first word" vs "after a space" cases.

Equivalent regex (one expression): `conditions ~ '(^| )DIAB1'`

## Watch Out For
- `LIKE '%DIAB1%'` without anchoring would match SADIAB100 — wrong.
- `LIKE` syntax has no `=`: `WHERE col LIKE 'pattern'`, not `WHERE col LIKE = 'pattern'`.

## Template
```sql
-- Match "word starts with PREFIX" in a space-separated list
WHERE col LIKE 'PREFIX%'
   OR col LIKE '% PREFIX%'
```

## Trace Through
| conditions         | LIKE 'DIAB1%' | LIKE '% DIAB1%' | match? |
|--------------------|---------------|-----------------|--------|
| DIAB100 MYOP10     | ✓             | —               | yes    |
| ACNE DIAB100       | —             | ✓               | yes    |
| SADIAB100          | —             | —               | no     |
| DIAB1              | ✓             | —               | yes    |

## Complexity / Correctness
O(n) full scan — leading wildcard in the second pattern (`'% DIAB1%'`) prevents index use.

## Submissions
https://leetcode.com/problems/patients-with-a-condition/submissions/2042190970

## Open Questions
None.
