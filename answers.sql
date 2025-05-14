-- Question 1
CREATE TEMPORARY TABLE temp_product_details AS
SELECT
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(Products, ',', n)) AS Product  -- Trim leading/trailing spaces
FROM ProductDetail
CROSS JOIN (
    SELECT 1 AS n UNION ALL
    SELECT 2 UNION ALL
    SELECT 3 UNION ALL
    SELECT 4  -- Assuming a maximum of 4 products, adjust as needed.
) AS numbers
WHERE n <= LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) + 1;  -- Corrected the count

-- The above query will split the products column into separate rows

SELECT * from temp_product_details;
-- Drop the temporary table
DROP TEMPORARY TABLE temp_product_details;

--Question 2
-- Create the orders_products table
CREATE TEMPORARY TABLE orders_products AS
SELECT
    OrderID,
    Product,
    Quantity
FROM OrderDetails;

-- Create the customers table
CREATE TEMPORARY TABLE customers AS
SELECT DISTINCT
    OrderID,
    CustomerName
FROM OrderDetails;

-- Select from orders_products
SELECT * from orders_products;
-- Select from customers
SELECT * from customers;

-- Drop the temporary tables
DROP TEMPORARY TABLE orders_products;
DROP TEMPORARY TABLE customers;