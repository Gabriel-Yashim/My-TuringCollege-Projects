WITH cohort AS (
  SELECT
    user_pseudo_id,
    DATE_TRUNC(subscription_start, WEEK(MONDAY)) AS subscription_week,
    subscription_start,
    subscription_end
  FROM
    `turing_data_analytics.subscriptions`
  WHERE
    subscription_start <= '2021-02-07'
),

weekly_retention AS (
  SELECT
    subscription_week,
    COUNT(user_pseudo_id) AS week_0,
    SUM(CASE WHEN DATE_ADD(subscription_week, INTERVAL 1 WEEK) <= subscription_end OR subscription_end IS NULL THEN 1 ELSE 0 END) AS week_1,
    SUM(CASE WHEN DATE_ADD(subscription_week, INTERVAL 2 WEEK) <= subscription_end OR subscription_end IS NULL THEN 1 ELSE 0 END) AS week_2,
    SUM(CASE WHEN DATE_ADD(subscription_week, INTERVAL 3 WEEK) <= subscription_end OR subscription_end IS NULL THEN 1 ELSE 0 END) AS week_3,
    SUM(CASE WHEN DATE_ADD(subscription_week, INTERVAL 4 WEEK) <= subscription_end OR subscription_end IS NULL THEN 1 ELSE 0 END) AS week_4,
    SUM(CASE WHEN DATE_ADD(subscription_week, INTERVAL 5 WEEK) <= subscription_end OR subscription_end IS NULL THEN 1 ELSE 0 END) AS week_5,
    SUM(CASE WHEN DATE_ADD(subscription_week, INTERVAL 6 WEEK) <= subscription_end OR subscription_end IS NULL THEN 1 ELSE 0 END) AS week_6
  FROM
    cohort
  GROUP BY
    subscription_week
)

SELECT
  subscription_week,
  week_0,
  week_1,
  week_2,
  week_3,
  week_4,
  week_5,
  week_6
FROM
  weekly_retention
ORDER BY
  subscription_week;
