SELECT query_name,
       ROUND(AVG(rating::numeric / position), 2) AS quality,
       ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END)::numeric * 100 / COUNT(*), 2) AS poor_query_percentage
FROM queries
GROUP BY query_name;
