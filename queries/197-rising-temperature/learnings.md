Session: [004_2026-06-17_rising-temperature](../../safwaan/sessions/004_2026-06-17_rising-temperature.md)

## How It Felt
Clicked fast. Immediately saw "comparing rows in the same table" → self-join. Wrote the solution cold, then asked to articulate how the self-join actually works.

## Key Insight
A self-join is just a regular JOIN where both sides happen to be the same table. The aliases (t1, t2) let you treat them as two separate copies. The ON condition defines *which rows get paired*: here, you pair each day in t1 with the day exactly one day later in t2. Then WHERE filters for the pairs where temperature went up.

## Solution Walkthrough
The problem: find all dates where the temperature was higher than the previous day.

There's only one table: Weather. To compare two different rows in the same table, you join it with itself. Imagine making two copies: t1 and t2.

The pairing condition: you want t2 to be exactly one day after t1:
```
t2.recordDate = t1.recordDate + 1
```

After this join, each row in the result has two days side by side: t1 (yesterday) and t2 (today). Then you just filter:
```
WHERE t2.temperature > t1.temperature
```

And return the id for today's date (t2.id).

Full query:
```sql
SELECT t2.id
FROM weather t1
JOIN weather t2 ON t2.recordDate = t1.recordDate + 1
WHERE t2.temperature > t1.temperature;
```

## Pattern Introduced
Self-join for row comparison — when you need to compare a row against another row in the same table, use aliases to create two "virtual copies" and JOIN them on a shifted key.

## Watch Out For
- `recordDate + 1` works in MySQL and LeetCode's Postgres mode, but on a real Postgres instance use `t1.recordDate + INTERVAL '1 day'`.
- The `+ 1` shorthand only works for date types, not timestamps.

## Template
```sql
SELECT t2.id
FROM table t1
JOIN table t2 ON t2.date_col = t1.date_col + 1
WHERE t2.value_col > t1.value_col;
```

## Trace Through
Weather: dates 2015-01-01 (temp 10), 2015-01-02 (temp 25), 2015-01-03 (temp 20), 2015-01-04 (temp 30).
After self-join on +1 day: pairs are (Jan1,Jan2), (Jan2,Jan3), (Jan3,Jan4).
After WHERE: Jan2 (25>10) and Jan4 (30>20) pass. Return ids for those dates.

## Complexity / Correctness
O(n log n) with an index on recordDate. No NULLs to worry about.

## Submissions
https://leetcode.com/problems/rising-temperature/submissions/2036294631

## Open Questions
None.
