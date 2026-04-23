# Superstore SQL Data Cleaning & Analysis

## Overview

This project focuses on cleaning and analyzing a retail sales dataset using SQL. The dataset contained inconsistencies such as duplicate records, missing values, and mixed date formats.

---

## Tools Used

* MySQL
* Excel
* GitHub

---

## Data Cleaning Steps

The following data cleaning steps were performed:

* Removed duplicate records using ROW_NUMBER()
* Handled missing values in columns like City and Customer Name
* Standardized text fields using LOWER() and TRIM()
* Fixed inconsistent date formats (both `mm/dd/yyyy` and `dd-mm-yyyy`) using conditional SQL logic
* Created a clean dataset (`clean_superstore`) for analysis

---

## Key Challenge Solved

The dataset had mixed date formats which caused errors during conversion.
This was handled using conditional logic:

* Applied different date formats based on pattern (`/` vs `-`)
* Used COALESCE to safely convert values without errors

---

## Analysis Performed

* Total sales and average order value
* Sales by category and segment
* Profit by region
* Monthly sales trends
* Top customers and products
* Identification of loss-making orders

---

## Key Insights

* Certain categories contribute significantly more to total sales
* Some regions are more profitable than others
* A small group of customers drives a large portion of revenue
* Loss-making transactions highlight areas for cost control

---

## Conclusion

This project demonstrates how SQL can be used to clean raw data and generate meaningful insights. Clean data improves accuracy and supports better decision-making.


