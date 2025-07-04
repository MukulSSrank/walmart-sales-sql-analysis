WITH ProductProfit AS (
    SELECT 
        Branch,
        `Product line`,
        SUM(`gross income`) AS TotalProfit
    FROM walmartsales
    GROUP BY Branch, `Product line`
),
RankedProfit AS (
    SELECT 
        Branch,
        `Product line`,
        TotalProfit,
        ROW_NUMBER() OVER (PARTITION BY Branch ORDER BY TotalProfit DESC) AS rnk
    FROM ProductProfit
)
SELECT 
    Branch,
    `Product line`,
    TotalProfit
FROM RankedProfit
WHERE rnk = 1;
