CREATE TABLE ErrorLogs (
    ErrorID INT PRIMARY KEY IDENTITY,
    ErrorMessage NVARCHAR(MAX),
    ErrorProcedure NVARCHAR(255),
    ErrorTime DATETIME DEFAULT GETDATE()
);

-- Drop and recreate the procedure
IF OBJECT_ID('sp_InsertSale', 'P') IS NOT NULL
    DROP PROCEDURE sp_InsertSale;
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
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Business logic
        INSERT INTO Sales (ProductID, CustomerID, StoreID, Quantity, Discount, Tax)
        VALUES (@ProductID, @CustomerID, @StoreID, @Quantity, @Discount, @Tax);

        -- Calculate final bill
        SET @FinalAmount = dbo.fn_CalculateTotalAmount(@ProductID, @Quantity, @Discount, @Tax);

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;

        INSERT INTO ErrorLogs (ErrorMessage, ErrorProcedure)
        VALUES (ERROR_MESSAGE(), ERROR_PROCEDURE());

        SET @FinalAmount = -1;
    END CATCH
END;
