use modelcarsdb;

-- TASK 2 - OFFICE DATA ANALYSIS

-- 1.) NUMBER OF EMPLOYEES WORKING IN EACH OFFICE
SELECT offices.city, COUNT(employees.employeeNumber) AS Total_Employees 
FROM employees JOIN offices 
WHERE offices.officecode = employees.officeCode
GROUP BY offices.city;

-- 2.) OFFICE WITH LESS THAN CERTAIN NUMBER OF EMPLOYEES
SELECT o.officeCode, o.city, COUNT(e.employeeNumber) AS employeeCount
FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
GROUP BY o.officeCode, o.city
HAVING COUNT(e.employeeNumber) < 6;

-- 3.) OFFICE ALONG WITH TERRITORIES
SELECT officeCode, city , territory FROM offices;

-- 4.) OFFICES THAT HAS NO EMPLOYEES
SELECT o.officeCode, o.city, COUNT(o.officeCode)
FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
WHERE e.employeeNumber IS  NULL
GROUP BY o.officeCode;

-- 5.) MOST PROFITABLE OFFICE
SELECT offices.city, SUM(orderdetails.quantityOrdered*(orderdetails.priceEach)) AS Total_sales FROM offices
JOIN employees ON employees.officeCode = offices.officeCode
JOIN customers ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN orders ON orders.customerNumber = customers.customerNumber
JOIN orderdetails ON orderdetails.orderNumber = orders.orderNumber
GROUP BY offices.city 
ORDER BY Total_sales DESC LIMIT 1;

-- 6.) OFFICE THAT HAS HIGHEST NUMBER OF EMPLOYEES
SELECT offices.officeCode, offices.city, COUNT(employees.employeeNumber) AS Total_employees FROM employees
JOIN offices ON offices.officeCode = employees.officeCode
GROUP BY offices.officeCode
ORDER BY Total_employees DESC LIMIT 1;

-- 7.) AVERAGE CREDIT LIMIT OF CUSTOMER IN EACH OFFICE
SELECT offices.officeCode, offices.city, AVG(customers.creditLimit) AS averageCreditLimit
FROM offices
JOIN employees ON offices.officeCode = employees.officeCode
JOIN customers ON employees.employeeNumber = customers.salesRepEmployeeNumber
GROUP BY offices.officeCode, offices.city;

-- 8.) NUMBER OF OFFICE IN EACH COUNTRY
SELECT country, COUNT(city) FROM offices
GROUP BY country;