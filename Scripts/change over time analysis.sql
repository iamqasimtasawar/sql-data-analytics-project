/* ============================================================
   Change Over Time Analysis
   Dataset: Gold.fact_sales
   Purpose:
   Analyze sales and quantity trends over time using 
   different date aggregation techniques.

   Metrics:
   - Total Sales
   - Total Quantity
   ============================================================ */


/* ============================================================
   1. Year & Month Level Aggregation
   ------------------------------------------------------------
   Useful when:
   - You want to analyze trends by calendar year and month
   - Suitable for high-level reporting and dashboards
   ============================================================ */
SELECT
    YEAR(order_date)  AS sales_year,
    MONTH(order_date) AS sales_month,
    SUM(sales)        AS total_sales,
    SUM(quantity)     AS total_quantity
FROM Gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    sales_year,
    sales_month;



/* ============================================================
   2. Month-Level Aggregation using DATETRUNC
   ------------------------------------------------------------
   Useful when:
   - You need a clean monthly date key (first day of month)
   - Ideal for time-series analysis in BI tools
   ============================================================ */
SELECT
    DATETRUNC(month, order_date) AS month_start_date,
    SUM(sales)                   AS total_sales,
    SUM(quantity)                AS total_quantity
FROM Gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY
    DATETRUNC(month, order_date)
ORDER BY
    month_start_date;



/* ============================================================
   3. Formatted Date for Readable Reporting
   ------------------------------------------------------------
   Useful when:
   - Creating human-readable labels (YYYY-MMM)
   - Best for simple reports or exports
   ============================================================ */
SELECT
    FORMAT(order_date, 'yyyy-MMM') AS sales_period,
    SUM(sales)                     AS total_sales,
    SUM(quantity)                  AS total_quantity
FROM Gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY
    FORMAT(order_date, 'yyyy-MMM')
ORDER BY
    sales_period;
