DECLARE @Final DECIMAL(10,2);

EXEC sp_InsertSale 
    @ProductID = 3,
    @CustomerID = 1,
    @StoreID = 2,
    @Quantity = 1,
    @Discount = 10,
    @Tax = 18,
    @FinalAmount = @Final OUTPUT;

SELECT @Final AS FinalBillAmount;

DECLARE @Bill DECIMAL(10,2);

EXEC sp_InsertSale 
    @ProductID = 1,  -- Smartphone
    @CustomerID = 2,
    @StoreID = 1,
    @Quantity = 8,
    @Discount = 5,
    @Tax = 18,
    @FinalAmount = @Bill OUTPUT;

SELECT @Bill AS FinalBill;

DECLARE @Final DECIMAL(10,2);

EXEC sp_InsertSale 
    @ProductID = 99,  -- Invalid Product
    @CustomerID = 1,
    @StoreID = 1,
    @Quantity = 1,
    @Discount = 5,
    @Tax = 18,
    @FinalAmount = @Final OUTPUT;

SELECT @Final AS FinalBillAmount;

DECLARE @Final DECIMAL(10,2);

EXEC sp_InsertSale 
    @ProductID = 2,
    @CustomerID = 2,
    @StoreID = 1,
    @Quantity = 2,
    @Discount = 5,
    @Tax = 18,
    @FinalAmount = @Final OUTPUT;

SELECT @Final AS FinalBill;

EXEC sp_RefreshSalesSummaries;
