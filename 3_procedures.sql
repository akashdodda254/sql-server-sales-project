DROP PROCEDURE IF EXISTS sp_InsertSale;
GO

CREATE PROCEDURE sp_InsertSale
    @ProductID INT,
    @CustomerID INT,
    @StoreID INT,
    @Quantity INT,
    @Discount DECIMAL(5,2),
    @Tax DECIMAL(5,2),
    @FinalAmount DECIMAL(10,2) OUTPUT
AS
BEGIN
    DECLARE @SaleID INT;
    DECLARE @UnitPrice DECIMAL(10,2);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert into Sales
        INSERT INTO Sales (ProductID, CustomerID, StoreID, Quantity, Discount, Tax)
        VALUES (@ProductID, @CustomerID, @StoreID, @Quantity, @Discount, @Tax);

        SET @SaleID = SCOPE_IDENTITY();

        SELECT @UnitPrice = Price FROM Products WHERE ProductID = @ProductID;

        -- Calculate final amount
        SET @FinalAmount = dbo.fn_CalculateTotalAmount(@ProductID, @Quantity, @Discount, @Tax);

        -- Insert into Invoice
        INSERT INTO Invoices (SaleID, CustomerID, ProductID, StoreID, Quantity, PricePerUnit, Discount, Tax, FinalAmount)
        VALUES (@SaleID, @CustomerID, @ProductID, @StoreID, @Quantity, @UnitPrice, @Discount, @Tax, @FinalAmount);

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;

        INSERT INTO ErrorLogs (ErrorMessage, ErrorProcedure)
        VALUES (ERROR_MESSAGE(), ERROR_PROCEDURE());

        SET @FinalAmount = -1;
    END CATCH
END;


CREATE PROCEDURE sp_RefreshSalesSummaries
AS
BEGIN
    -- Clear existing data
    DELETE FROM DailySalesSummary;
    DELETE FROM MonthlySalesSummary;

    -- Insert Daily Summary
    INSERT INTO DailySalesSummary (SummaryDate, ProductID, TotalUnitsSold, TotalRevenue)
    SELECT 
        CAST(S.SaleDate AS DATE),
        S.ProductID,
        SUM(S.Quantity),
        SUM(S.Quantity * P.Price)
    FROM Sales S
    JOIN Products P ON S.ProductID = P.ProductID
    GROUP BY CAST(S.SaleDate AS DATE), S.ProductID;

    -- Insert Monthly Summary
    INSERT INTO MonthlySalesSummary (SummaryMonth, ProductID, TotalUnitsSold, TotalRevenue)
    SELECT 
        FORMAT(S.SaleDate, 'yyyy-MM'),
        S.ProductID,
        SUM(S.Quantity),
        SUM(S.Quantity * P.Price)
    FROM Sales S
    JOIN Products P ON S.ProductID = P.ProductID
    GROUP BY FORMAT(S.SaleDate, 'yyyy-MM'), S.ProductID;
END;
