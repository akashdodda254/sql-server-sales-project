CREATE FUNCTION fn_CalculateTotalAmount (
    @ProductID INT,
    @Quantity INT,
    @Discount DECIMAL(5,2),
    @Tax DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Price DECIMAL(10,2);
    DECLARE @Total DECIMAL(10,2);

    SELECT @Price = Price FROM Products WHERE ProductID = @ProductID;

    SET @Total = (@Price * @Quantity);
    SET @Total = @Total + (@Total * @Tax / 100) - (@Total * @Discount / 100);

    RETURN @Total;
END;
