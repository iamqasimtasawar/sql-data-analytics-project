/* ============================================================
   Cumulative Analysis (Running Totals)
   Dataset: Gold.fact_sales
   Purpose:
   Calculate monthly cumulative (running) sales and quantity
   within each calendar year.

   Metrics:
   - Monthly Sales
   - Running Total Sales (YTD)
   - Monthly Quantity
   - Running Total Quantity (YTD)
   ============================================================ */


-- ============================================================
-- CTE: Monthly Aggregation
-- Groups raw sales data at month level
-- ============================================================
WITH cumulative AS (
    SELECT 
        DATETRUNC(month, order_date) AS sales_month,
        SUM(sales)                   AS monthly_sales,
        SUM(quantity)                AS monthly_quantity
    FROM Gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY 
        DATETRUNC(month, order_date)
)

-- ============================================================
-- Final Select: Running Total Calculation
-- Uses window functions to calculate YTD values
-- ============================================================
SELECT
    sales_month,
    monthly_sales,

    -- Running total of sales within each year (YTD)
    SUM(monthly_sales) 
        OVER (
            PARTITION BY YEAR(sales_month) 
            ORDER BY sales_month
        ) AS running_total_sales,

    monthly_quantity,

    -- Running total of quantity within each year (YTD)
    SUM(monthly_quantity) 
        OVER (
            PARTITION BY YEAR(sales_month) 
            ORDER BY sales_month
        ) AS running_total_quantity

FROM cumulative
ORDER BY 
    sales_month;
