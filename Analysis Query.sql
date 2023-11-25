---------------------------------QUESTIONS---------------------------------------------

--1. What are the details of all cars purchased in the year 2022?

SELECT * FROM sales as s
JOIN cars as c ON  s.car_id = c.car_id
WHERE YEAR(purchase_date) = 2022

--2. What is the total number of cars sold by each salesperson?

SELECT  NAME, COUNT(*) AS TotalSales  FROM sales AS s
JOIN salespersons AS sa ON s.salesman_id = sa.salesman_id
GROUP BY sa.name

--3. What is the total revenue generated by each salesperson?

SELECT  sa.name , SUM(c.cost_$) as RevenueGenerated   FROM sales as s 
JOIN cars as c ON s.car_id = c.car_id
JOIN salespersons as sa ON sa.salesman_id = s.salesman_id
GROUP BY sa.name

--4. What are the details of the cars sold by each salesperson?

SELECT sa.name, c.car_id, c.make, c.style, c.type, c.cost_$ 
FROM sales as s 
JOIN cars as c ON s.car_id = c.car_id
JOIN salespersons as sa ON sa.salesman_id = s.salesman_id
ORDER BY sa.name ASC

--5. What is the total revenue generated by each car type?

SELECT c.type , SUM(c.cost_$) AS RevenueGenerated
FROM sales as s 
JOIN cars as c ON s.car_id = c.car_id
GROUP BY c.type

--6. What are the details of the cars sold in the year 2021 by salesperson 'Emily Wong'?

SELECT sa.name, c.car_id, c.make, c.style, c.type, c.cost_$ 
FROM sales as s 
JOIN cars as c ON s.car_id = c.car_id
JOIN salespersons as sa ON sa.salesman_id = s.salesman_id
WHERE YEAR(s.purchase_date) = 2021 AND sa.name = 'Emily Wong'

--7. What is the total revenue generated by the sales of hatchback cars?

SELECT 'Hatchback' AS style , SUM(c.cost_$) AS RevenueGenerated
FROM sales as s 
JOIN cars as c ON s.car_id = c.car_id
WHERE c.style = 'Hatchback'

--8. What is the total revenue generated by the sales of SUV cars in the year 2022?

SELECT 'SUV' AS style , COUNT(*) AS Sales , SUM(c.cost_$) AS RevenueGenerated
FROM sales as s 
JOIN cars as c ON s.car_id = c.car_id
WHERE c.style = 'SUV'

--9. What is the name and city of the salesperson who sold the most number of cars in the year 2023?

SELECT TOP 1 * FROM
	(SELECT NAME, city, COUNT(*) as SalesS FROM sales AS s
	JOIN salespersons AS sa ON s.salesman_id = sa.salesman_id
	GROUP BY sa.name , city, YEAR(s.purchase_date)
	Having YEAR(s.purchase_date) = 2023
	) AS subquery
ORDER BY SalesS DESC


--10. What is the name and age of the salesperson who generated the highest revenue in the year 2022?

SELECT TOP 1 * FROM 
   (SELECT NAME, SUM(cost_$) as SalesS 
	FROM sales as s 
	JOIN cars as c ON s.car_id = c.car_id
	JOIN salespersons as sa ON sa.salesman_id = s.salesman_id
	GROUP BY sa.name
   ) AS subquery
ORDER BY SalesS DESC
