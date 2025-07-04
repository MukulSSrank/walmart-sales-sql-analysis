SELECT 
    Gender,
    DATE_FORMAT(
        CASE 
            WHEN Date LIKE '%-%-%' THEN STR_TO_DATE(Date, '%d-%m-%Y')
            ELSE STR_TO_DATE(Date, '%Y-%m-%d')
        END, 
        '%Y-%m'
    ) AS SaleMonth,
    SUM(Total) AS TotalSales
FROM walmartsales
GROUP BY Gender, SaleMonth
ORDER BY SaleMonth, Gender;
