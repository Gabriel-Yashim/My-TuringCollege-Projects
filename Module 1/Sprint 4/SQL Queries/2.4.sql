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
                ),

                tax_data AS (
                    SELECT
                        cr.CountryRegionCode,
                        MAX(tp.TaxRate) AS max_tax_rate
                    FROM
                        `adwentureworks_db.countryregion` cr
                    INNER JOIN
                        `adwentureworks_db.stateprovince` sp ON cr.CountryRegionCode = sp.CountryRegionCode
                    INNER JOIN
                        `adwentureworks_db.salestaxrate` tp ON sp.StateProvinceID = tp.StateProvinceID
                    GROUP BY
                        cr.CountryRegionCode, sp.StateProvinceID
                ),

                mean_tax_data AS (
                    SELECT
                        cr.CountryRegionCode,
                        ROUND(AVG(max_tax_rate), 2) AS mean_tax_rate,
                        COUNT(sp.StateProvinceID) AS provinces_with_tax,
                        COUNT(DISTINCT sp.StateProvinceID) AS total_provinces
                    FROM
                        `adwentureworks_db.countryregion` cr
                    INNER JOIN
                        `adwentureworks_db.stateprovince` sp ON cr.CountryRegionCode = sp.CountryRegionCode
                    LEFT JOIN
                        (SELECT
                            sp.StateProvinceID,
                            MAX(tp.TaxRate) AS max_tax_rate
                        FROM
                            `adwentureworks_db.stateprovince` sp
                        INNER JOIN
                            `adwentureworks_db.salestaxrate` tp ON sp.StateProvinceID = tp.StateProvinceID
                        GROUP BY
                            sp.StateProvinceID) tp_max ON sp.StateProvinceID = tp_max.StateProvinceID
                    GROUP BY
                        cr.CountryRegionCode
                ),

                cummulative_data AS (
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
                )

SELECT
    cummulative_data.*,
    mtd.mean_tax_rate,
    ROUND(mtd.provinces_with_tax / NULLIF(mtd.total_provinces, 0), 2) AS perc_provinces_w_tax,
    RANK() OVER (PARTITION BY cummulative_data.CountryRegionCode, TerritoryName ORDER BY Total_w_tax DESC) AS sales_rank
FROM
    cummulative_data
LEFT JOIN
    mean_tax_data AS mtd ON cummulative_data.CountryRegionCode = mtd.CountryRegionCode
ORDER BY
    CountryRegionCode,
    TerritoryName,
    order_month;
