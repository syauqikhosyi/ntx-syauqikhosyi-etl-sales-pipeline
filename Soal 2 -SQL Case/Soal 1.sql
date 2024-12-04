-- Test Case 1
WITH revenue_per_country AS (
    SELECT
        country,
        channelgrouping,
        SUM(CAST(COALESCE(totaltransactionrevenue, 0) AS BIGINT)) AS total_revenue
    FROM
        ecommerce.all_sessions
    GROUP BY
        country, channelgrouping
),
top_countries AS (
    SELECT
        country,
        SUM(total_revenue) AS total_revenue
    FROM
        revenue_per_country
    GROUP BY
        country
    ORDER BY
        total_revenue DESC
    LIMIT 5
)

SELECT
    rpc.country,
    rpc.channelgrouping,
    rpc.total_revenue
FROM
    revenue_per_country rpc
JOIN
    top_countries tc
ON
    rpc.country = tc.country
ORDER BY
    tc.total_revenue DESC, rpc.total_revenue DESC;
