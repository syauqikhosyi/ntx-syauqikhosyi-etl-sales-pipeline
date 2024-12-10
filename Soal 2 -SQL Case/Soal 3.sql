-- Test Case 3
WITH product_metrics AS (
    SELECT
        v2productname,
        SUM(CAST(COALESCE(NULLIF(productrevenue, '')::BIGINT, 0) AS BIGINT)) AS total_revenue,
        -- Calculate total revenue for each product by:
        -- 1. Replacing empty strings ('') with NULL using NULLIF.
        -- 2. Handling NULL values by replacing them with 0 using COALESCE.
        -- 3. Casting the result to BIGINT for summation.
        
        SUM(CAST(COALESCE(NULLIF(itemquantity, '')::BIGINT, 0) AS BIGINT)) AS total_quantity_sold,
        -- Calculate total quantity sold for each product using the same technique as above.
        
        SUM(CAST(COALESCE(NULLIF(productrefundamount, '')::BIGINT, 0) AS BIGINT)) AS total_refund
        -- Calculate total refund amount for each product using the same technique as above.
    FROM
        ecommerce.all_sessions
    WHERE
        v2productname IS NOT NULL -- Exclude rows where the product name is NULL
    GROUP BY
        v2productname -- Group results by product name to compute metrics per product
),

-- Step 2: Compute rankings and refund flags for each product
product_rankings AS (
    SELECT
        v2productname, 
        total_revenue, 
        total_quantity_sold, 
        total_refund, 
        (total_revenue - total_refund) AS net_revenue, 
        CASE
            WHEN total_refund > 0.1 * total_revenue THEN 'Flagged' -- Flag products with refunds > 10% of revenue
            ELSE 'OK' -- Otherwise, mark as OK
        END AS refund_flag -- Indicate whether the product is flagged for high refunds
    FROM
        product_metrics -- Use the metrics calculated in the previous step
)

-- Step 3: Output the ranked product data
SELECT
    v2productname, 
    total_revenue, 
    total_quantity_sold, 
    total_refund, 
    net_revenue, 
    refund_flag 
FROM
    product_rankings -- Use the rankings and metrics calculated in the previous step
ORDER BY
    net_revenue DESC; -- Sort products by net revenue in descending order