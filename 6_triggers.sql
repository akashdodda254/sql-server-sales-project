CREATE TRIGGER trg_UpdateInventoryAfterSale
ON Sales
AFTER INSERT
AS
BEGIN
    UPDATE I
    SET I.StockAvailable = I.StockAvailable - S.Quantity
    FROM Inventory I
    JOIN inserted S ON I.ProductID = S.ProductID;
END;

CREATE TRIGGER trg_LowStockCheck
ON Inventory
AFTER UPDATE
AS
BEGIN
    INSERT INTO LowStockAlerts (ProductID, StockLeft)
    SELECT ProductID, StockAvailable
    FROM inserted
    WHERE StockAvailable < ReorderLevel;
END;

CREATE TRIGGER trg_AuditSalesUpdate
ON Sales
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditSalesLog (SaleID, ProductID, CustomerID, StoreID, Quantity, SaleDate, OperationType)
    SELECT 
        S.SaleID, S.ProductID, S.CustomerID, S.StoreID, S.Quantity, S.SaleDate, 'UPDATE'
    FROM inserted S;
END;

CREATE TRIGGER trg_AuditSalesDelete
ON Sales
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditSalesLog (SaleID, ProductID, CustomerID, StoreID, Quantity, SaleDate, OperationType)
    SELECT 
        S.SaleID, S.ProductID, S.CustomerID, S.StoreID, S.Quantity, S.SaleDate, 'DELETE'
    FROM deleted S;
END;
