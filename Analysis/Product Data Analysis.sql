use modelcarsdb;

-- TASK 3 - PRODUCT DATA ANALYSIS

-- 1.) COUNT OF PRODUCTS IN EACH PRODUCT LINE
SELECT productLine, COUNT(*) AS productCount FROM products
GROUP BY productLine;

-- 2.) PRODUCT LINE WITH HIGHEST AVERAGE PRODUCT PRICE (MSRP)
SELECT productLine, SUM(MSRP) AS TotalPrice FROM products
GROUP BY productLine
ORDER BY TotalPrice DESC LIMIT 1;

-- 3.) PRODUCTS WITH MSRP BETWEEN 50 AND 100
SELECT productCode, productName, MSRP FROM products
WHERE MSRP BETWEEN 50 AND 100;

-- 4.) TOTAL SALES AMOUNT FOR EACH PRODUCT LINE
SELECT p.productLine, SUM(od.quantityOrdered * od.priceEach) AS totalSales FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productLine;

-- 5.) PRODUCTS WITH LOW INVENTORY LEVEL (LESS THAN 10)
SELECT productCode, productName, quantityInStock FROM products
WHERE quantityInStock < 10;

-- 6.) MOST EXPENSIVE PRODUCT BASED ON MSRP
SELECT productCode, productName, MSRP FROM products
ORDER BY MSRP DESC LIMIT 1;

-- 7.) TOTAL SALES FOR EACH PRODUCT
SELECT p.productCode, p.productName, SUM(od.quantityOrdered * od.priceEach) AS totalSales FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName
ORDER BY totalSales DESC;

-- 8.) STORED PROCEDURE TO GET TOP-SELLING PRODUCTS BY QUANTITY ORDERED
DELIMITER //
CREATE PROCEDURE GetTopSellingProducts(IN topN INT)
BEGIN
  SELECT p.productCode, p.productName, SUM(od.quantityOrdered) AS totalQuantity
  FROM products p
  JOIN orderdetails od ON p.productCode = od.productCode
  GROUP BY p.productCode, p.productName
  ORDER BY totalQuantity DESC
  LIMIT topN;
END//
DELIMITER ;

CALL GetTopSellingProducts(5);

-- 9.) PRODUCTS WITH LOW INVENTORY (<10) IN 'CLASSIC CARS' OR 'MOTORCYCLES'
SELECT productName, quantityInStock, productLine FROM products
WHERE quantityInStock < 10
AND productLine IN ('Classic Cars', 'Motorcycles');

-- 10.) PRODUCTS ORDERED BY MORE THAN 10 CUSTOMERS
SELECT customers.customerName, SUM(orderdetails.quantityOrdered) AS Total_Qty FROM customers
JOIN orders ON orders.customerNumber = customers.customerNumber
JOIN orderdetails ON orderdetails.orderNumber = orders.orderNumber
GROUP BY customers.customerName HAVING Total_Qty >=10 ORDER by Total_Qty DESC;

-- 11.) PRODUCTS ORDERED MORE THAN AVERAGE NUMBER OF ORDERS IN THEIR PRODUCT LINE
SELECT p.productName, p.productLine, SUM(od.quantityOrdered) AS Total_qty FROM products p
JOIN orderdetails od ON od.productCode = p.productCode
GROUP BY p.productName, p.productLine
HAVING SUM(od.quantityOrdered) > (SELECT AVG(sub.total_qty) FROM (
	SELECT SUM(od2.quantityOrdered) AS total_qty FROM products p2
	JOIN orderdetails od2 ON od2.productCode = p2.productCode
	WHERE p2.productLine = p.productLine
	GROUP BY p2.productCode) AS sub);



