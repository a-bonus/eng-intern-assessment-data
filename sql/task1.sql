-- Problem 1: Retrieve all products in the Sports category
-- Write an SQL query to retrieve all products in a specific category.

-- Solution 1: 
-- We are retreiving all products and their details from the 'Products' table
-- that belong to the 'Sports & Outdoors' category, since 'Sports' is not a category. 

SELECT p.* 
FROM Products p 
JOIN Categories c ON p.category_id = c.category_id 
WHERE c.category_name = 'Sports & Outdoors';


-- Problem 2: Retrieve the total number of orders for each user
-- Write an SQL query to retrieve the total number of orders for each user.
-- The result should include the user ID, username, and the total number of orders.

-- Solution 2: 
-- Since the required output involves data from both users and their orders, 
-- a JOIN operation is necessary. I chose a LEFT JOIN to ensure that all users 
-- are included in the result set, even those without any orders.
-- To count the orders per user, an aggregation function (COUNT) is necessary.
-- Since we're aggregating orders for each user, 
-- a GROUP BY clause is needed to group the data by user_id.

SELECT 
    u.user_id, 
    u.username, 
    COUNT(o.order_id) AS total_orders
FROM 
    Users u
LEFT JOIN 
    Orders o ON u.user_id = o.user_id
GROUP BY 
    u.user_id;


-- Problem 3: Retrieve the average rating for each product
-- Write an SQL query to retrieve the average rating for each product.
-- The result should include the product ID, product name, and the average rating.

-- Solution 3:
-- The query must join Products with Reviews to correlate products with their ratings.
-- Calculating Average Rating: Use the AVG function to compute the average rating.
-- Group the results by product_id to ensure the average rating is calculated for each unique product.
-- Inner join is chosen because we are interested in products that have received reviews.

SELECT 
    p.product_id, 
    p.product_name, 
    AVG(r.rating) AS average_rating
FROM 
    Products p
INNER JOIN 
    Reviews r ON p.product_id = r.product_id
GROUP BY 
    p.product_id;


-- Problem 4: Retrieve the top 5 users with the highest total amount spent on orders
-- Write an SQL query to retrieve the top 5 users with the highest total amount spent on orders.
-- The result should include the user ID, username, and the total amount spent.

-- Solution 4: 
-- This query retrieves the necessary data by performing an INNER JOIN between `Users` and `Orders`, ensuring we consider only users with orders.
-- The SUM function aggregates the total amount spent by each user. 
-- GROUP BY clause is essential to ensure that the sum is calculated for each unique user.
-- ORDER BY combined with LIMIT selects the top 5 users with the highest spending, providing a focused and relevant result set.

SELECT 
    u.user_id, 
    u.username, 
    SUM(o.total_amount) AS total_spent
FROM 
    Users u
INNER JOIN 
    Orders o ON u.user_id = o.user_id
GROUP BY 
    u.user_id
ORDER BY 
    total_spent DESC
LIMIT 5;
