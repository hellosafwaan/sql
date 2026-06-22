Session: [034_2026-06-22_delete-duplicate-emails](../../safwaan/sessions/034_2026-06-22_delete-duplicate-emails.md)

## How It Felt
The logic was clear — it's just a self-join to find duplicates. The only friction was Postgres DELETE syntax, which is different from MySQL.

## Key Insight
Write the SELECT that finds the rows to delete first. Then convert it to DELETE. In Postgres, `DELETE FROM ... USING` is the equivalent of MySQL's multi-table `DELETE t1 FROM ... JOIN`.

## Solution Walkthrough
You want to delete rows where the same email exists with a smaller id — keeping only the row with MIN(id) per email.

Self-join pairs up every two rows that share an email. The filter `p1.id > p2.id` means: "p1 is a duplicate with a higher id than p2." Delete those.

In MySQL: `DELETE p1 FROM Person p1 JOIN Person p2 ON ... WHERE p1.id > p2.id`
In Postgres: `DELETE FROM Person p1 USING Person p2 WHERE p1.email = p2.email AND p1.id > p2.id`

`USING` is just how Postgres says "join this table into my DELETE."

## Pattern Introduced
**DELETE with self-join (Postgres):** `DELETE FROM t alias1 USING t alias2 WHERE join + filter`

## Watch Out For
- In MySQL: `DELETE p1 FROM ...` — the alias before FROM specifies which side to delete.
- In Postgres: `DELETE FROM ... USING` — what follows USING is the other table; the table after FROM is what gets deleted.
- Alternative approach that avoids the join entirely: `DELETE FROM Person WHERE id NOT IN (SELECT MIN(id) FROM Person GROUP BY email)` — simpler and index-friendly.

## Template
```sql
-- Postgres multi-table delete
DELETE FROM table t1
USING table t2
WHERE t1.join_col = t2.join_col
  AND t1.col_to_delete > t2.col_to_keep;
```

## Complexity / Correctness
Self-join is O(n²) without an index on email. The NOT IN subquery approach is O(n log n) with a GROUP BY.

## Submissions
https://leetcode.com/problems/delete-duplicate-emails/submissions/2042209517

## Open Questions
None.
