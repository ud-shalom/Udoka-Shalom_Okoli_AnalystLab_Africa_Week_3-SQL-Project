# SQL Sales Data Analysis & Optimization Project

## Project Overview
The goal of this project was to analyze a sales dataset to extract meaningful business insights. Using SQL, I performed data cleaning, schema optimization, and complex analytical queries to answer critical business questions regarding product performance, revenue trends, and customer behavior.

## Challenges Faced
* **Data Import and Type Incompatibility:** When first importing the raw sales data, inconsistent formats caused errors. I initially set columns to `NVARCHAR(MAX)` to ensure successful loading.
* **Indexing Constraints:** SQL Server cannot index `NVARCHAR(MAX)` columns because they are too large. To optimize for performance, I used the `ALTER TABLE` command to change critical columns to a fixed length of `NVARCHAR(50)`, which enabled proper indexing.

## Database Setup and Optimization
Before running analysis, I prepared the structure for better performance.

### Understanding the Table
SELECT TOP 10 * FROM dbo.sales_data_sample;

### Schema Optimization
Resizing columns to a fixed length is required for indexing.
SQL
ALTER TABLE dbo.sales_data_sample ALTER COLUMN PRODUCTLINE NVARCHAR(50);
ALTER TABLE dbo.sales_data_sample ALTER COLUMN CUSTOMERNAME NVARCHAR(50);
Performance Indexing
Creating indexes acts as a table of contents for the database.

SQL
CREATE INDEX idx_product ON dbo.sales_data_sample(PRODUCTLINE);
CREATE INDEX idx_customer ON dbo.sales_data_sample(CUSTOMERNAME);

### Business Analysis Queries
## Top-Performing Products
SQL
SELECT TOP 5 PRODUCTCODE, SUM(SALES) AS TotalRevenue
FROM dbo.sales_data_sample
GROUP BY PRODUCTCODE
ORDER BY TotalRevenue DESC;

## Revenue Trends
SQL
SELECT YEAR_ID, QTR_ID, MONTH_ID, SUM(SALES) AS TotalRevenue
FROM dbo.sales_data_sample
GROUP BY YEAR_ID, QTR_ID, MONTH_ID
ORDER BY YEAR_ID, QTR_ID, MONTH_ID;

## Customer Purchasing Behavior
SQL
SELECT CUSTOMERNAME, COUNT(ORDERNUMBER) AS Frequency, AVG(SALES) AS AvgOrderValue
FROM dbo.sales_data_sample
GROUP BY CUSTOMERNAME
HAVING AVG(SALES) > 500000
ORDER BY Frequency DESC;

## Orders Above Global Average (Subquery)
SQL
SELECT ORDERNUMBER, SALES
FROM dbo.sales_data_sample
WHERE SALES > (SELECT AVG(SALES) FROM dbo.sales_data_sample);

## Ranking Sales (Window Function)
SQL
SELECT PRODUCTLINE, SALES, RANK() OVER (PARTITION BY PRODUCTLINE ORDER BY SALES DESC) AS SalesRank
FROM dbo.sales_data_sample;

### Business Insights
- **Concentrated Revenue: A small percentage of products drive the majority of revenue.

# High-Value Customer Segment: By filtering for VIP clients, we can create targeted loyalty programs.

# Performance Outliers: The subquery analysis helped us isolate high-performing orders, providing a roadmap for future sales success.

# AnalystLab Africa - Week 3 Project: Chinook Database Analysis

## Project Overview
This repository contains my final SQL analysis project for the AnalystLab Africa data analytics track. The project involves working with the **Chinook Database**, a relational music store dataset, to perform business analysis, data cleaning, and performance optimization.

## Key Skills Demonstrated
- **Data Retrieval:** Using `SELECT` and `JOIN` to query relational data.
- **Aggregation:** Utilizing `SUM`, `COUNT`, and `AVG` for business reporting.
- **Advanced SQL:** Applying `RANK()`, `PARTITION BY`, and subqueries.
- **Optimization:** Improving query performance using `INDEX` creation.

## SQL Analysis Highlights

### 1. Data Preview
## Understanding the table structure
SELECT TOP 5 * FROM dbo.Customer;
SELECT TOP 5 * FROM dbo.Invoice;

### 2. Business Aggregates
SQL
## Calculating total revenue per country
SELECT BillingCountry, SUM(Total) AS RevenuePerCountry
FROM dbo.Invoice
GROUP BY BillingCountry
ORDER BY RevenuePerCountry DESC;

### 3. Query Optimization
SQL
## Speeding up searches with non-clustered indexes
CREATE NONCLUSTERED INDEX IX_Invoice_Total ON dbo.Invoice(Total);

### 4. Insights
# Customer Behavior: Identified high-value customers through transaction volume.

# Product Trends: Discovered top-performing tracks through invoice join analysis.

# Performance: Optimized query execution times using SQL indexing, significantly reducing retrieval time for large datasets.

## About
# This project was completed as part of the AnalystLab Africa data analytics curriculum.

### Created by: Okoli Udoka Shalom
#SQL #AnalystlabAfrica #DataAnalytics #Internship #SQLServer #BusinessIntelligence
