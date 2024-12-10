-- Test Case 2
WITH user_metrics AS (
    SELECT
        fullvisitorid,
        AVG(timeonsite) AS avg_timeonsite, -- Calculate the average time spent on the site per user
        AVG(pageviews) AS avg_pageviews, -- Calculate the average number of page views per user
        AVG(sessionqualitydim) AS avg_session_quality -- Calculate the average session quality metric per user
    FROM
        ecommerce.all_sessions
    WHERE
        timeonsite IS NOT NULL -- Exclude rows where 'timeonsite' is NULL
        AND pageviews IS NOT NULL -- Exclude rows where 'pageviews' is NULL
    GROUP BY
        fullvisitorid 
),

-- Step 2: Calculate overall averages across all users
overall_metrics AS (
    SELECT
        AVG(avg_timeonsite) AS overall_avg_timeonsite, -- Overall average time spent on site across all users
        AVG(avg_pageviews) AS overall_avg_pageviews -- Overall average page views across all users
    FROM
        user_metrics 
)

-- Step 3: Identify users who meet the conditions
SELECT
    um.fullvisitorid, 
    um.avg_timeonsite, 
    um.avg_pageviews, -- User's average page views
    um.avg_session_quality -- User's average session quality
FROM
    user_metrics um -- Use the user-specific metrics
CROSS JOIN
    overall_metrics om -- Include the overall metrics for comparison
WHERE
    um.avg_timeonsite > om.overall_avg_timeonsite -- Select users with above-average time on site
    AND um.avg_pageviews < om.overall_avg_pageviews -- But below-average page views
ORDER BY
    um.avg_timeonsite DESC; -- Sort the results by descending average time on site