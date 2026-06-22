-- Scalar subquery in SELECT returns NULL automatically when inner query produces no rows
SELECT (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;
