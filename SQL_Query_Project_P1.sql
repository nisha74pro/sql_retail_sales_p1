--SQL Retail Sales Analysis-P1---

CREATE DATABASE sql_project_p1;

Use sql_project_p1;

--Create Table-- 

CREATE TABLE retail_sales
            (
              transactions_id INT PRIMARY KEY,
              sale_date DATE,
              sale_time TIME,
              customer_id INT,
              gender VARCHAR(15),
              age INT,
              category VARCHAR(15),
              quantity INT,
              price_per_unit FLOAT,
              cogs FLOAT,
              total_sale FLOAT,
            );

 ---Data Exploration

---Check the first 10 records

SELECT TOP 10 *
FROM retail_sales;

---Find the total number of records

SELECT 
   COUNT(*)
FROM retail_sales;

---How many sales we have?

SELECT COUNT(*) as total_sale 
FROM retail_sales;

----How many customers we have?

SELECT COUNT(customer_id) as Customer_records
FROM retail_sales;

---How many distinct customers we have?

SELECT COUNT(DISTINCT customer_id) as Unique_Customers FROM retail_sales;

---How many unique categories we have?

SELECT DISTINCT category FROM retail_sales

----------------------
---Data Cleaning

---Checking for missing values across the transaction, customer and sales-related columns.

SELECT * FROM retail_sales
WHERE
     transactions_id IS NULL
     OR
     sale_date IS NULL
     OR         
     sale_time IS NULL
     OR
     customer_id IS NULL
     OR
     gender IS NULL
     OR
     category IS NULL
     OR         
     price_per_unit IS NULL
     OR
     cogs IS NULL
     OR         
     total_sale IS NULL;
-------------------------------
---Remove records containing NULL values

DELETE FROM retail_sales
WHERE
     transactions_id IS NULL
     OR
     sale_date IS NULL
     OR         
     sale_time IS NULL
     OR
     customer_id IS NULL
     OR
     gender IS NULL
     OR
     category IS NULL
     OR         
     price_per_unit IS NULL
     OR
     cogs IS NULL
     OR         
     total_sale IS NULL;
-------------------------------------

----Data Analysis & Business Key Problems & Answers

--My Analysis & Findings
--Q1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
--Q2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
--Q3.Write a SQL query to calculate the total sales (total_sale) for each category.:
--Q4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
--Q5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
--Q6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
--Q7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
--Q8.**Write a SQL query to find the top 5 customers based on the highest total sales **:
--Q9.Write a SQL query to find the number of unique customers who purchased items from each category.
--Q10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

--Q1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

--Q2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND FORMAT(sale_date, 'yyyy-MM') = '2022-11'
AND quantiy > 2;

--Q3.Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT
    category,
    SUM(total_sale) AS Total_Sales
FROM retail_sales
GROUP BY category;

--Q4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT
    AVG(age) AS Average_Age
FROM retail_sales
WHERE category = 'Beauty';

--Q5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:

SELECT *
FROM retail_sales
WHERE total_sale > 1000;

--Q6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT
    gender,
    category,
    COUNT(transactions_id) AS Total_Transactions
FROM retail_sales
GROUP BY gender, category;

--Q7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT Year, Month, Average_Sales
FROM
(
    SELECT
        YEAR(sale_date) AS Year,
        MONTH(sale_date) AS Month,
        AVG(total_sale) AS Average_Sales,
        ROW_NUMBER() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rn
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS Sales
WHERE rn = 1;

--Q8.**Write a SQL query to find the top 5 customers based on the highest total sales **:

SELECT TOP 5
    customer_id,
    SUM(total_sale) AS Total_Sales
FROM retail_sales
GROUP BY customer_id
ORDER BY Total_Sales DESC;

--Q9.Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT
    category,
    COUNT(DISTINCT customer_id) AS Unique_Customers
FROM retail_sales
GROUP BY category;


--Q10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

SELECT
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12
            THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time)  BETWEEN 12 AND 17
            THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift,

    COUNT(transactions_id) AS Total_Orders

FROM retail_sales

GROUP BY
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12
            THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17
            THEN 'Afternoon'
        ELSE 'Evening'
    END;

---End of Project.






