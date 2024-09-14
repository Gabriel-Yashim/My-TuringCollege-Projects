-- Queries to get the products table
SELECT 
    orderdetail.SalesOrderID, 
    orderdetail.OrderQty,
    product.ProductID,
    productSub.Name AS SubcategoryName,
    productCat.Name AS CategoryName
FROM 
    `tc-da-1.adwentureworks_db.salesorderdetail` AS orderdetail

INNER JOIN
    `tc-da-1.adwentureworks_db.product` AS product
  ON product.ProductID = orderdetail.ProductID

INNER JOIN
    `tc-da-1.adwentureworks_db.productsubcategory` AS productSub
  ON product.ProductSubcategoryID = productSub.ProductSubcategoryID

INNER JOIN
    `tc-da-1.adwentureworks_db.productcategory` AS productCat
  ON productSub.ProductCategoryID = productCat.ProductCategoryID;


-- Queries to get the customers tables
SELECT 
    CustomerID,
    TerritoryID,
    CustomerType

FROM 
    `tc-da-1.adwentureworks_db.customer`;
