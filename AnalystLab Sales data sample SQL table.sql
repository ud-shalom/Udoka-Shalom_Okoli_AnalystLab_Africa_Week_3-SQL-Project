/* 1. SETUP: RESIZE COLUMNS FIRST */
ALTER TABLE dbo.sales_data_sample
ALTER COLUMN PRODUCTLINE NVARCHAR(50);

ALTER TABLE dbo.sales_data_sample
ALTER COLUMN CUSTOMERNAME NVARCHAR(50);

/* 2. OPTIMIZATION: CREATE INDEXES NEXT */
CREATE INDEX idx_product ON dbo.sales_data_sample(PRODUCTLINE);
CREATE INDEX idx_customer ON dbo.sales_data_sample(CUSTOMERNAME);

-- View the structure and content of your table
SELECT TOP 20 * FROM dbo.sales_data_sample;

-- Select specific columns and filter by Country
SELECT ORDERNUMBER, SALES, CUSTOMERNAME, COUNTRY 
FROM dbo.sales_data_sample
WHERE COUNTRY = 'USA';

-- Filter for a specific Product Line using "WHERE"
SELECT * FROM dbo.sales_data_sample
WHERE PRODUCTLINE = 'Motorcycles';

-- List sales in descending order using "ORDER BY" (highest sales first)
SELECT TOP 10 ORDERNUMBER, SALES, STATUS
FROM dbo.sales_data_sample
ORDER BY SALES DESC;

-- Sales volume by Country and Deal Size
SELECT COUNTRY, DEALSIZE, COUNT(ORDERNUMBER) AS TotalOrders, SUM(SALES) AS TotalRevenue
FROM dbo.sales_data_sample
GROUP BY COUNTRY, DEALSIZE
ORDER BY TotalRevenue DESC;

--AGGREGATES
-- Total Revenue
SELECT SUM(SALES) AS TotalRevenue FROM dbo.sales_data_sample;

-- Average Sale Value
SELECT AVG(SALES) AS AverageOrderValue FROM dbo.sales_data_sample;

-- Total Count of Orders
SELECT COUNT(ORDERNUMBER) AS TotalOrders FROM dbo.sales_data_sample;

SELECT 
    PRODUCTLINE, 
    SUM(SALES) AS TotalRevenue, 
    AVG(SALES) AS AverageOrderValue, 
    COUNT(ORDERNUMBER) AS TotalOrders
FROM dbo.sales_data_sample
GROUP BY PRODUCTLINE
HAVING SUM(SALES) > 500000 -- Only shows product lines with over 500k in total sales
ORDER BY TotalRevenue DESC;

/* COMMENTS: Demonstrating different JOIN types using the same table. */

-- INNER JOIN: Only returns rows where there is a match in both tables
SELECT A.ORDERNUMBER, B.PRODUCTLINE
FROM dbo.sales_data_sample A
INNER JOIN dbo.sales_data_sample B ON A.ORDERNUMBER = B.ORDERNUMBER;

-- LEFT JOIN: Returns all rows from the left table and matches from the right
SELECT A.ORDERNUMBER, B.PRODUCTLINE
FROM dbo.sales_data_sample A
LEFT JOIN dbo.sales_data_sample B ON A.ORDERNUMBER = B.ORDERNUMBER;

-- RIGHT JOIN: Returns all rows from the right table and matches from the left
SELECT A.ORDERNUMBER, B.PRODUCTLINE
FROM dbo.sales_data_sample A
RIGHT JOIN dbo.sales_data_sample B ON A.ORDERNUMBER = B.ORDERNUMBER;

/* Example: Show me only customers whose AVERAGE sales are over 500,000 */
SELECT ORDERNUMBER, SALES
FROM dbo.sales_data_sample
WHERE SALES > (SELECT AVG(SALES) FROM dbo.sales_data_sample);

/* COMMENTS: Using RANK and PARTITION BY to rank product revenue. */
SELECT 
    PRODUCTLINE, 
    SALES,
    RANK() OVER (PARTITION BY PRODUCTLINE ORDER BY SALES DESC) AS SalesRank
FROM dbo.sales_data_sample;

/* COMMENTS: Assigning a sequential row number to every order. */
SELECT 
    ORDERNUMBER, 
    PRODUCTCODE,
    ROW_NUMBER() OVER (ORDER BY ORDERNUMBER) AS RowNum
FROM dbo.sales_data_sample;

/* COMMENTS: Identify top products by total sales revenue. */
SELECT TOP 5 PRODUCTCODE, SUM(SALES) AS TotalRevenue
FROM dbo.sales_data_sample
GROUP BY PRODUCTCODE
ORDER BY TotalRevenue DESC;

/* COMMENTS: Detailed revenue trends broken down by year, quarter, and month. */
SELECT 
    YEAR_ID, 
    QTR_ID, 
    MONTH_ID, 
    SUM(SALES) AS TotalRevenue,
    COUNT(ORDERNUMBER) AS OrderCount
FROM dbo.sales_data_sample
GROUP BY YEAR_ID, QTR_ID, MONTH_ID
ORDER BY YEAR_ID, QTR_ID, MONTH_ID;

/* COMMENTS: Analyze customer frequency and average spend. */
SELECT CUSTOMERNAME, 
       COUNT(ORDERNUMBER) AS Frequency, 
       AVG(SALES) AS AvgOrderValue
FROM dbo.sales_data_sample
GROUP BY CUSTOMERNAME
ORDER BY Frequency DESC;