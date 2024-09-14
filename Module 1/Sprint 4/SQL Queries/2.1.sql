SELECT
        Distinct LAST_DAY(DATE(sales.OrderDate), MONTH) AS order_month,
        st.Name AS TerritoryName,
        cr.CountryRegionCode,
        COUNT(sales.SalesOrderID) number_orders,
        COUNT(sales.CustomerID) number_customers,
        COUNT(sales.SalesPersonID) no_salesperson,
        ROUND(SUM(sales.TotalDue), 0) Total_w_tax
    FROM
        `adwentureworks_db.salesorderheader` sales 
        LEFT JOIN 
          `adwentureworks_db.salesterritory` AS st 
        ON sales.TerritoryID = st.TerritoryID

        INNER JOIN 
          `adwentureworks_db.countryregion` AS cr 
        ON st.CountryRegionCode = cr.CountryRegionCode
        
    GROUP BY 1,2,3;