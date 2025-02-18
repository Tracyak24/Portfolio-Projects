-- Join All Columns From Products and Stores

SELECT
    p.*,
    s.*
FROM
    products p
LEFT JOIN
    stores s
ON
    s.store_size >= GREATEST(p.product_length, p.product_depth, p.product_width)

UNION

SELECT
    p.*,
    s.*
FROM
    products p
RIGHT JOIN
    stores s
ON
    s.store_size >= GREATEST(p.product_length, p.product_depth, p.product_width);
    
    
-- Check for Missing Values

SELECT * FROM products WHERE product_id IS NULL;
SELECT * FROM stores WHERE store_id IS NULL;


-- Count Products by Store

SELECT store_id, COUNT(product_id) AS product_count
FROM stores s
JOIN products p ON s.store_size >= GREATEST(p.product_length, p.product_depth, p.product_width)
GROUP BY store_id;


-- KPI Calculation
-- Percentage of Products That Can Fit in Each Store

SELECT
    s.store_id,
    ROUND(COUNT(p.product_id) / (SELECT COUNT(*) FROM products) * 100, 0) AS stock_coverage_percentage
FROM
    stores s
LEFT JOIN
    products p
ON
    s.store_size >= GREATEST(p.product_length, p.product_depth, p.product_width)
GROUP BY
    s.store_id;


-- Product Diversity by City

SELECT city_id, COUNT(DISTINCT product_id) AS unique_products
FROM stores s
JOIN products p ON s.store_size >= GREATEST(p.product_length, p.product_depth, p.product_width)
GROUP BY city_id;


-- Segmentation and Categorization By Store Type

SELECT storetype_id, COUNT(product_id) AS product_count
FROM stores s
JOIN products p ON s.store_size >= GREATEST(p.product_length, p.product_depth, p.product_width)
GROUP BY storetype_id;


-- Segmentation and Categorization By Product Hierarchy

SELECT hierarchy1_id, COUNT(product_id) AS product_count
FROM products
GROUP BY hierarchy1_id;


-- Identify products that don’t fit in any store

SELECT p.product_id
FROM products p
LEFT JOIN stores s ON s.store_size >= GREATEST(p.product_length, p.product_depth, p.product_width)
WHERE s.store_id IS NULL;


-- Cities with Low Product Diversity

SELECT city_id, COUNT(DISTINCT product_id) AS product_count
FROM stores s
JOIN products p ON s.store_size >= GREATEST(p.product_length, p.product_depth, p.product_width)
GROUP BY city_id
HAVING product_count < 10;


-- Finds Products That Can Only Be Stocked in a Small Number of Stores Due to Their Size

SELECT 
    p.product_id,
    COUNT(s.store_id) AS compatible_stores
FROM 
    products p
LEFT JOIN 
    stores s
ON 
    s.store_size >= GREATEST(p.product_length, p.product_depth, p.product_width)
GROUP BY 
    p.product_id
HAVING 
    compatible_stores < 5; 


-- Determines Which Store Types Stock the Widest Range of Products

SELECT 
    s.storetype_id,
    COUNT(DISTINCT p.product_id) AS product_variety
FROM 
    stores s
JOIN 
    products p
ON 
    s.store_size >= GREATEST(p.product_length, p.product_depth, p.product_width)
GROUP BY 
    s.storetype_id
ORDER BY 
    product_variety DESC;


-- Locates Cities Where Stores Have the Smallest Range of Products Available

SELECT 
    s.city_id,
    COUNT(DISTINCT p.product_id) AS product_count
FROM 
    stores s
LEFT JOIN 
    products p
ON 
    s.store_size >= GREATEST(p.product_length, p.product_depth, p.product_width)
GROUP BY 
    s.city_id
ORDER BY 
    product_count ASC
LIMIT 10;


-- Finds Out Which Product Hierarchies (e.g., hierarchy1_id) are Most Prevalent in Specific Regions (city_id)

SELECT 
    s.city_id,
    p.hierarchy1_id,
    COUNT(p.product_id) AS product_count
FROM 
    stores s
JOIN 
    products p
ON 
    s.store_size >= GREATEST(p.product_length, p.product_depth, p.product_width)
GROUP BY 
    s.city_id, p.hierarchy1_id
ORDER BY 
    s.city_id, product_count DESC;
    

-- Calculates the Average Size of Products Stocked in Each Store and Compare it to the Store Size 

SELECT 
    s.store_id,
    s.store_size,
    ROUND(AVG(GREATEST(p.product_length, p.product_depth, p.product_width)), 2) AS avg_product_size,
    s.store_size - ROUND(AVG(GREATEST(p.product_length, p.product_depth, p.product_width)), 2) AS unused_space
FROM 
    stores s
JOIN 
    products p
ON 
    s.store_size >= GREATEST(p.product_length, p.product_depth, p.product_width)
GROUP BY 
    s.store_id
ORDER BY 
    unused_space DESC;