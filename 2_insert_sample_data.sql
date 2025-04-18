INSERT INTO Products (ProductName, Category, Price)
VALUES ('Smartphone', 'Electronics', 25000),
       ('Bluetooth Headset', 'Accessories', 1500),
       ('Fitness Tracker', 'Wearable', 4000);

INSERT INTO Customers (CustomerName, Email, Location)
VALUES ('Akash', 'akash@example.com', 'Hyderabad'),
       ('Riya', 'riya@example.com', 'Delhi');

INSERT INTO Stores (StoreName, Location, ManagerName)
VALUES ('Main Branch', 'Hyderabad', 'Rakesh'),
       ('City Mall Store', 'Bangalore', 'Anita');

INSERT INTO Sales (ProductID, CustomerID, StoreID, Quantity, Discount, Tax)
VALUES (1, 1, 1, 2, 5, 18),
       (2, 2, 2, 1, 10, 18);

