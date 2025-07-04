WITH MonthlySales AS (
    SELECT 
        Branch,
        DATE_FORMAT(
            CASE 
                WHEN Date LIKE '%-%-%' THEN 
                    STR_TO_DATE(Date, '%d-%m-%Y')  
                ELSE
                    STR_TO_DATE(Date, '%Y-%m-%d')  
            END
            , '%Y-%m') AS Month,
        SUM(Total) AS MonthlyTotal
    FROM walmartsales
    GROUP BY Branch, Month
),
SalesWithGrowth AS (
    SELECT 
        Branch,
        Month,
        MonthlyTotal,
        LAG(MonthlyTotal) OVER (PARTITION BY Branch ORDER BY Month) AS PrevMonthTotal,
        ROUND(((MonthlyTotal - LAG(MonthlyTotal) OVER (PARTITION BY Branch ORDER BY Month)) / 
               LAG(MonthlyTotal) OVER (PARTITION BY Branch ORDER BY Month)) * 100, 2) AS GrowthRate
    FROM MonthlySales
)
SELECT *
FROM SalesWithGrowth
ORDER BY GrowthRate DESC
LIMIT 5;
