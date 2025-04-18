CREATE VIEW vw_DailyProductSales AS
SELECT 
    CAST(S.SaleDate AS DATE) AS SaleDate,
    P.ProductName,
    SUM(S.Quantity) AS TotalUnitsSold,
    SUM(S.Quantity * P.Price) AS GrossRevenue
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY CAST(S.SaleDate AS DATE), P.ProductName;

CREATE VIEW vw_StoreRevenueRanking AS
SELECT
    S.StoreID,
    ST.StoreName,
    SUM(S.Quantity * P.Price) AS TotalRevenue,
    RANK() OVER (ORDER BY SUM(S.Quantity * P.Price) DESC) AS RevenueRank
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
JOIN Stores ST ON S.StoreID = ST.StoreID
GROUP BY S.StoreID, ST.StoreName;

CREATE VIEW vw_FullInvoiceDetails AS
SELECT 
    I.InvoiceID,
    C.CustomerName,
    P.ProductName,
    ST.StoreName,
    I.Quantity,
    I.PricePerUnit,
    I.Discount,
    I.Tax,
    I.FinalAmount,
    I.InvoiceDate
FROM Invoices I
JOIN Customers C ON I.CustomerID = C.CustomerID
JOIN Products P ON I.ProductID = P.ProductID
JOIN Stores ST ON I.StoreID = ST.StoreID;
