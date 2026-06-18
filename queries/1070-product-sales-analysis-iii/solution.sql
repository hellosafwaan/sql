SELECT sales.product_id, s2.first_year, sales.quantity, sales.price
FROM sales
INNER JOIN (
    SELECT product_id, MIN(year) AS first_year
    FROM sales
    GROUP BY product_id
) AS s2
    ON s2.product_id = sales.product_id
   AND s2.first_year = sales.year;
