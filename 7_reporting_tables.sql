CREATE TABLE DailySalesSummary (
    SummaryDate DATE,
    ProductID INT,
    TotalUnitsSold INT,
    TotalRevenue DECIMAL(12,2),
    PRIMARY KEY (SummaryDate, ProductID)
);

CREATE TABLE MonthlySalesSummary (
    SummaryMonth VARCHAR(7), -- Format: YYYY-MM
    ProductID INT,
    TotalUnitsSold INT,
    TotalRevenue DECIMAL(12,2),
    PRIMARY KEY (SummaryMonth, ProductID)
);
