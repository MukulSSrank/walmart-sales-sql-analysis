WITH CustomerSpending AS (
    SELECT 
        `Customer ID`,
        SUM(Total) AS TotalSpent
    FROM walmartsales
    GROUP BY `Customer ID`
)
SELECT 
    `Customer ID`,
    TotalSpent,
    CASE 
        WHEN TotalSpent >= 25000 THEN 'High Spender'
        WHEN TotalSpent BETWEEN 20000 AND 24000.99 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS CustomerSegment
FROM CustomerSpending
ORDER BY TotalSpent DESC;
