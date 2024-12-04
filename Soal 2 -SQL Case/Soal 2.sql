-- Test Case 2
WITH user_metrics AS (
    SELECT
        fullvisitorid,
        AVG(timeonsite) AS avg_timeonsite,
        AVG(pageviews) AS avg_pageviews,
        AVG(sessionqualitydim) AS avg_session_quality
    FROM
        ecommerce.all_sessions
    WHERE
        timeonsite IS NOT NULL
        AND pageviews IS NOT NULL
    GROUP BY
        fullvisitorid
),
overall_metrics AS (
    SELECT
        AVG(avg_timeonsite) AS overall_avg_timeonsite,
        AVG(avg_pageviews) AS overall_avg_pageviews
    FROM
        user_metrics
)

SELECT
    um.fullvisitorid,
    um.avg_timeonsite,
    um.avg_pageviews,
    um.avg_session_quality
FROM
    user_metrics um
CROSS JOIN
    overall_metrics om
WHERE
    um.avg_timeonsite > om.overall_avg_timeonsite
    AND um.avg_pageviews < om.overall_avg_pageviews
ORDER BY
    um.avg_timeonsite DESC;
