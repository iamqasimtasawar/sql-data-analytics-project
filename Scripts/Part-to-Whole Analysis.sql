/* ============================================================
   Part-to-Whole Analysis
   Dataset: Gold.fact_sales, Gold.dim_customer, Gold.dim_prodcut
   Purpose:
   Analyze how each product category contributes to:
   - Total Sales
   - Total Customers
   ============================================================ */


-- ============================================================
-- CTE: Aggregate sales and customers by product category
-- ============================================================
WITH part_whole AS (
    SELECT 
        p.prodcut_Category AS product_category,
        COUNT(DISTINCT c.Customer_id) AS total_customers,
        SUM(f.sales) AS total_sales
    FROM Gold.fact_sales f
    LEFT JOIN Gold.dim_customer c
        ON f.Customer_key = c.Customer_key
    LEFT JOIN Gold.dim_prodcut p
        ON f.product_key = p.product_key
    GROUP BY 
        p.prodcut_Category
)

-- ============================================================
-- Final Select: Part-to-Whole Contribution Calculation
-- ============================================================
SELECT
    product_category,
    total_customers,
    total_sales,

    -- Overall totals across all categories
    SUM(total_sales) OVER () AS overall_sales,

    -- Percentage contribution of each category to total sales
    ROUND(
        (CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 
        2
    ) AS percentage_sales,

    -- Percentage contribution of each category to total customers
    ROUND(
        (CAST(total_customers AS FLOAT) / SUM(total_customers) OVER ()) * 100, 
        2
    ) AS percentage_customers

FROM part_whole
ORDER BY 
    percentage_sales DESC;
