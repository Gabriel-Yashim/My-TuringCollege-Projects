# Title: Customer Retention, Cohorts & Churn

As part of this project, I analyzed subscription churn from a weekly retention perspective. Monthly retention views were deemed too slow for identifying critical insights, so I utilized cohort analysis to provide a more granular understanding.

#### **Objective**
To create a weekly retention cohort analysis that tracks how many subscribers started their subscriptions in a given week and remained active over the subsequent six weeks. The analysis was performed on data available up to **2021-02-07**.

#### **Process**
1. **Data Extraction:**
   - Queried the `turing_data_analytics.subscriptions` table in BigQuery to retrieve the necessary subscription data.
   
2. **Cohort Analysis:**
   - Using SQL queries, I grouped subscribers into cohorts based on their subscription start week.
   - Calculated weekly retention rates for each cohort, spanning from **week 0** (subscription week) to **week 6**.

3. **Visualization:**
   - I visualized the retention cohorts using Heatmap (conditional formating in MS Excel).
   - Created an easy-to-read chart to highlight retention trends over time.

4. **Insights:**
   - While there is a noticeable decline in retention rates from week 0 to week 6, the largest drop in retention tends to happen between week 1 and week 2. Most cohorts experience a 3-5% decline. This could suggest that users are more likely to churn after the initial subscription week.
   
   - Later cohorts (from December 2020 to January 2021) show slightly higher retention rates compared to earlier ones (October/November 2020). This may indicate improvements in customer experience, product offerings, marketing efforts, or more effective engagement strategies over time.
   
   - The retention rates for cohorts starting from 12/21/2020 and onwards appear to be consistently high, while prior cohorts generally have a steeper decline in retention during the first few weeks. These cohorts starting from 12/21/2020 and onwards start with 100% retention in week 0; by week 6, retention rates are around 93-94%. This could suggest that users who subscribed during this period (holiday season or new year) were more engaged or attracted by special promotions.
   
   - By week 4 and onwards, retention rates seem to stabilize across most cohorts, suggesting that users who remain beyond the initial weeks are more likely to continue their subscriptions for a longer period.
   
5. **Recommendation**
    - Since the most significant drop in retention occurs between weeks 1 and 2, it’s critical to target users with engagement strategies during this period, such as personalized emails, in-app reminders, or special offers.
    
    - Investigate the factors that contributed to the high retention rates for cohorts from December 2020 and January 2021. Were there specific promotions, content releases, or other initiatives that improved retention during this time? These are questions that must be answered.
    
    - Since retention stabilizes after week 4, more focus should be placed on the earlier weeks (1-3) where most of the churn occurs. Focus on improving user experience, address possible friction points in the user experience during this time, and making the product stickier at this stage.
    