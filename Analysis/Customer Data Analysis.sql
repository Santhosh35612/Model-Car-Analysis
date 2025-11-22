use modelcarsdb;

-- TASK 1 - CUSTOMER DATA ANALYSIS

-- 1.) TOP 10 CUSTOMERS BY CREDIT LIMIT
SELECT customerName, creditLimit FROM customers 
ORDER BY creditLimit DESC LIMIT 10;

-- 2.) AVERAGE CREDIT LIMIT FOR CUSTOMERS IN EACH COUNTRY
SELECT country, AVG(creditLimit) AS Average FROM customers
GROUP BY country;

-- 3.) NUMBER OF CUSTOMER IN EACH STATE
SELECT state, COUNT(customerNumber) AS Total_Customers FROM customers
GROUP BY state;

-- 4.) CUSTOMERS WHO HAVENT PLACED ANY ORDER
SELECT customerNumber, customerName FROM customers
WHERE customerNumber NOT IN (SELECT customerNumber FROM orders);

-- 5.) TOTAL SALES OF EACH CUSTOMER
SELECT c.customerName, SUM(p.amount) AS Total_sales FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerName;

-- 6.) CUSTOMERS AND SALES REPRENSTATIVES
SELECT c.customerName, e.lastName AS Representatives FROM customers c 
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber;

-- 7.) CUSTOMER INFORMATION WITH RECENT PAYMENT
SELECT c.customerName, p.paymentDate, p.amount FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
ORDER BY paymentDate DESC;

-- 8.) CUSTOMERS EXCEED THEIR CREDIT LIMIT
SELECT c.customerName, SUM(p.amount) AS Total_Amount, c.creditLimit 
FROM customers c JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerName, c.creditLimit 
HAVING SUM(p.amount) > c.creditLimit;

-- 9.) SPECIFIC PRODUCT LINE
DELIMITER //
CREATE PROCEDURE product_line(IN products_line VARCHAR(100))
BEGIN

	SELECT customers.customerName, products.productLine FROM customers 
	JOIN orders ON customers.customerNumber = orders.customerNumber
	JOIN orderdetails ON orderdetails.orderNumber = orders.orderNumber
	JOIN products ON orderdetails.productCode = products.productCode
	WHERE products_line = products.productLine;

END//
DELIMITER ;

CALL product_line("Planes");

-- 10.) CUSTOMER WHO PURCHASED MOST EXPENSIVE PRODUCT

SELECT DISTINCT customers.customerName,products.productLine, products.MSRP FROM customers 
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN orderdetails ON orderdetails.orderNumber = orders.orderNumber
JOIN products ON orderdetails.productCode = products.productCode
WHERE products.MSRP = (SELECT MAX(MSRP) FROM products );