-- Zadanie 1: 

BEGIN TRANSACTION;
UPDATE Production.Product
SET ListPrice = ListPrice * 1.1
WHERE ProductID = 680;
COMMIT TRANSACTION;

-- Zadanie 2: 
BEGIN TRANSACTION;
INSERT INTO Production.Product (Name, ProductNumber, SafetyStockLevel, ListPrice, ReorderPoint, StandardCost, DaysToManufacture, SellStartDate)
VALUES ('nowy produktt', 'numer nowego produktuu', 1, 50.00, 1, 15, 1, 2003-01-15 );
COMMIT TRANSACTION;

-- Zadanie 3:
BEGIN TRANSACTION;
DELETE FROM Production.Product
WHERE ProductID = SCOPE_IDENTITY();
ROLLBACK TRANSACTION;


-- Zadanie 4:
BEGIN TRANSACTION;
DECLARE @TotalCost DECIMAL(18, 2);
SET @TotalCost = (SELECT SUM(StandardCost * 1.1) FROM Production.Product);

IF @TotalCost <= 50000
BEGIN
    UPDATE Production.Product
    SET StandardCost = StandardCost * 1.1;
    COMMIT TRANSACTION;
END
ELSE
BEGIN
    ROLLBACK TRANSACTION;
END


-- Zadanie 5:
BEGIN TRANSACTION;
IF NOT EXISTS (SELECT 1 FROM Production.Product WHERE ProductNumber = 'NWPRD001')
BEGIN
    INSERT INTO Production.Product (Name, ProductNumber, ListPrice, SafetyStockLevel, ReorderPoint,StandardCost,DaysToManufacture,SellStartDate)
    VALUES ('New Product', 'NWPRD001', 50.00, 15,3,10,18,2008-04-30);
    COMMIT TRANSACTION;
END
ELSE
BEGIN
    ROLLBACK TRANSACTION;
END

-- Zadanie 6:
BEGIN TRANSACTION;
IF EXISTS (SELECT OrderQty FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
BEGIN
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    UPDATE Sales.SalesOrderDetail
    SET OrderQty = OrderQty * 2; 
    COMMIT TRANSACTION;
END


-- Zadanie 7:
BEGIN TRANSACTION;
DECLARE @AvgCost DECIMAL(18, 2);
SET @AvgCost = (SELECT AVG(StandardCost) FROM Production.Product);

DECLARE @CountModified INT;
SET @CountModified = (SELECT COUNT(*) FROM Production.Product WHERE StandardCost > @AvgCost);

IF @CountModified <= 200
BEGIN
    UPDATE Production.Product
    SET StandardCost = @AvgCost
    WHERE StandardCost > @AvgCost;
    COMMIT TRANSACTION;
END
ELSE
BEGIN
    ROLLBACK TRANSACTION;
END
