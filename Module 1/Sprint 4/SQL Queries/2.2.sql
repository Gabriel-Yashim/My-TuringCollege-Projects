WITH sales_data AS (
    SELECT
        DISTINCT
        LAST_DAY(DATE(sales.OrderDate), MONTH) AS order_month,
        st.Name AS TerritoryName,
        cr.CountryRegionCode,
        COUNT(sales.SalesOrderID) AS number_orders,
        COUNT(sales.CustomerID) AS number_customers,
        COUNT(sales.SalesPersonID) AS no_salesperson,
        ROUND(SUM(sales.TotalDue), 0) AS Total_w_tax
    FROM
        `adwentureworks_db.salesorderheader` sales 
        LEFT JOIN 
          `adwentureworks_db.salesterritory` AS st 
        ON sales.TerritoryID = st.TerritoryID
        INNER JOIN 
          `adwentureworks_db.countryregion` AS cr 
        ON st.CountryRegionCode = cr.CountryRegionCode
    GROUP BY
        order_month,
        TerritoryName,
        cr.CountryRegionCode
)


SELECT
    order_month,
    TerritoryName,
    CountryRegionCode,
    number_orders,
    number_customers,
    no_salesperson,
    Total_w_tax,
    SUM(Total_w_tax) OVER (PARTITION BY CountryRegionCode, TerritoryName ORDER BY order_month) AS cumulative_sum
FROM
    sales_data
ORDER BY
    CountryRegionCode,
    TerritoryName,
    order_month;
