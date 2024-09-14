WITH soh AS (SELECT
                CustomerID,
                ContactID,
                OrderDate,
                COUNT(*) AS number_orders,
                ROUND(SUM(TotalDue), 3) total_amount,
                MAX(OrderDate) AS date_last_order
                
              FROM
                `adwentureworks_db.salesorderheader` soh_

              INNER JOIN
                `adwentureworks_db.salesterritory`  st
              ON soh_.TerritoryID = st.TerritoryID

              WHERE st.Group = 'North America'

              GROUP BY 1,2,3

              HAVING total_amount >= 2500 OR number_orders >= 5),

     status AS (SELECT
                  CustomerID,
                  CASE 
                        WHEN MAX(OrderDate) <= DATE_ADD((SELECT MAX(OrderDate) FROM `adwentureworks_db.salesorderheader`), INTERVAL -365 DAY) THEN 'Inactive'
                        ELSE 'Active'
                    END AS customerstatus

              FROM
                `adwentureworks_db.salesorderheader`
                
              GROUP BY 1),
    
    contact AS (SELECT
                  ContactID,
                  Firstname,
                  Lastname,
                  CONCAT(Firstname, ' ', Lastname) Fullname,
                  CASE WHEN title IS NULL THEN CONCAT('Dear', ' ', Lastname) ELSE CONCAT(title, ' ', Lastname) END AS addressing_title,
                  Emailaddress,
                  Phone
                FROM
                  `adwentureworks_db.contact`),


    cus_add AS (SELECT
                  CustomerID,
                  AddressID
                FROM
                  `adwentureworks_db.customeraddress`),


    address AS (SELECT
                  AddressID,
                  StateProvinceID,
                  AddressLine1,
                  LEFT(AddressLine1,STRPOS(AddressLine1, ' ')) Address_no,
                  RIGHT(AddressLine1, LENGTH(AddressLine1) - STRPOS(AddressLine1, ' ')) Address_st,
                  City
                FROM
                  `adwentureworks_db.address`),

    state AS (SELECT
                StateProvinceID,
                CountryRegionCode,
                Name AS state
              FROM
                `adwentureworks_db.stateprovince`),     
          
    country AS (SELECT
                  COuntryRegionCode,
                  Name AS Country
                FROM
                  `adwentureworks_db.countryregion`)

SELECT
    cus.CustomerID,
    contact.Firstname,
    contact.Lastname,
    contact.Fullname,
    contact.addressing_title,
    contact.Emailaddress,
    contact.Phone,
    cus.AccountNumber,
    cus.CustomerType,
    address.City,
    address.AddressLine1,
    address.Address_no,
    address.Address_st,
    country.country,
    state.state,
    soh.date_last_order,
    soh.number_orders,
    soh.total_amount,
    status.customerstatus

FROM  
  soh

INNER JOIN
   `adwentureworks_db.customer` cus
ON soh.CustomerID = cus.CustomerID

INNER JOIN 
   contact
ON soh.ContactID = contact.ContactID

INNER JOIN
    status
ON soh.CustomerID = status.CustomerID

INNER JOIN
  cus_add
ON cus_add.CustomerID = cus.CustomerID

INNER JOIN
  address
ON cus_add.AddressID = address.AddressID

INNER JOIN
  state
ON address.StateProvinceID = state.StateProvinceID

INNER JOIN
  country
ON state.CountryRegionCode = country.CountryRegionCode

WHERE  status.customerstatus = 'Active' AND cus.CustomerType = 'I'

ORDER BY 14,15,16 
LIMIT 500;



