# Simple Queries(SELECT,WHERE,ORDER BY,GROUP BY)
-- List all customers from Texas
SELECT * FROM customers
WHERE state = 'Texas';

-- Get all products cheaper than $500, ordered by price ascending
SELECT * FROM products
WHERE price < 500
ORDER BY price ASC;

-- Count the number of orders placed by each customer
SELECT customer_id, COUNT(order_id) AS number_of_orders
FROM orders
GROUP BY customer_id;


# JOINS (INNER JOIN, LEFT JOIN, RIGHT JOIN)
-- List all orders with customer name (INNER JOIN)
SELECT o.order_id, o.order_date, c.first_name, c.last_name
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- List all customers and their orders (LEFT JOIN)
SELECT c.first_name, c.last_name, o.order_id, o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- List all orders and the products (JOIN through order_items)
SELECT o.order_id, p.product_name, oi.quantity
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id;


# Subqueries
-- Find customers who have placed orders above $2000
SELECT first_name, last_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE order_total > 2000
);


# Aggregate Functions (SUM, AVG)
-- Calculate total revenue from all orders
SELECT SUM(order_total) AS total_revenue
FROM orders;

-- Find the average price of all products
SELECT AVG(price) AS average_price
FROM products;


# Views
-- Create a view showing customer order summary
CREATE VIEW customer_order_summary AS
SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS total_orders, SUM(o.order_total) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;


# Indexes (Optimization)
-- Create an index on customer_id in orders table
CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

-- Create an index on product_id in order_items table
CREATE INDEX idx_order_items_product_id
ON order_items(product_id);

