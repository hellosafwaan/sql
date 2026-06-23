-- WHERE + AND: filter rows meeting both conditions simultaneously
SELECT product_id
FROM Products
WHERE low_fats = 'Y'
  AND recyclable = 'Y';
