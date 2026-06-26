-- Part A: GROUP BY Queries
-- Q1: Total orders per region
SELECT region,
    COUNT(*) AS orders
FROM sales
GROUP BY region
ORDER BY orders DESC;
-- Result: NCR 67, Mindanao 27, Visayas 19, Luzon 7
-- Q2: Total revenue per category (use SUM(total)), sorted descending
SELECT category,
    SUM(total) AS total_revenue
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;
-- Result: Electronics 1289500.0, Accessories 235650.0, Storage 42520.0
-- Q3: Monthly revenue: group by substr(order_date, 1, 7) and sum total
SELECT substr(order_date, 1, 7) AS month,
    SUM(total) AS monthly_revenue
FROM sales
GROUP BY substr(order_date, 1, 7);
-- Result: 2025-01 138120.0, 2025-02 81910.0, 2025-03 265660.0, 2025-04 9130.0, 2025-05 256930.0, 2025-06 125030.0, 2025-07 111900.0, 2025-08 454840.0, 2025-09 346130.0, 2025-10 155330.0, 2025-11 104920.0, 2025-12 192600.0
-- Q4: Average order value per region, rounded to 0 decimals
SELECT region,
    ROUND(AVG(total), 0) AS avg_order_value
FROM sales
GROUP BY region;
-- Result: Luzon 11790.0, Mindanao 14637.0, NCR 22161.0, Visayas 14736.0
-- Q5: For each product, the total units sold (SUM(quantity)) and total revenue. Sort by revenue desc.
SELECT product,
    SUM(quantity) AS total_units_sold,
    SUM(total) AS total_revenue
FROM sales
GROUP BY product
ORDER BY total_revenue DESC;
-- Result: Laptop Lenovo 24 (units) 840000.0, Desktop PC Ryzen 5 8 (units) 336000.0, Monitor 24-inch 19 (units) 237500.0, Tablet Samsung 24 (units) 432000.0, Keyboard Mechanical 15 (units) 37500.0, Headset HyperX 15 (units) 57000.0, Printer Canon 16 (units) 136000.0, External SSD 500GB 20 (units) 64000.0, Mouse Pad XL 24 (units) 10800.0, Laptop Stand 10 (units) 15000.0, USB Flash Drive 64GB 20 (units) 7600.0, USB-C Hub 8 (units) 9600.0, Wireless Mouse 22 (units) 18700.0, Webcam HD 17 (units) 30600.0, SD Card 128GB 12 (Units) 10200.0 
-- Q6: Count of orders per quantity value (1, 2, 3, 4, 5). This is a frequency distribution.
SELECT quantity,
    COUNT(order_id) AS order_count
FROM sales
GROUP BY quantity;
-- Result: 1 49, 2 34, 3 16, 4 13, 5 8
-- Q7: Top 5 customers by total spend
SELECT customer_name,
    SUM(total) AS total_spend
FROM sales
GROUP BY customer_id,
    customer_name
ORDER BY total_spend DESC
LIMIT 5;
-- Result: Patricia Lim 299600.0, Carlos Garcia 235980.0, Sofia Mendoza 307190.0, Nicole Ramos 200330.0, Grace Domingo 168390.0
-- Q8: Number of distinct customers per region
SELECT region,
    COUNT(DISTINCT customer_id) AS distinct_customers
FROM sales
GROUP BY region;
-- Result: Luzon 1, Mindanao 4, NCR 11, Visayas 4
--    Part B: HAVING & Subqueries 
-- Q9: Customers who placed 8 or more orders. (HAVING)
SELECT customer_name,
    COUNT(order_id) AS total_orders
FROM sales
GROUP BY customer_id,
    customer_name
HAVING COUNT(order_id) >= 8;
-- Result: Carlos Garcia 10, Joy Bautista 8, Kenneth Sy 8, Grace Domingo 14, Leo Pascual 10
-- Q10: Products that sold MORE than 50 total units. (HAVING)
SELECT product,
    SUM(quantity) AS total_units_sold
FROM sales
GROUP BY product
HAVING SUM(quantity) > 50;
-- Result: [No rows returned. Max units sold for any single product in this dataset is 19 for Headset HyperX.]
-- Q11: Customers whose total spend is above the average customer spend. (Subquery)
SELECT customer_name,
    SUM(total) AS total_spend
FROM sales
GROUP BY customer_id,
    customer_name
HAVING SUM(total) > (
        SELECT AVG(customer_total_spend)
        FROM (
                SELECT SUM(total) AS customer_total_spend
                FROM sales
                GROUP BY customer_id
            )
    );
-- Result: Carlos Garcia 235980.0, Grace Domingo 168390.0, Joy Bautista 124800.0, Leo Pascual 128700.0, Miguel Torres 144750.0, Nicole Ramos 200330.0, Patricia Lim 299600.0, Roberto Flores 127900.0, Sofia Mendoza 307190.0
-- Part B: HAVING & Subqueries
-- Q12: Run EXPLAIN QUERY PLAN on Q3 from Part A. Paste the result as a comment. (2 pts)
EXPLAIN QUERY PLAN
SELECT substr(order_date, 1, 7) AS month,
    SUM(total) AS monthly_revenue
FROM sales
GROUP BY substr(order_date, 1, 7);
-- Resulting Query Plan:
-- SCAN sales
-- USE TEMP B-TREE FOR GROUP BY
-- Q13: Create an index on the order_date column: `CREATE INDEX idx_sales_date ON sales(order_date);`. Then re-run Q3. Note any difference. (2 pts)
CREATE INDEX idx_sales_date ON sales(order_date);
EXPLAIN QUERY PLAN
SELECT substr(order_date, 1, 7) AS month,
    SUM(total) AS monthly_revenue
FROM sales
GROUP BY substr(order_date, 1, 7);
-- Resulting Query Plan after Index:
-- SCAN sales
-- USE TEMP B-TREE FOR GROUP BY
-- Note: The query plan does not change. Because Q3 groups rows using a function expression (substr(order_date, 1, 7)) rather than the raw column values, SQLite cannot utilize the standard B-Tree index on raw order_date values and must still fall back on a full table scan and a temporary memory B-Tree structure.