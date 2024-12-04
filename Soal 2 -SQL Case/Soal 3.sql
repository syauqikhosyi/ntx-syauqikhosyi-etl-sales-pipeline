-- Test Case 3

WITH product_metrics AS (
    SELECT
        v2productname,
        SUM(CAST(COALESCE(NULLIF(productrevenue, '')::BIGINT, 0) AS BIGINT)) AS total_revenue,
        SUM(CAST(COALESCE(NULLIF(itemquantity, '')::BIGINT, 0) AS BIGINT)) AS total_quantity_sold,
        SUM(CAST(COALESCE(NULLIF(productrefundamount, '')::BIGINT, 0) AS BIGINT)) AS total_refund
    FROM
        ecommerce.all_sessions
    WHERE
        v2productname IS NOT NULL
    GROUP BY
        v2productname
),
product_rankings AS (
    SELECT
        v2productname,
        total_revenue,
        total_quantity_sold,
        total_refund,
        (total_revenue - total_refund) AS net_revenue,
        CASE
            WHEN total_refund > 0.1 * total_revenue THEN 'Flagged'
            ELSE 'OK'
        END AS refund_flag
    FROM
        product_metrics
)

SELECT
    v2productname,
    total_revenue,
    total_quantity_sold,
    total_refund,
    net_revenue,
    refund_flag
FROM
    product_rankings
ORDER BY
    net_revenue DESC;
