# Retail Sales Analysis Using SQL Server

## Project Overview

**Project Title:** Retail Sales Analysis  
**Project Type:** Data Analytics – SQL Project  
**Level:** Beginner  
**Database:** Microsoft SQL Server  
**SQL Environment:** SQL Server Management Studio (SSMS)  
**Database Name:** `sql_project_p1`

## 1. Project Introduction

This project focuses on analysing retail sales data using Microsoft SQL Server.

The objective is to explore transaction-level sales data, perform basic data cleaning, conduct exploratory data analysis (EDA), and answer business-related questions using SQL queries.

Through this project, I applied SQL techniques to examine sales performance, customer demographics, purchasing patterns, product categories and sales trends.

The project demonstrates how SQL can be used to transform raw retail transaction data into meaningful information that can support business decision-making.

## 2. Project Objectives

The main objectives of this project are:

1. Create a retail sales database and table using SQL Server.
2. Identify and handle missing or NULL values.
3. Perform exploratory data analysis to understand the dataset.
4. Analyse sales performance across different product categories.
5. Examine customer demographics and purchasing behaviour.
6. Identify monthly sales trends and peak-performing months.
7. Identify the highest-spending customers.
8. Analyse sales transactions across different time shifts.

## 3. Database and Table Setup

I created a database named `sql_project_p1` and a table called `retail_sales`.

The table contains the following fields:

| Column | Description |
|---|---|
| transactions_id | Unique transaction identifier |
| sale_date | Date of the transaction |
| sale_time | Time of the transaction |
| customer_id | Customer identifier |
| gender | Customer gender |
| age | Customer age |
| category | Product category |
| quantity | Number of items purchased |
| price_per_unit | Price per item |
| cogs | Cost of goods sold |
| total_sale | Total transaction value |

### SQL – Database and Table Creation

```sql
CREATE DATABASE sql_project_p1;
GO

USE sql_project_p1;
GO

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs DECIMAL FLOAT,
    total_sale DECIMAL FLOAT
);
```

The dataset was loaded into the `retail_sales` table separately.

## 4. Data Exploration and Cleaning

Before performing the analysis, I explored the dataset to understand its structure and identify any data quality issues.

### Initial Data Exploration

**Check the first 10 records:**

```sql
SELECT TOP 10 *
FROM retail_sales;
```

**Find the total number of records:**

```sql
SELECT COUNT(*) AS Total_Records
FROM retail_sales;
```

**Count customer records:**

```sql
SELECT COUNT(customer_id) AS Customer_Records
FROM retail_sales;
```

**Count distinct customers:**

```sql
SELECT COUNT(DISTINCT customer_id) AS Unique_Customers
FROM retail_sales;
```

**Identify unique product categories:**

```sql
SELECT DISTINCT category
FROM retail_sales;
```

### Data Cleaning

I checked for missing values across the transaction, customer and sales-related columns.

```sql
SELECT *
FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

After identifying incomplete records, I used the following query to remove records containing NULL values:

```sql
DELETE FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

## 5. Business Analysis and SQL Queries

I developed SQL queries to answer ten business questions using the retail sales dataset.

### Q1. Retrieve all transactions made on 5 November 2022.

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

**SQL concepts:** SELECT, WHERE, date filtering.

### Q2. Retrieve Clothing transactions where the quantity sold was more than 4 during November 2022.

```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND FORMAT(sale_date, 'yyyy-MM' ) = '2022-11'
  AND quantity > 2
```

**SQL concepts:** Multiple WHERE conditions, AND operator, date ranges.

### Q3. Calculate total sales for each category.

```sql
SELECT
    category,
    SUM(total_sale) AS Total_Sales,
FROM retail_sales
GROUP BY category;
```

**SQL concepts:** SUM(), GROUP BY.

### Q4. Calculate the average age of customers purchasing products from the Beauty category.

```sql
SELECT
    AVG(age) AS Average_Age
FROM retail_sales
WHERE category = 'Beauty';
```

**SQL concepts:** AVG(), ROUND(), WHERE.

### Q5. Retrieve all transactions where the total sale amount is greater than 1000.

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

**SQL concepts:** Filtering and comparison operators.

### Q6. Calculate the total number of transactions made by each gender in each product category.

```sql
SELECT
    gender,
    category,
    COUNT(transactions_id) AS Total_Transactions
FROM retail_sales
GROUP BY gender, category;

```

**SQL concepts:** COUNT(), GROUP BY.

### Q7. Calculate average monthly sales and identify the best-selling month in each year.

**Monthly average and best selling month:**

```sql
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
```

**SQL concepts:** YEAR(), MONTH(), AVG(), SUM(), RANK(), PARTITION BY.

### Q8. Identify the top five customers based on their total sales.

```sql
SELECT TOP 5
    customer_id,
    SUM(total_sale) AS Total_Sales
FROM retail_sales
GROUP BY customer_id
ORDER BY Total_Sales DESC;
```

**SQL concepts:** TOP, SUM(), GROUP BY, ORDER BY.

### Q9. Calculate the number of unique customers purchasing products from each category.

```sql
SELECT
    category,
    COUNT(DISTINCT customer_id) AS Unique_Customers
FROM retail_sales
GROUP BY category;
```

**SQL concepts:** COUNT(DISTINCT), GROUP BY.

### Q10. Categorise transactions into Morning, Afternoon and Evening shifts and calculate the number of orders in each shift.

'''sql
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
```

**SQL concepts:** CASE WHEN, DATEPART(), COUNT(), GROUP BY, ORDER BY.

## 6. SQL Skills Demonstrated

Through this project, I applied the following SQL concepts:

| SQL Skill | Application |
|---|---|
| SELECT and WHERE | Retrieving and filtering data |
| AND operator | Applying multiple conditions |
| DISTINCT | Identifying unique values |
| COUNT() | Counting transactions and customers |
| SUM() | Calculating total sales |
| AVG() | Calculating average values |
| ROUND() | Formatting numerical results |
| GROUP BY | Aggregating sales by category and customer |
| ORDER BY | Sorting query results |
| TOP | Retrieving the highest-ranking customers |
| CASE WHEN | Categorising transactions into shifts |
| DATEPART(), YEAR(), MONTH() | Analysing dates and transaction times |
| CTE | Structuring complex queries |
| RANK() and PARTITION BY | Identifying the best-selling month in each year |

## 7. Business Questions and Potential Insights

The analysis is designed to help answer the following business questions:

- Which product categories generate the highest sales?
- Which customers contribute the most to overall revenue?
- How do purchasing patterns differ across customer genders?
- What is the average age of customers purchasing Beauty products?
- Which months generate the highest sales?
- How does transaction activity vary across different times of the day?
- Which product categories attract the most unique customers?

These findings can help businesses understand customer purchasing behaviour, monitor sales performance and identify opportunities for improving sales strategies.

*Actual numerical findings should be added after running the queries against the dataset.*

## 8. Tools and Technologies

- **Microsoft SQL Server:** Database management and SQL query execution.
- **SQL Server Management Studio (SSMS):** Writing and executing SQL queries.
- **GitHub:** Project documentation and portfolio presentation.

## 9. Project Conclusion

This project provided practical experience in using SQL Server to explore, clean and analyse retail sales data.

I applied SQL querying, data aggregation, filtering, date-based analysis, conditional logic and ranking techniques to investigate business-related questions.

The project strengthened my understanding of how structured data can be analysed to identify patterns and generate useful business insights.

It also provided an opportunity to develop practical SQL skills relevant to data analysis and business reporting.

## 10. Future Improvements

Potential extensions to this project include:

- Developing a Power BI dashboard to visualise sales trends.
- Performing deeper customer segmentation.
- Analysing profit margins across product categories.
- Exploring customer purchasing patterns over time.
- Identifying additional sales performance indicators.

## Author

**Poornisha Ramesh**

Qualified finance professional developing practical skills in data analytics, SQL, Excel and Power BI.

This project forms part of my data analytics learning and professional portfolio.

LinkedIn: [Connect with me on LinkedIn](https://www.linkedin.com/in/poornisha-ramesh/)


    
