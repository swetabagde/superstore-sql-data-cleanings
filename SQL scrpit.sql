-- ============================================
-- SUPERSTORE SQL PROJECT
-- Data Cleaning + Analysis
-- ============================================
SET SQL_SAFE_UPDATES = 0;

-- STEP 1: CREATE DATABASE
CREATE DATABASE IF NOT EXISTS superstore_db;
USE superstore_db;

-- STEP 2: CHECK DATA
SELECT 
    *
FROM
    superstore;

-- ============================================
-- DATA CLEANING
-- ============================================

-- STEP 3: REMOVE DUPLICATES (SAFE METHOD)
CREATE TABLE superstore_dedup AS
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY `Order ID`, `Customer ID`, `Product ID`
               ORDER BY `Row ID`
           ) AS rn
    FROM superstore
) t
WHERE rn = 1;

-- STEP 4: HANDLE NULL VALUES
UPDATE superstore_dedup 
SET 
    City = 'Unknown'
WHERE
    City IS NULL OR City = '';

UPDATE superstore_dedup 
SET 
    `Customer Name` = 'Unknown'
WHERE
    `Customer Name` IS NULL
        OR `Customer Name` = '';

-- STEP 5: STANDARDIZE TEXT
UPDATE superstore_dedup 
SET 
    `Customer Name` = LOWER(`Customer Name`);

UPDATE superstore_dedup 
SET 
    City = TRIM(City);

-- STEP 6: FIX DATE FORMAT
-- (Assuming format is mm/dd/yyyy from Superstore dataset)

UPDATE superstore_dedup 
SET 
    `Order Date` = CASE
        WHEN `Order Date` LIKE '%/%' THEN STR_TO_DATE(`Order Date`, '%m/%d/%Y')
        WHEN `Order Date` LIKE '%-%' THEN STR_TO_DATE(`Order Date`, '%d-%m-%Y')
        ELSE NULL
    END;

UPDATE superstore_dedup 
SET 
    `Ship Date` = CASE
        WHEN `Ship Date` LIKE '%/%' THEN STR_TO_DATE(`Ship Date`, '%m/%d/%Y')
        WHEN `Ship Date` LIKE '%-%' THEN STR_TO_DATE(`Ship Date`, '%d-%m-%Y')
        ELSE NULL
    END;

-- STEP 7: CREATE CLEAN TABLE
CREATE TABLE clean_superstore AS SELECT * FROM
    superstore_dedup
WHERE
    Sales > 0 AND Quantity > 0;

-- ============================================
-- DATA ANALYSIS
-- ============================================

SELECT 
    ROUND(SUM(Sales), 2) AS total_sales
FROM
    clean_superstore;

-- 2. SALES BY CATEGORY
SELECT 
    Category, ROUND(SUM(Sales), 2) AS total_sales
FROM
    clean_superstore
GROUP BY Category
ORDER BY total_sales DESC;

-- 3. PROFIT BY REGION
SELECT 
    Region, ROUND(SUM(Profit), 2) AS total_profit
FROM
    clean_superstore
GROUP BY Region
ORDER BY total_profit DESC;

-- 4. TOP 10 CUSTOMERS
SELECT 
    `Customer Name`, ROUND(SUM(Sales), 2) AS total_sales
FROM
    clean_superstore
GROUP BY `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;

-- 5. SALES BY MONTH
SELECT 
    DATE_FORMAT(`Order Date`, '%Y-%m') AS month,
    ROUND(SUM(Sales), 2) AS monthly_sales
FROM
    clean_superstore
GROUP BY month
ORDER BY month;

-- 6. AVERAGE ORDER VALUE
SELECT 
    ROUND(AVG(Sales), 2) AS avg_order_value
FROM
    clean_superstore;

-- 7. TOP 5 PRODUCTS BY SALES
SELECT 
    `Product Name`, ROUND(SUM(Sales), 2) AS total_sales
FROM
    clean_superstore
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 5;

-- 8. LOSS-MAKING ORDERS
SELECT 
    *
FROM
    clean_superstore
WHERE
    Profit < 0
ORDER BY Profit ASC;

-- 9. SALES BY SEGMENT
SELECT 
    Segment, ROUND(SUM(Sales), 2) AS total_sales
FROM
    clean_superstore
GROUP BY Segment;

-- 10. PROFIT MARGIN BY CATEGORY
SELECT 
    Category,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM
    clean_superstore
GROUP BY Category;

SELECT 
    *
FROM
    clean_superstore;
-- ============================================
-- END OF PROJECT
-- ============================================
