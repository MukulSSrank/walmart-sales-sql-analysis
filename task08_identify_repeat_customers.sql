WITH CustomerPurchases AS (
    SELECT 
        `Customer ID`,
        CASE 
            WHEN Date LIKE '%-%-%' THEN STR_TO_DATE(Date, '%d-%m-%Y')
            ELSE STR_TO_DATE(Date, '%Y-%m-%d')
        END AS PurchaseDate
    FROM walmartsales
),
RankedPurchases AS (
    SELECT 
        `Customer ID`,
        PurchaseDate,
        LAG(PurchaseDate) OVER (PARTITION BY `Customer ID` ORDER BY PurchaseDate) AS PrevPurchaseDate
    FROM CustomerPurchases
)
SELECT 
    `Customer ID`,
    PurchaseDate,
    PrevPurchaseDate,
    DATEDIFF(PurchaseDate, PrevPurchaseDate) AS DaysBetween
FROM RankedPurchases
WHERE 
    PrevPurchaseDate IS NOT NULL
    AND DATEDIFF(PurchaseDate, PrevPurchaseDate) <= 30
ORDER BY `Customer ID`, PurchaseDate;
