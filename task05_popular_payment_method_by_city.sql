WITH PaymentCounts AS (
    SELECT 
        City,
        Payment,
        COUNT(*) AS PaymentCount
    FROM walmartsales
    GROUP BY City, Payment
),
RankedPayments AS (
    SELECT 
        City,
        Payment,
        PaymentCount,
        ROW_NUMBER() OVER (PARTITION BY City ORDER BY PaymentCount DESC) AS rnk
    FROM PaymentCounts
)
SELECT 
    City,
    Payment AS MostPopularPayment,
    PaymentCount
FROM RankedPayments
WHERE rnk = 1;
