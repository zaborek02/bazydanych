--zad 1

CREATE TABLE TempEmployeeInfo
(
    EmployeeID INT, FirstName NVARCHAR(50), LastName NVARCHAR(50), JobTitle NVARCHAR(100), Rate MONEY, RateChangeDate DATE
);

WITH EmployeeRatesCTE AS
(
    SELECT e.BusinessEntityID AS EmployeeID, pp.FirstName, pp.LastName, e.JobTitle, p.Rate, p.RateChangeDate
    FROM HumanResources.Employee e
    INNER JOIN HumanResources.EmployeePayHistory p ON e.BusinessEntityID = p.BusinessEntityID
    INNER JOIN Person.Person pp ON e.BusinessEntityID = pp.BusinessEntityID
)

INSERT INTO TempEmployeeInfo (EmployeeID, FirstName, LastName, JobTitle, Rate, RateChangeDate)
SELECT EmployeeID, FirstName, LastName, JobTitle, Rate, RateChangeDate
FROM EmployeeRatesCTE;
SELECT *
FROM TempEmployeeInfo;

--zad2

WITH SalesInfoCTE AS
(
    SELECT c.CustomerID,
        CONCAT(c.CompanyName, '( ', c.FirstName, ' ', c.LastName, ')') AS CompanyContact, soh.TotalDue
    FROM SalesLT.Customer c
    INNER JOIN SalesLT.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
)

SELECT
    CompanyContact, SUM(TotalDue) AS Revenue
FROM
    SalesInfoCTE
GROUP BY
    CompanyContact
ORDER BY CompanyContact ASC;


--zad 3

WITH SalesByCategoryCTE AS
(
    SELECT pc.Name AS CategoryName, p.Name AS ProductName, sod.OrderQty * sod.UnitPrice AS SalesAmount
    FROM SalesLT.SalesOrderDetail sod
    INNER JOIN SalesLT.Product p ON sod.ProductID = p.ProductID
    INNER JOIN SalesLT.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID
)

SELECT CategoryName, SUM(SalesAmount) AS TotalSales
FROM SalesByCategoryCTE
GROUP BY CategoryName
ORDER BY TotalSales DESC;