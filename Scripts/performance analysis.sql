/* ============================================================
   Performance Analysis
   Dataset: Gold.fact_sales, Gold.dim_prodcut
   Purpose:
   Evaluate product performance over time by:
   - Yearly sales
   - Comparison against product average
   - Year-over-Year (YoY) performance trends
   ============================================================ */


-- ============================================================
-- CTE: Yearly Sales Aggregation per Product
-- ============================================================
WITH performance_analysis AS (
    SELECT 
        YEAR(f.order_date) AS sales_year,        -- Sales year
        p.product_name     AS product_name,      -- Product name
        SUM(f.sales)       AS current_year_sales -- Total sales per year
    FROM Gold.fact_sales f
    LEFT JOIN Gold.dim_prodcut p
        ON p.product_key = f.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY 
        p.product_name,
        YEAR(f.order_date)
)

-- ============================================================
-- Final Select: Performance Metrics & Trends
-- ============================================================
SELECT 
    sales_year,
    product_name,
    current_year_sales,

    -- Average yearly sales per product (across all years)
    AVG(current_year_sales) 
        OVER (PARTITION BY product_name) AS avg_yearly_sales,

    -- Difference between current year sales and average sales
    current_year_sales -
        AVG(current_year_sales) 
            OVER (PARTITION BY product_name) AS cy_vs_avg_difference,

    -- Flag indicating performance vs average
    CASE 
        WHEN current_year_sales -
             AVG(current_year_sales) OVER (PARTITION BY product_name) > 0
            THEN 'ABOVE AVERAGE'
        WHEN current_year_sales -
             AVG(current_year_sales) OVER (PARTITION BY product_name) < 0
            THEN 'BELOW AVERAGE'
        ELSE 'NO CHANGE'
    END AS avg_comparison_flag,

    -- Previous year sales (YoY comparison)
    LAG(current_year_sales) 
        OVER (PARTITION BY product_name ORDER BY sales_year) AS previous_year_sales,

    -- Difference between current year and previous year sales
    current_year_sales -
        LAG(current_year_sales) 
            OVER (PARTITION BY product_name ORDER BY sales_year) AS cy_vs_py_difference,

    -- YoY performance indicator
    CASE 
        WHEN current_year_sales >
             LAG(current_year_sales) OVER (PARTITION BY product_name ORDER BY sales_year)
            THEN 'INCREASE'
        WHEN current_year_sales <
             LAG(current_year_sales) OVER (PARTITION BY product_name ORDER BY sales_year)
            THEN 'DECREASE'
        ELSE 'NO CHANGE'
    END AS performance_indicator

FROM performance_analysis
ORDER BY 
    product_name,
    sales_year;
