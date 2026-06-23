-- NULL != 2 evaluates to NULL (not TRUE), so IS NULL must be explicit
SELECT name
FROM Customer
WHERE referee_id IS NULL
   OR referee_id != 2;
