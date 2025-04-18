-- Store Manager 1
CREATE LOGIN StoreMgr_Hyd WITH PASSWORD = 'Hyd@123';
CREATE USER StoreMgr_Hyd FOR LOGIN StoreMgr_Hyd;
GRANT SELECT ON Sales TO StoreMgr_Hyd;

-- Store Manager 2
CREATE LOGIN StoreMgr_Blore WITH PASSWORD = 'Blore@123';
CREATE USER StoreMgr_Blore FOR LOGIN StoreMgr_Blore;
GRANT SELECT ON Sales TO StoreMgr_Blore;

CREATE TABLE StoreUserAccess (
    Username NVARCHAR(100),
    StoreID INT
);

-- Simulate usernames with access to each store
INSERT INTO StoreUserAccess (Username, StoreID)
VALUES 
    ('StoreMgr_Hyd', 1),
    ('StoreMgr_Blore', 2);

CREATE VIEW vw_StoreWiseSales AS
SELECT S.*
FROM Sales S
JOIN StoreUserAccess SUA
    ON S.StoreID = SUA.StoreID
WHERE SUA.Username = SYSTEM_USER;  -- Simulates filtering based on who runs the query
