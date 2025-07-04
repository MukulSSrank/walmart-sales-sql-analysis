WITH SalesStats AS (
    SELECT 
        `Product line`,
        AVG(Total) AS AverageSale
    FROM walmartsales
    GROUP BY `Product line`
)
SELECT 
    w.`Invoice ID`,
    w.`Product line`,
    w.Total,
    CASE
        WHEN w.Total > s.AverageSale * 1.5 THEN 'Very High Sale'
        WHEN w.Total < s.AverageSale * 0.5 THEN 'Very Low Sale'
        ELSE 'Normal'
    END AS SaleType
FROM walmartsales w
JOIN SalesStats s
ON w.`Product line` = s.`Product line`
WHERE 
    w.Total > s.AverageSale * 1.5
    OR w.Total < s.AverageSale * 0.5
ORDER BY w.Total DESC;
