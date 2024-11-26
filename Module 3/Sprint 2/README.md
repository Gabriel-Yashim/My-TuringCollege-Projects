# Title: Funnel Analysis

### **Overview**  
This project focuses on creating a funnel chart to analyze user behavior using data from a `raw_events` table. The goal is to identify meaningful user actions, eliminate duplicates, and generate actionable insights through a country-based funnel analysis. Here's how I approached the project:



### **Steps Taken**  

1. **Data Exploration and Deduplication**  
   - Analyzed the `raw_events` table to understand the types of user events captured and their timestamps.  
   - Identified potential duplicates, such as repeated events by the same user, which could skew the results.  
   - Wrote a SQL query to filter out duplicates, ensuring only the first occurrence of each event per user (`user_pseudo_id`) was retained. This step created a clean dataset for accurate funnel analysis.  

2. **Event Selection and Funnel Definition**  
   - Selected 4-6 meaningful event types to include in the funnel analysis, focusing on actions relevant to the user journey (e.g., landing page visits, product views, checkout).  
   - Generated a funnel chart split by the top 3 countries, determined by the total number of events in the dataset.  

3. **Country-Based Analysis**  
   - Created a query to aggregate the selected events, segmented by the top 3 countries, and calculated the drop-off rates between stages in the funnel.  
   - Added additional insights, such as percentage drop-offs and event orders, to better understand user behavior across countries.  

4. **Additional Explorations**  
   - Explored alternative slices and analyses for the funnel, including examining event sequences or other potential segments, to uncover actionable insights.

---

### **Inside the Excel file you will find:**  
- **SQL Queries:**  
  - Query to deduplicate events (ensuring only the first event per user is included).  
  - Query to aggregate and analyze events for the top 3 countries in the funnel.  
- **Funnel Chart:**  
  - A visualization showing user progression through the selected events, with a breakdown by country and percentage drop-off between stages.  
- **Insights:**  
  - Highlighted key differences in user behavior across countries, including potential opportunities for optimization based on observed trends.
