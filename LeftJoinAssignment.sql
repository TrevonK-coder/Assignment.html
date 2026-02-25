-- This query joins Customers (Left) with Orders (Right)
-- It shows all customers regardless of whether they have an order.
SELECT 
    Customers.CustomerName, 
    Orders.OrderID, 
    Orders.OrderDate
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerName;