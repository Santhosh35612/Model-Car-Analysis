use modelcarsdb;

-- TASK 2 - ORDER ANALYSIS

-- 1.) Find the average order amount for each customer
SELECT o.customerNumber, c.customerName, AVG(od.quantityOrdered * od.priceEach) AS avgOrderAmount
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN customers c ON o.customerNumber = c.customerNumber
GROUP BY o.customerNumber;

-- 2.) Find the number of orders placed in each month
SELECT MONTHNAME(orderDate) AS month, COUNT(*) AS totalOrders
FROM orders
GROUP BY  MONTHNAME(orderDate);

-- 3.) Identify orders that are still pending shipment (status = 'Pending')
SELECT orderNumber, orderDate, status
FROM orders
WHERE status = 'Pending';

-- 4.) List orders along with customer details
SELECT o.orderNumber, o.orderDate, o.status, c.customerNumber, c.customerName, c.contactFirstName, c.contactLastName
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber;

-- 5.) Retrieve the most recent orders (based on order date)
SELECT * FROM orders
ORDER BY orderDate DESC
LIMIT 5;

-- 6.) Calculate total sales for each order
SELECT o.orderNumber, SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY o.orderNumber;

-- 7.) Find the highest-value order based on total sales
SELECT o.orderNumber, SUM(od.quantityOrdered * od.priceEach) AS totalValue
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY o.orderNumber
ORDER BY totalValue DESC
LIMIT 1;

-- 8.) List all orders with their corresponding order details
SELECT o.orderNumber, od.productCode, od.quantityOrdered, od.priceEach
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber;

-- 9.) List the most frequently ordered products
SELECT products.productName, COUNT(orderdetails.productCode) AS No_orders FROM orderdetails
JOIN products ON products.productCode = orderdetails.productCode
GROUP BY products.productName ORDER BY No_orders DESC LIMIT 5;

-- 10.) Calculate total revenue for each order
SELECT orderNumber, SUM(quantityOrdered * priceEach) AS totalRevenue
FROM orderdetails
GROUP BY orderNumber;

-- 11.) Identify the most profitable orders based on total revenue
SELECT orderNumber, SUM(quantityOrdered * priceEach) AS Total_revenue, SUM(quantityOrdered * buyPrice) AS Total_cost,
(SUM(quantityOrdered * priceEach) - SUM(quantityOrdered * buyPrice)) AS Total_profit 
FROM orderdetails JOIN products ON products.productCode = orderdetails.productCode
GROUP BY orderNumber ORDER BY Total_profit DESC;

-- 12.) List all orders with detailed product information
SELECT o.orderNumber, p.productCode, p.productName, od.quantityOrdered, od.priceEach
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode;

-- 13.) Identify orders with delayed shipping (shippedDate > requiredDate)
SELECT orderNumber, orderDate, requiredDate, shippedDate
FROM orders
WHERE shippedDate > requiredDate;

-- 14.) Find the most popular product combinations within orders
SELECT od1.productCode AS product1, od2.productCode AS product2, COUNT(*) AS combinationCount
FROM orderdetails od1
JOIN orderdetails od2 
  ON od1.orderNumber = od2.orderNumber AND od1.productCode < od2.productCode
GROUP BY product1, product2
ORDER BY combinationCount DESC
LIMIT 10;

-- 15.) Calculate revenue for each order and identify the top 10 most profitable
SELECT orderNumber, SUM(quantityOrdered * priceEach) AS revenue
FROM orderdetails
GROUP BY orderNumber
ORDER BY revenue DESC
LIMIT 10;

-- 16.) Create a trigger that automatically updates a customer's credit limit after a new order is placed
DELIMITER //
CREATE TRIGGER reduce_credit_limit
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
  DECLARE total DECIMAL(10,2);
  SELECT SUM(quantityOrdered * priceEach) 
  INTO total
  FROM orderdetails
  WHERE orderNumber = NEW.orderNumber;
  
  UPDATE customers
  SET creditLimit = creditLimit - IFNULL(total, 0)
  WHERE customerNumber = NEW.customerNumber;
END //
DELIMITER ;

-- 17.) Create a trigger that logs product quantity changes whenever an order detail is inserted or updated
CREATE TABLE IF NOT EXISTS product_log (
  logId INT AUTO_INCREMENT PRIMARY KEY,
  productCode VARCHAR(15),
  changedOn DATETIME,
  changeType VARCHAR(10),
  quantityChanged INT
);

DELIMITER //
CREATE TRIGGER log_quantity_change
AFTER INSERT ON orderdetails
FOR EACH ROW
BEGIN
  INSERT INTO product_log(productCode, changedOn, changeType, quantityChanged)
  VALUES (NEW.productCode, NOW(), 'INSERT', NEW.quantityOrdered);
END //
DELIMITER ;
