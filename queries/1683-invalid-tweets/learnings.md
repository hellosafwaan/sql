Session: [000_2026-06-17_phase-1-select-basics](../../safwaan/sessions/000_2026-06-17_phase-1-select-basics.md)

## How It Felt
Very direct. LENGTH() counts characters, compare to 15, return the tweet_ids. One thing to be precise about: the condition is strictly *greater than* 15, not >= 15.

## Key Insight
LENGTH() in Postgres returns the number of characters in a string. `LENGTH(content) > 15` means the tweet has 16 or more characters. The problem says invalid tweets have more than 15 characters, so `> 15` is exactly right (not `>= 15`, which would also catch 15-character tweets).

## Solution Walkthrough
You want tweet_ids where the content is too long. "Too long" means LENGTH(content) > 15.

```sql
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;
```

FROM loads the Tweets table. WHERE evaluates LENGTH(content) for each row — that's the number of characters in the tweet text. Rows where that count exceeds 15 make it through. SELECT returns just the tweet_id.

## Pattern Introduced
WHERE + string function — filter rows based on a computed property of a string column. LENGTH() is the simplest example; the same pattern applies with UPPER(), LOWER(), SUBSTRING(), etc.

## Watch Out For
- `> 15` vs `>= 15`: "more than 15" means strictly greater. 15 characters is valid; 16 is not.
- MySQL uses `LENGTH()` for byte count and `CHAR_LENGTH()` for character count (relevant for multibyte characters). Postgres `LENGTH()` counts characters. On LeetCode, this usually doesn't matter.

## Template
```sql
SELECT id_col
FROM table
WHERE LENGTH(text_col) > N;
```

## Trace Through
| tweet_id | content | LENGTH | > 15? |
|---------|---------|--------|-------|
| 1 | "Vote for Biden" | 15 | No |
| 2 | "Let us celebrate this day" | 26 | Yes |

Output: tweet_id 2.

## Complexity / Correctness
O(n) scan. LENGTH() is O(n) per string in the general case but constant here since tweet lengths are bounded.

## Submissions
https://leetcode.com/problems/invalid-tweets/submissions/2036066985
Accepted — 22/22 test cases, 475ms

## Open Questions
None.
