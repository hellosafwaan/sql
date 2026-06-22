Session: [032_2026-06-22_fix-names-in-a-table](../../safwaan/sessions/032_2026-06-22_fix-names-in-a-table.md)

## How It Felt
Straightforward once SUBSTRING was named. The UPPER/LOWER/CONCAT pattern assembled itself — didn't need to be told the structure, just the missing function.

## Key Insight
Row-level string transformation: split the name into first character and the rest, apply UPPER to one and LOWER to the other, CONCAT them back together.

## Solution Walkthrough
The problem wants `Alice` from `aLice` or `ALICE`. So you need the first character uppercased and everything else lowercased.

UPPER/LOWER operate on a string. SUBSTRING extracts a piece. So:
- `SUBSTRING(name, 1, 1)` → first character
- `SUBSTRING(name, 2)` → everything from position 2 onward (no length = to end)
- Wrap in UPPER and LOWER respectively, then CONCAT.

No joins, no aggregation — pure projection on each row.

## Pattern Introduced
**String transformation:** CONCAT(UPPER(SUBSTRING(col, 1, 1)), LOWER(SUBSTRING(col, 2)))

## Watch Out For
- `SUBSTRING(name, 0, 2)` is a MySQL quirk — position 0 returns 1 character when length is 2. Standard/portable is `SUBSTRING(name, 1, 1)`.
- In MySQL you can also use `SUBSTR` as a shorthand.

## Template
```sql
SELECT id,
       CONCAT(UPPER(SUBSTRING(col, 1, 1)), LOWER(SUBSTRING(col, 2))) AS col
FROM table
ORDER BY id;
```

## Trace Through
| name   | SUBSTRING(name,1,1) | UPPER | SUBSTRING(name,2) | LOWER | CONCAT   |
|--------|---------------------|-------|-------------------|-------|----------|
| aLice  | a                   | A     | Lice              | lice  | Alice    |
| ALICE  | A                   | A     | LICE              | lice  | Alice    |
| bob    | b                   | B     | ob                | ob    | Bob      |

## Complexity / Correctness
O(n) — one pass over every row, string manipulation per row.

## Submissions
https://leetcode.com/problems/fix-names-in-a-table/submissions/2042169674

## Open Questions
None.
