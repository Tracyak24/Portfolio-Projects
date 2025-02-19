-- Total Number Of Listings

SELECT COUNT(*) AS total_listings
FROM homes_for_sale_and_real_estate;


-- Average Pricing Of All Listings

SELECT AVG(Price) AS average_pricing
FROM homes_for_sale_and_real_estate;


-- Location With The Highest Number Of Listings

SELECT 
    Place, 
    COUNT(*) AS total_listings
FROM 
    homes_for_sale_and_real_estate
GROUP BY 
    Place
ORDER BY 
    total_listings DESC
LIMIT 1;


-- Properties Priced Below The Average Price

SELECT
    Address,
    Price,
    Beds,
    Bath,
    `Sq.Ft`
FROM
  homes_for_sale_and_real_estate
WHERE 
   Price <(SELECT AVG(Price) FROM homes_for_sale_and_real_estate);
   
   
-- Total Number Of Listing & Average Price Of Listing Per Location
-- Shows Result Of The Location With The Lowest Average Price

SELECT 
    Place, 
    COUNT(*) AS total_listings, 
    ROUND(AVG(Price), 0) AS average_price
FROM 
    homes_for_sale_and_real_estate
GROUP BY 
    Place
ORDER BY
     average_price ASC
LIMIT 1;


-- Feature-Based Search
-- Shows Listings That Have At Least 3 Bedrooms, 2 Bathrooms, And A Price Below $500,000

SELECT
    Address, 
    Price, 
    Beds, 
    Bath, 
    `Sq.Ft`
FROM 
   homes_for_sale_and_real_estate
WHERE
   Beds >= 3 AND
   Bath >= 2 AND
   Price < 500000
ORDER BY 
      Price ASC;
      
      
-- High-Value Properties
-- Shows Listing Priced Above $1,000,000

SELECT
    Address,
    Price,
    Beds,
    Bath,
    `Sq.ft`
FROM
   homes_for_sale_and_real_estate
WHERE
    Price > 1000000;
    
    
-- Top 5 Most Expensive Listings

SELECT
    Address,
    Price,
    Beds,
    Bath,
    `Sq.Ft`
FROM
   homes_for_sale_and_real_estate
ORDER BY
     Price DESC
LIMIT 5;


-- Average Bedrooms and Bathrooms by Location

SELECT
    Place,
    ROUND(AVG(Beds), 0) AS average_beds,
    ROUND(AVG(Bath), 1) AS average_bath
FROM
   homes_for_sale_and_real_estate
GROUP BY
      Place;
      
 
-- Properties Priced Between $300,000 and $600,000 
 
SELECT
    Address,
    Price,
    Beds,
    Bath,
    `Sq.Ft`
FROM
   homes_for_sale_and_real_estate
WHERE
    Price BETWEEN 300000 AND 600000;
    
    
-- Total Square Footage by Location

SELECT
    Place,
    SUM(`Sq.Ft`)
FROM 
   homes_for_sale_and_real_estate
GROUP BY
      Place;
      
      
-- Properties Without Bedrooms or Bathrooms

SELECT
    Address,
    Price,
    Beds,
    Bath,
    `Sq.Ft`
FROM
   homes_for_sale_and_real_estate
WHERE
   Beds = 0 OR
   Bath = 0;
   
   
-- Price by Square Footage

SELECT
    Address, 
    Price, 
    `Sq.Ft`, 
    ROUND((Price / `Sq.Ft`), 2) AS Price_Per_SqFt
FROM
   homes_for_sale_and_real_estate;
   
   
-- Custom Search Query
-- Finds Properties Based on User Criteria

SELECT
    Address,
    Place,
    Price,
    `Sq.Ft`
FROM
   homes_for_sale_and_real_estate
WHERE
    Beds >= 3 AND
    Bath >= 2 AND
    Price <= 500000;
    
 
-- Comparing Luxury and Affordable Markets
 
SELECT
    CASE
       WHEN Price > 1000000 THEN 'Luxury'
       ELSE 'Affordable'
    END AS Market_Category,
    ROUND(AVG(Beds), 0) AS Average_Beds,
    ROUND(AVG(Bath), 1) AS Average_Bath
FROM
   homes_for_sale_and_real_estate
GROUP BY 
      Market_Category;
      
      
-- Correlation Between Size and Price

SELECT 
    CASE
        WHEN `Sq.Ft` <= 1000 THEN '0–1000 Sq.Ft'
        WHEN `Sq.Ft` BETWEEN 1001 AND 2000 THEN '1001–2000 Sq.Ft'
        WHEN `Sq.Ft` BETWEEN 2001 AND 3000 THEN '2001–3000 Sq.Ft'
        WHEN `Sq.Ft` BETWEEN 3001 AND 4000 THEN '3001–4000 Sq.Ft'
        ELSE '4001+ Sq.Ft'
    END AS Size_Range,
    ROUND(AVG(Price), 0) AS Average_Price
FROM 
    homes_for_sale_and_real_estate
GROUP BY 
    Size_Range
ORDER BY 
    Average_Price DESC;
