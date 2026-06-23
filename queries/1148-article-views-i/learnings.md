Session: [000_2026-06-17_phase-1-select-basics](../../safwaan/sessions/000_2026-06-17_phase-1-select-basics.md)

## How It Felt
The table design is the key — once you see that `author_id = viewer_id` means the author saw their own article, the filter writes itself. The main thing to remember is deduplication and ordering.

## Key Insight
The Views table can have multiple rows for the same author viewing their own articles (different articles, different dates). The output needs one row per author, sorted by id. That's what DISTINCT (or GROUP BY) handles. Using `DISTINCT author_id` is more direct than GROUP BY here — you're not aggregating, just collapsing duplicates.

## Solution Walkthrough
The Views table has: article_id, author_id, viewer_id, view_date. When author_id = viewer_id, that row represents someone reading their own article.

So: filter WHERE author_id = viewer_id. The remaining rows are all self-views. But the same author might have viewed multiple of their own articles — so those rows would repeat. DISTINCT collapses them to one row per author_id. Alias it as `id` for the output column name, and ORDER BY id ASC.

```sql
SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id ASC;
```

Your original solution used GROUP BY author_id instead of DISTINCT — that works too. Both produce the same result here. DISTINCT is slightly more direct when you're not aggregating.

## Pattern Introduced
SELECT DISTINCT — deduplicate output rows. Useful when the filter alone produces one row per event but the output wants one row per entity.

## Watch Out For
- Don't forget ORDER BY — the problem requires ascending order, and without it the output order is undefined.
- GROUP BY without an aggregate works as deduplication, but DISTINCT is cleaner when that's all you need.

## Template
```sql
SELECT DISTINCT col AS alias
FROM table
WHERE self_reference_condition
ORDER BY alias ASC;
```

## Trace Through
| article_id | author_id | viewer_id | author=viewer? |
|-----------|----------|----------|----------------|
| 1 | 3 | 5 | No |
| 1 | 3 | 6 | No |
| 2 | 7 | 7 | Yes → author_id 7 |
| 2 | 7 | 6 | No |
| 4 | 7 | 1 | No |
| 3 | 4 | 4 | Yes → author_id 4 |

After DISTINCT: ids 4 and 7. After ORDER BY: 4, 7.

## Complexity / Correctness
O(n) scan + dedup. No NULLs to worry about; the equality condition correctly handles the self-view check.

## Submissions
https://leetcode.com/problems/article-views-i/submissions/2036064491
Accepted — 13/13 test cases, 396ms

## Open Questions
None.
