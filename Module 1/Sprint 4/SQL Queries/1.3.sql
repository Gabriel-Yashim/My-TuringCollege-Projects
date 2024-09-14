WITH soh AS (SELECT
                CustomerID,
                ContactID,
                OrderDate,
                COUNT(*) number_orders,
                ROUND(SUM(TotalDue), 3) total_amount,
                MAX(OrderDate) AS MaxDate
                
              FROM
                `adwentureworks_db.salesorderheader`
              GROUP BY 1,2,3),
    
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
                  AddressLine2,
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
    address.AddressLine2,
    state.state,
    country.country,
    soh.OrderDate,
    soh.number_orders,
    soh.total_amount,
    CASE 
        WHEN MaxDate <= DATE_ADD((SELECT MAX(OrderDate) FROM `adwentureworks_db.salesorderheader`), INTERVAL -365 DAY) THEN 'Inactive'
        ELSE 'Active'
    END AS CustomerStatus

FROM  
  `adwentureworks_db.customer` cus

INNER JOIN
   soh
ON soh.CustomerID = cus.CustomerID

INNER JOIN 
   contact
ON soh.ContactID = contact.ContactID

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

WHERE cus.CustomerType = 'I'
ORDER BY 17 DESC
LIMIT 500;