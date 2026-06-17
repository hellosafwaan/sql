# Session: Monthly Transactions I (LC #1193) — 2026-06-18

## What He Attempted
**Attempt 1:**
```sql
SELECT TO_CHAR(trans_date, 'YYYY-MM') AS month, country,
       COUNT(country) AS trans_count,
       COUNT(state = 'approved') AS approve_count,
       SUM(amount) AS trans_total_amount
FROM transactions
GROUP BY TO_CHAR(trans_date, 'YYYY-MM'), country;
```
Two bugs: `COUNT(state = 'approved')` counts all rows; missing `approved_total_amount`.

**Attempt 2 (CASE WHEN added, COUNT(country) still there):**
```sql
-- Had CASE WHEN for both approved_count and approved_total_amount
-- Still using COUNT(country) → returned 0 for null-country group
```

**Attempt 3 → Accepted:**
```sql
SELECT TO_CHAR(trans_date, 'YYYY-MM') AS month, country,
       COUNT(*) AS trans_count,
       SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
       SUM(amount) AS trans_total_amount,
       SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM transactions
GROUP BY TO_CHAR(trans_date, 'YYYY-MM'), country;
```

## Where He Got Stuck
1. **COUNT(boolean) trap** — third encounter. When pushed to explain what was wrong, couldn't recall. Still needs explicit explanation each time.
2. **COUNT(country) vs COUNT(*)** — caught from seeing wrong output (trans_count=0 for null country). Self-corrected immediately after seeing the data.
3. **approved_total_amount** — got there independently once CASE WHEN was understood.

## Mistakes Made
- `COUNT(state = 'approved')` — third time this trap has fired. Still not automatic.
- `COUNT(country)` skips NULLs — caught from output, not anticipated.

## Key Insight
CASE WHEN can return either a fixed value (1/0 for counting) or a column value (amount for summing). Same pattern, two uses. `TO_CHAR(date, 'YYYY-MM')` for month grouping — must appear in GROUP BY as well.

## Complexity / Correctness Notes
O(n) single pass. No joins, no subqueries. country=NULL groups correctly because GROUP BY treats NULL as its own group.

## Coach Notes for Next Session
- COUNT(boolean) trap: third occurrence. This needs to become automatic. Before the next aggregation problem, probe: "if I write COUNT(condition), what does it count?"
- COUNT(*) vs COUNT(col): clean self-correction from output — he understands this when he sees it.
- CASE WHEN for both counting and summing: applied correctly and independently on the second attempt. Solidifying.
- GROUP BY completeness: fourth consecutive clean rep — call it solid.
- TO_CHAR is new syntax — probe on next date grouping problem.
