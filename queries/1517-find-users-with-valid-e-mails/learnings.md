Session: [038_2026-06-22_find-users-with-valid-e-mails](../../safwaan/sessions/038_2026-06-22_find-users-with-valid-e-mails.md)

## How It Felt
Completely new territory — first regex problem. Conceptually grasped the structure after the explanation, applied it correctly on first try.

## Key Insight
A regex pattern describes a string's shape precisely. Break the email into three parts and express each as a regex fragment: `^` anchors the start, `[a-zA-Z]` matches one letter, `[a-zA-Z0-9_.\-]*` matches zero or more valid prefix chars, `@leetcode\.com` is a literal match with `\.` escaping the dot, `$` anchors the end.

## Solution Walkthrough
Email validation has three rules:
1. First character must be a letter
2. Rest of prefix: letters, digits, underscores, dots, dashes only
3. Domain must be exactly `@leetcode.com`

In Postgres, `~` is the case-sensitive regex match operator.

```sql
SELECT *
FROM Users
WHERE mail ~ '^[a-zA-Z][a-zA-Z0-9_.\-]*@leetcode\.com$';
```

Breaking down the pattern:
- `^` — start of string (without this, the pattern could match anywhere inside)
- `[a-zA-Z]` — exactly one character, must be a letter
- `[a-zA-Z0-9_.\-]*` — zero or more valid prefix chars; `*` means zero or more
- `@leetcode` — literal
- `\.` — literal dot (unescaped `.` means "any character" in regex)
- `com` — literal
- `$` — end of string (without this, junk after `.com` would still match)

## Pattern Introduced
**Regex match in Postgres:** `col ~ 'pattern'` (case-sensitive), `col ~* 'pattern'` (case-insensitive)
**Regex anchors:** `^` = start, `$` = end
**Character classes:** `[a-z]`, `[A-Z]`, `[0-9]`, combinations like `[a-zA-Z0-9_.\-]`
**Quantifiers:** `*` = zero or more, `+` = one or more, `?` = zero or one

## Watch Out For
- Without `^` and `$`, the regex matches a substring — not the full string.
- `.` unescaped matches any character. Always escape: `\.` for a literal dot.
- In MySQL: use `REGEXP` keyword, not `~`. Pattern anchors work the same.

## Template
```sql
-- Postgres regex match
WHERE col ~ '^[start-char-class][valid-chars]*@domain\.tld$'

-- MySQL equivalent
WHERE col REGEXP '^[start-char-class][valid-chars]*@domain\\.tld$'
```

## Complexity / Correctness
O(n) full scan — no index on varchar for regex patterns.

## Submissions
https://leetcode.com/problems/find-users-with-valid-e-mails/submissions/2042439116

## Open Questions
- When would you use `~*` (case-insensitive) vs `~`?
