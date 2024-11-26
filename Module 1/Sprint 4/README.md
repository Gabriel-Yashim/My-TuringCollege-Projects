# About  this project


This project though more advance then the previous, aimed to also test my SQL skills and how I could interprete real life problems into code logic. For this project I worked with the <a href='https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms' target='_blank'>Adventureworks 2005 database</a> where I identified the needed data and the correct way to get it/merge it together with other tables within this database.

I created queries to solve specific business questions with two main questions with this project:

### 1.1 The first thing was to write a query that create a detailed overview of all individual customers.

### 1.2 The next thing is to filter customers, the top 200 customers with the highest total amount (with tax) who have not ordered for the last 365 days

### 1.3 I improved on my initial query in 1.1 by creating a new column in the view that marks active & inactive customers based on whether they have ordered anything during the last 365 days.

### 1.4 I went futher to filter the results from 1.3 to include all active customers from North America. Only customers that have either ordered no less than 2500 in total amount (with Tax) or ordered 5 + times.

### 2.1 I wanted to create a report on sales numbers here. So I wrote a query to show monthly sales by Country and Region, including number of orders, customers and sales persons in each month with a total amount with tax earned.

### 2.2 Using CTE, I improved the query in 2.1 to include cumulative_sum of the total amount with tax earned per country & region.

### 2.3 Taking query 2.2 a step further, I added ‘sales_rank’ column that ranks rows from best to worst for each country based on total amount with tax earned each month.

### 2.4 Finally, I enriched query 2.3 by adding taxes on a country level.