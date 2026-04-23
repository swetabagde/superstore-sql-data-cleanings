# Superstore SQL Data Cleaning & Analysis

## Overview

This project focuses on cleaning and analyzing a retail sales dataset using SQL. The raw dataset had issues like duplicate records, missing values, and inconsistent date formats.

The main objective was to clean the data properly and then use it to generate meaningful business insights.

---

## Tools Used

* MySQL
* Excel (for validating outputs)
* GitHub

---

## Dataset

* Superstore sales dataset
* Includes order, customer, product, sales, and profit details

---

## Data Cleaning Steps

The following data cleaning steps were performed:

* Removed duplicate records using `ROW_NUMBER()`
* Handled missing values in columns like City and Customer Name
* Standardized text fields using `LOWER()` and `TRIM()`
* Fixed inconsistent date formats
  (some rows had `mm/dd/yyyy` and others had `dd-mm-yyyy`)
* Used conditional SQL logic (`CASE` / `COALESCE`) to correctly convert date values
* Created a cleaned dataset (`clean_superstore`) for further analysis

---

## Key Challenge Solved

The dataset contained mixed date formats, which caused errors during conversion in MySQL.

To resolve this:

* Identified different date patterns (`/` vs `-`)
* Applied conditional logic to convert them correctly
* Ensured all date values were standardized before analysis

This step was important to avoid incorrect results in time-based analysis.

---

## Analysis Performed

* Total sales and average order value
* Sales by category
* Profit by region
* Monthly sales trends
* Top customers and products
* Identification of loss-making orders

---

## Key Insights

* A few product categories contribute the majority of total sales
* Certain regions are more profitable than others
* A small number of customers drive a large share of revenue
* Some orders result in losses, indicating potential pricing or cost issues

---

## Conclusion

This project demonstrates how SQL can be used to clean real-world data and generate useful insights. Proper data cleaning is essential before performing any analysis.

---

## Future Improvements

* Build an interactive dashboard using Excel or Power BI
* Add time-based trend and seasonality analysis
* Automate the data cleaning process


