WITH ProductSales AS (
    SELECT 
        `Customer type`,
        `Product line`,
        SUM(Total) AS TotalSales
    FROM walmartsales
    GROUP BY `Customer type`, `Product line`
),
RankedSales AS (
    SELECT 
        `Customer type`,
        `Product line`,
        TotalSales,
        ROW_NUMBER() OVER (PARTITION BY `Customer type` ORDER BY TotalSales DESC) AS rnk
    FROM ProductSales
)
SELECT 
    `Customer type`,
    `Product line` AS BestProductLine,
    TotalSales
FROM RankedSales
WHERE rnk = 1;
