-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50),
    Price DECIMAL(10,2),
    IsActive BIT DEFAULT 1
);

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(100),
    Email NVARCHAR(100) UNIQUE,
    Location NVARCHAR(100)
);

-- Stores Table
CREATE TABLE Stores (
    StoreID INT PRIMARY KEY IDENTITY(1,1),
    StoreName NVARCHAR(100),
    Location NVARCHAR(100),
    ManagerName NVARCHAR(100)
);

-- Sales Table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    CustomerID INT,
    StoreID INT,
    Quantity INT,
    SaleDate DATETIME DEFAULT GETDATE(),
    Discount DECIMAL(5,2) DEFAULT 0,
    Tax DECIMAL(5,2) DEFAULT 0,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
);

