# Superstore SQL Data Cleaning & Analysis

## Overview
This project focuses on cleaning and analyzing a retail sales dataset using SQL. The raw dataset had issues like duplicate records, missing values, and inconsistent date formats.

The goal was to clean the data properly and use it to generate meaningful insights.

---

## Tools Used
- MySQL
- Excel (for validating outputs)
- GitHub

---

## Dataset
- Superstore sales dataset
- Includes order, customer, product, sales, and profit details

---

## Project Structure
```
data/       → raw dataset
sql/        → SQL queries for cleaning and analysis
outputs/    → cleaned data and analysis results
```

---

## Data Cleaning Steps

The following steps were performed to prepare the data for analysis:

- Removed duplicate records using `ROW_NUMBER()`
- Handled missing values in columns like City and Customer Name
- Standardized text fields using `LOWER()` and `TRIM()`
- Fixed inconsistent date formats (mixed `mm/dd/yyyy` and `dd-mm-yyyy`)
- Used conditional SQL logic (`COALESCE` with `STR_TO_DATE`) to convert dates correctly
- Created a cleaned dataset (`clean_superstore`) for analysis

---

## Key Challenge Solved — Mixed Date Formats

The dataset contained mixed date formats, which caused errors during conversion. To fix this, I used `COALESCE` to try each format in order and fall back gracefully:

```sql
UPDATE superstore_dedup
SET `Order Date` = COALESCE(
    STR_TO_DATE(`Order Date`, '%m/%d/%Y'),
    STR_TO_DATE(`Order Date`, '%d-%m-%Y')
);
```

This ensured all date values were standardized before any time-based analysis was performed.

---

## Analysis Performed

- Total sales and average order value
- Sales by category
- Profit by region
- Monthly sales trends
- Top customers and products
- Identification of loss-making orders
- Discount impact on profitability

---

## Advanced SQL Queries

### Monthly Sales Growth (using `LAG`)

```sql
SELECT 
    DATE_FORMAT(`Order Date`, '%Y-%m') AS month,
    SUM(Sales) AS total_sales,
    LAG(SUM(Sales)) OVER (ORDER BY DATE_FORMAT(`Order Date`, '%Y-%m')) AS prev_month_sales
FROM clean_superstore
GROUP BY month;
```

### Top Customers by Region (using `RANK`)

```sql
SELECT 
    Region,
    `Customer Name`,
    SUM(Sales) AS total_sales,
    RANK() OVER (PARTITION BY Region ORDER BY SUM(Sales) DESC) AS rank_in_region
FROM clean_superstore
GROUP BY Region, `Customer Name`;
```

### Discount Impact on Profitability

To understand the reason behind loss-making orders, I analyzed how discounts affect average profit:

```sql
SELECT 
    CASE 
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.2 THEN 'Low Discount'
        ELSE 'High Discount'
    END AS discount_tier,
    ROUND(AVG(Profit), 2) AS avg_profit
FROM clean_superstore
GROUP BY discount_tier;
```

---

## Key Insights

- **Technology and Office Supplies** contribute the highest share of total sales
- **The West region** generates the highest overall profit compared to other regions
- A small group of customers contributes a significant portion of total revenue
- Orders with **no or low discounts** tend to have higher average profit, while orders with **high discounts** show significantly lower or negative profit — indicating that excessive discounting is a key driver of loss-making orders

---

## What I Learned

- How to handle data issues like inconsistent date formats
- The importance of data cleaning before performing any analysis
- Writing SQL queries for both data cleaning and business insight generation
- Using window functions (`LAG`, `RANK`, `PARTITION BY`) for deeper analysis

---

## Conclusion

This project demonstrates how SQL can be used to clean messy data and generate insights that support business decisions. The discount impact analysis in particular tells a clear story: aggressive discounting directly erodes profitability and is a measurable root cause of loss-making orders.

---

## Future Improvements

- Build an interactive dashboard using Excel or Power BI
- Add deeper analysis on customer retention and discount thresholds
- Automate the data cleaning process
