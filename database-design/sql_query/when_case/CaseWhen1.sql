-- TODO. Case when 条件判断
-- OrderID	ProductID	Quantity
-- 1	    10248	    11
-- 2	    10248	    42
-- 3	    10248	    72
-- 4	    10249	    14
-- 5	    10249	    51

-- 根据字段的值执行不同判断
SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN 'The quantity is greater than 30'
    WHEN Quantity = 30 THEN 'The quantity is 30'
    ELSE 'The quantity is under 30'
END AS QuantityText
FROM OrderDetails;

-- 根据字段的值确定排序的顺序
SELECT CustomerName, City, Country
FROM Customers
ORDER BY
(CASE
    WHEN City IS NULL THEN Country
    ELSE City
END);
