# Session: Find Users With Valid E-Mails — 2026-06-22

## What He Attempted
Verbal: "I know I need some sort of [a-z] [A-Z] wildcard and use _@leetcode.com"

Final (after regex explanation):
```sql
SELECT *
FROM Users
WHERE mail ~ '^[a-zA-Z][a-zA-Z0-9_.\-]*@leetcode\.com$';
```

## Where He Got Stuck
Brand new to regex. Knew the right components existed conceptually (character classes, wildcards) but had never written a regex pattern. Needed full explanation of: `^` (anchor start), `[a-zA-Z]` (character class), `*` (zero or more), `\.` (escaped dot), `$` (anchor end), and `~` (Postgres regex operator).

## Mistakes Made
None after the explanation — applied the pattern correctly on first try.

## Key Insight
Regex is just a precise language for describing string shapes. The three-part structure — anchor start, character-by-character rules, anchor end — maps directly to the problem's three-part rule (valid first char, valid prefix chars, valid domain).

## Complexity / Correctness Notes
`~` in Postgres is case-sensitive. `~*` is case-insensitive. The `\.` escape is critical — without it `.` matches any character and `x@leetcodeXcom` would pass. Full table scan (O(n)) — no index on varchar for regex.

## Coach Notes for Next Session
Regex is completely new territory. Don't expect cold recall yet. Probe: "what operator does Postgres use for regex matching?" and "what does ^ do in a regex?"
