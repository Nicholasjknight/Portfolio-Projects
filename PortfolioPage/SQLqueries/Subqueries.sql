--Self contained scalar subquery

SELECT *
FROM Sales
WHERE EmpID = (SELECT Max (EmpID) FROM SalesPerson)


--Scalar subquery used in the SELECT statement

SELECT First_Name, Last_Name, (Select Sum(Price) from Sales) AS Sum_Price
FROM [Subqueries].[dbo].[SalesPerson]
ORDER BY Last_Name



--Scalar Correlated subquery. Scalar subquery used in the SELECT statement and a correlated query used in the WHERE statement

SELECT First_Name, Last_Name, (Select Sum(Price) from Sales) AS Team_Sum, (Select Sum (Price) from Sales WHERE SalesPerson.EmpID =Sales.EmpID) AS SalesPerson_Sum
FROM [Subqueries].[dbo].[SalesPerson]



-- Self-contained multivalued subquery

SELECT First_Name, Last_Name
FROM [Subqueries].[dbo].[SalesPerson]
WHERE EmpID IN (SELECT EmpID
FROM [Subqueries].[dbo].[Sales]
WHERE [Price]>2000)




--Correlated Subquery using the EXISTS syntax

SELECT First_Name, Last_Name, EmpID
FROM dbo.SalesPerson
WHERE First_Name = 'Gail' AND EXISTS (Select * FROM Sales WHERE Sales.EmpID= SalesPerson.EmpID)