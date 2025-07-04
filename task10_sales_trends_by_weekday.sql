SELECT 
    DAYNAME(
        CASE 
            WHEN Date LIKE '%-%-%' THEN STR_TO_DATE(Date, '%d-%m-%Y')
            ELSE STR_TO_DATE(Date, '%Y-%m-%d')
        END
    ) AS DayName,
    SUM(Total) AS TotalSales
FROM walmartsales
GROUP BY DayName
ORDER BY TotalSales DESC;
