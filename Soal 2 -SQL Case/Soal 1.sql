-- Test Case 1
WITH revenue_per_country AS (
    SELECT
        country,
        channelgrouping, 
        SUM(CAST(COALESCE(totaltransactionrevenue, 0) AS BIGINT)) AS total_revenue
        -- Calculate the total revenue for each country and channel grouping.
        -- Use COALESCE to replace NULL values in 'totaltransactionrevenue' with 0.
        -- CAST ensures the revenue is treated as BIGINT for summation.
    FROM
        ecommerce.all_sessions 
    GROUP BY
        country, channelgrouping 
),

-- Step 2: Identify the top 5 countries by total revenue
top_countries AS (
    SELECT
        country, 
        SUM(total_revenue) AS total_revenue
        -- Sum the total revenue across all channel groupings for each country.
    FROM
        revenue_per_country 
    GROUP BY
        country 
    ORDER BY
        total_revenue DESC -
    LIMIT 5 -- Restrict results to the top 5 countries
)

-- Step 3: Combine data for top countries and their channel-wise revenue
SELECT
    rpc.country, 
    rpc.channelgrouping, 
    rpc.total_revenue 
FROM
    revenue_per_country rpc -
JOIN
    top_countries tc -- The top 5 countries determined in the previous step
ON
    rpc.country = tc.country -- Match countries from both tables
ORDER BY
    tc.total_revenue DESC, -- Sort by total revenue of the country in descending order
    rpc.total_revenue DESC; -- Sort by total revenue of each channel grouping in descending order within each country