/* ============================================================
   Customer Segmentation Analysis
   Dataset: Gold.fact_sales, Gold.dim_customer
   Purpose:
   Segment customers based on:
   - Total sales value
   - Customer lifespan (time between first and last purchase)

   Segments:
   - VIP      → Long-term & high-value customers
   - Regular  → Long-term but lower-value customers
   - New      → Recently acquired customers
   ============================================================ */


-- ============================================================
-- CTE: Customer-Level Metrics
-- Calculates total sales and lifespan per customer
-- ============================================================
WITH customer_segmentation AS (
    SELECT
        c.Customer_id AS customer_id,                                -- Customer identifier
        SUM(f.sales) AS total_sales,                                 -- Total customer spend
        DATEDIFF(
            month, 
            MIN(f.order_date), 
            MAX(f.order_date)
        ) AS customer_lifespan                                      -- Lifespan in months
    FROM Gold.fact_sales f
    LEFT JOIN Gold.dim_customer c
        ON c.Customer_key = f.Customer_key
    GROUP BY 
        c.Customer_id
)

-- ============================================================
-- Final Select: Segment Assignment & Distribution
-- ============================================================
SELECT
    customer_segment,
    COUNT(customer_id) AS total_customers
FROM (
        -- Assign segment label to each customer
        SELECT
            customer_id,
            total_sales,
            customer_lifespan,
            CASE 
                WHEN customer_lifespan >= 12 AND total_sales > 5000
                    THEN 'VIP'
                WHEN customer_lifespan >= 12 AND total_sales <= 5000
                    THEN 'Regular'
                ELSE 'New'
            END AS customer_segment
        FROM customer_segmentation
    ) AS classified
GROUP BY 
    customer_segment
ORDER BY 
    total_customers DESC;
