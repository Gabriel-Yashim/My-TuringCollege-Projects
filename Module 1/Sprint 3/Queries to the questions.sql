/* 1. An overview of Products */
/* 1.1 */
SELECT 
    p.ProductId, 
    p.Name, 
    p.ProductNumber, 
    p.size, 
    p.color, 
    ps.ProductSubcategoryId, 
    ps.Name AS ProductSubcategoryName

FROM adwentureworks_db.product AS p 

INNER JOIN adwentureworks_db.productsubcategory AS ps

ON p.ProductSubcategoryId = ps.ProductSubcategoryId;


/* 1.2 */
SELECT 
    p.ProductId, 
    p.Name, 
    p.ProductNumber, 
    p.size, 
    p.color, 
    ps.ProductSubcategoryId, 
    ps.Name AS Subcategory, 
    pc.Name AS Category

FROM adwentureworks_db.product AS p 

INNER JOIN adwentureworks_db.productsubcategory AS ps
ON p.ProductSubcategoryId = ps.ProductSubcategoryId

INNER JOIN adwentureworks_db.productcategory AS pc
ON ps.ProductCategoryID = pc.ProductCategoryID;


/* 1.3 */
SELECT 
    p.ProductId, 
    p.Name,
    p.ProductNumber, 
    p.ListPrice, 
    p.size,
    p.color, 
    ps.ProductSubcategoryId, 
    ps.Name AS Subcategory, 
    pc.Name AS Category

FROM adwentureworks_db.product AS p 

INNER JOIN adwentureworks_db.productsubcategory AS ps
ON p.ProductSubcategoryId = ps.ProductSubcategoryId

INNER JOIN adwentureworks_db.productcategory AS pc
ON ps.ProductCategoryID = pc.ProductCategoryID

WHERE p.ListPrice > 2000 AND p.SellEndDate IS NULL

ORDER BY p.ListPrice DESC;

/* 2. Reviewing work orders */
/* 2.1 */
SELECT DISTINCT 
    LocationID, 
    COUNT(WorkOrderID) no_work_orders, 
    COUNT(ProductID) no_unique_product, 
    SUM(ActualCost) actual_cost

FROM adwentureworks_db.workorderrouting

WHERE ActualStartDate BETWEEN '2004-01-01' AND '2004-02-01'

GROUP BY LocationID;


/* 2.2 */
SELECT DISTINCT 
    wor.LocationID, 
    loc.Name location, 
    COUNT(wor.WorkOrderID) no_work_orders, 
    COUNT(wor.ProductID) no_unique_product, 
    SUM(wor.ActualCost) actual_cost, 
    AVG(DATE_DIFF(wor.ActualEndDate, wor.ActualStartDate, day)) avg_days_diff

FROM adwentureworks_db.workorderrouting wor

INNER JOIN adwentureworks_db.location loc
ON wor.LocationID = loc.LocationID

WHERE ActualStartDate BETWEEN '2004-01-01' AND '2004-02-01'

GROUP BY wor.LocationID, location;


/* 2.3 */
SELECT 
    WorkOrderID, 
    ActualCost

FROM adwentureworks_db.workorderrouting

WHERE ActualCost > 300 AND (ActualStartDate BETWEEN '2004-01-01' AND '2004-02-01');


/* 3. Query validation */
/* 3.1 */
SELECT sales_detail.SalesOrderId
      ,sales_detail.OrderQty
      ,sales_detail.UnitPrice
      ,sales_detail.LineTotal
      ,sales_detail.ProductId
      ,sales_detail.SpecialOfferID
      ,spec_offer.ModifiedDate
      ,spec_offer.Category
      ,spec_offer.Description

FROM `tc-da-1.adwentureworks_db.salesorderdetail`  as sales_detail

inner join `tc-da-1.adwentureworks_db.specialoffer` as spec_offer
on sales_detail.SpecialOfferID = spec_offer.SpecialOfferID

order by LineTotal desc;


/* 3.2 */
SELECT 
    v.VendorId as Id,
    vc.ContactId, 
    vc.ContactTypeId, 
    v.Name, 
    v.CreditRating, 
    v.ActiveFlag, 
    va.AddressId,
    a.City

FROM tc-da-1.adwentureworks_db.Vendor as v

left join tc-da-1.adwentureworks_db.vendorcontact as vc 
on v.VendorId = vc.VendorId 

left join tc-da1.adwentureworks_db.vendoraddress as va 
on v.VendorId = va.VendorId

left join c-da-1.adwentureworks_db.address as a 
on va.AddressID = a.AddressID