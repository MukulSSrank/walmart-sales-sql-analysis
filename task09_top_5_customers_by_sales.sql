SELECT 
    `Customer ID`,
    SUM(Total) AS TotalSpent
FROM walmartsales
GROUP BY `Customer ID`
ORDER BY TotalSpent DESC
LIMIT 5;
