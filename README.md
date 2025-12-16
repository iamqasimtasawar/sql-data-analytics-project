# Data Warehouse Analytics

## Overview

This repository contains **SQL-based data analytics** built on top of a **Medallion Architecture Data Warehouse (Bronze → Silver → Gold)**.
The focus of this project is to transform **Gold-layer data** into **business-ready insights** using real-world analytics techniques commonly used by Data Analysts, BI Developers, and Analytics Engineers.

This repository is a continuation of my **Data Warehouse project**, where the core data modeling and ETL pipelines were designed. Here, the emphasis is on **analysis, trends, segmentation, and performance measurement**.

---

## Project Objectives

* Perform real-world business analytics using SQL
* Analyze trends, growth, and performance over time
* Segment customers based on behavior and value
* Measure contribution and distribution across dimensions
* Demonstrate advanced SQL skills using window functions

---

## Data Source

All analyses are based on the **Gold Layer** of the data warehouse, which contains clean, integrated, and analytics-ready data.

**Core Tables Used:**

* `Gold.fact_sales`
* `Gold.dim_customer`
* `Gold.dim_prodcut`

---

## Analytics Use Cases Covered

### 1. Change Over Time Analysis

**Purpose:**
Analyze how sales and quantity change over time.

**Key Metrics:**

* Monthly Sales
* Monthly Quantity

**Techniques Used:**

* Date aggregation (Year/Month)
* `DATETRUNC()` for time-series analysis
* Trend-based ordering

📄 File: `change_over_time_analysis.sql`

---

### 2. Cumulative (Running Total / YTD) Analysis

**Purpose:**
Track cumulative performance within each calendar year.

**Key Metrics:**

* Monthly Sales
* Year-to-Date (YTD) Sales
* Monthly Quantity
* YTD Quantity

**Techniques Used:**

* Window functions
* `SUM() OVER (PARTITION BY … ORDER BY …)`
* Year-based partitioning

📄 File: `cumulative_ytd_analysis.sql`

---

### 3. Part-to-Whole Analysis

**Purpose:**
Understand how each product category contributes to the overall business.

**Key Metrics:**

* Total Sales by Category
* Total Customers by Category
* Percentage contribution to total sales
* Percentage contribution to total customers

**Techniques Used:**

* Window functions
* Percentage calculations
* Category-level aggregation

📄 File: `part_to_whole_analysis.sql`

---

### 4. Performance Analysis (YoY & Average Comparison)

**Purpose:**
Evaluate product performance over time.

**Key Metrics:**

* Current Year Sales
* Average Sales per Product
* Year-over-Year (YoY) Change
* Performance Flags (Increase / Decrease)

**Techniques Used:**

* `AVG()` and `LAG()` window functions
* YoY comparison logic
* Performance indicators

📄 File: `product_performance_analysis.sql`

---

### 5. Customer Segmentation Analysis

**Purpose:**
Segment customers based on their value and relationship duration.

**Segments Defined:**

* **VIP** – Long-term, high-value customers
* **Regular** – Long-term, lower-value customers
* **New** – Recently acquired customers

**Segmentation Criteria:**

* Total customer sales
* Customer lifespan (months)

**Techniques Used:**

* Aggregation per customer
* Conditional segmentation using `CASE`

📄 File: `customer_segmentation_analysis.sql`

---

## SQL Concepts Demonstrated

* Common Table Expressions (CTEs)
* Window Functions (`SUM`, `AVG`, `LAG`)
* Time-based analysis
* Business rule implementation
* Analytical aggregations
* Clean and readable SQL design

---

## Tools & Technologies

* Microsoft SQL Server
* SQL (T-SQL)
* Medallion Architecture
* Analytics Engineering principles

---

## How This Project Is Useful

This project demonstrates how:

* Raw warehouse data becomes actionable insight
* Analytics supports business decision-making
* SQL can be used beyond basic querying for advanced analysis

It reflects **real-world analytics workflows** used in BI and data teams.

---

## Related Project

This analytics repository is built on top of my **Data Warehouse project**:

🔗 **Data Warehouse Repository:**
[https://lnkd.in/d7Us2-Um](https://lnkd.in/d7Us2-Um)

---

## Author

**Qasim Tasawar**
Data Analyst | BI Developer
Focused on SQL, Data Warehousing, and Analytics Engineering

---

## Future Enhancements

* RFM customer segmentation
* Power BI dashboards
* KPI-focused executive views
* Automation of analytics views

---

⭐ If you find this project helpful, feel free to explore, fork, or share feedback.
