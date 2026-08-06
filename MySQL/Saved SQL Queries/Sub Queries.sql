-- =============================================
-- MySQL Subqueries Demonstration 
-- Online Store Database Example
-- =============================================

-- Create database and set it as the active database
CREATE DATABASE online_store;
USE online_store;

-- =============================================
-- TABLE CREATION
-- =============================================

-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(50),
    state VARCHAR(2),
    signup_date DATE
);

-- Create products table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL
);

-- Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create order_items table
CREATE TABLE order_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    item_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- =============================================
-- SAMPLE DATA INSERTION
-- =============================================

-- Insert data into customers
INSERT INTO customers (first_name, last_name, email, city, state, signup_date) VALUES
('John', 'Smith', 'john.smith@example.com', 'New York', 'NY', '2023-01-15'),
('Sarah', 'Johnson', 'sarah.j@example.com', 'Los Angeles', 'CA', '2023-02-20'),
('Michael', 'Brown', 'michael.b@example.com', 'Chicago', 'IL', '2023-03-05'),
('Emily', 'Davis', 'emily.d@example.com', 'Houston', 'TX', '2023-01-30'),
('Robert', 'Wilson', 'robert.w@example.com', 'Phoenix', 'AZ', '2023-02-10'),
('Jennifer', 'Martinez', 'jennifer.m@example.com', 'Philadelphia', 'PA', '2023-03-15'),
('David', 'Anderson', 'david.a@example.com', 'San Antonio', 'TX', '2023-01-25'),
('Lisa', 'Thomas', 'lisa.t@example.com', 'San Diego', 'CA', '2023-02-28'),
('James', 'Jackson', 'james.j@example.com', 'Dallas', 'TX', '2023-03-12'),
('Mary', 'White', 'mary.w@example.com', 'San Jose', 'CA', '2023-01-18');

-- Insert data into products
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop Pro', 'Electronics', 1299.99, 25),
('Smartphone X', 'Electronics', 899.99, 50),
('Wireless Headphones', 'Electronics', 199.99, 100),
('Coffee Maker', 'Home Appliances', 79.99, 30),
('Blender', 'Home Appliances', 49.99, 40),
('Running Shoes', 'Sports', 129.99, 75),
('Yoga Mat', 'Sports', 29.99, 120),
('Mystery Novel', 'Books', 14.99, 200),
('Cookbook', 'Books', 24.99, 150),
('Desk Chair', 'Furniture', 149.99, 15);

-- Insert data into orders
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2023-04-10 14:30:00', 1499.98),
(2, '2023-04-11 10:15:00', 249.98),
(3, '2023-04-12 16:45:00', 899.99),
(4, '2023-04-13 13:20:00', 1329.98),
(2, '2023-04-14 09:30:00', 49.99),
(5, '2023-04-15 15:10:00', 179.98),
(6, '2023-04-16 11:05:00', 159.98),
(7, '2023-04-17 14:55:00', 39.98),
(8, '2023-04-18 12:40:00', 899.99),
(9, '2023-04-19 16:25:00', 229.98),
(10, '2023-04-20 10:50:00', 279.97),
(1, '2023-04-21 13:35:00', 24.99),
(3, '2023-04-22 15:15:00', 129.99);

-- Insert data into order_items
INSERT INTO order_items (order_id, product_id, quantity, item_price) VALUES
(1, 1, 1, 1299.99),
(1, 3, 1, 199.99),
(2, 5, 1, 49.99),
(2, 7, 1, 29.99),
(2, 9, 1, 24.99),
(3, 2, 1, 899.99),
(4, 1, 1, 1299.99),
(4, 6, 1, 129.99),
(5, 5, 1, 49.99),
(6, 4, 1, 79.99),
(6, 8, 1, 14.99),
(6, 9, 1, 24.99),
(7, 6, 1, 129.99),
(7, 8, 2, 14.99),
(8, 8, 1, 14.99),
(8, 9, 1, 24.99),
(9, 2, 1, 899.99),
(10, 3, 1, 199.99),
(10, 6, 1, 129.99),
(11, 5, 1, 49.99),
(11, 7, 1, 29.99),
(11, 8, 1, 14.99),
(12, 9, 1, 24.99),
(13, 6, 1, 129.99);

-- =============================================
-- BASIC SUBQUERIES
-- =============================================

-- Find all customers who have placed at least one order
select * from customers where customer_id in (select distinct customer_id from orders);

-- find all the customers who have not placed any orders
select * from customers where customer_id not in (select distinct customer_id from orders);

-- find product with a price higher than average
select * from products where price > (select avg(price) from products);

-- find categories that have more than 2 products
select category , count(category) from products group by category having count(category) >2;

-- find all orders made by customers from texas
select * from orders where customer_id in (select customer_id from customers where state = 'TX');
-- by using join
select * 
from customers c
join orders o 
on c.customer_id = o.customer_id where c.state = 'TX';

-- find all customers who ordered electronics products
select * from customers where customer_id in (select customer_id from orders where order_id in (select order_id from order_items where product_id in (select product_id from products where category = 'Electronics')));

-- using join
select * 
from customers c
join orders o 
on c.customer_id = o.customer_id
join order_items oi 
on o.order_id = oi.order_id
join products p 
on oi.product_id = p.product_id
and p.category = 'Electronics';

-- customers who spent more than average
select *, (select sum(total_amount) from orders where customer_id = customers.customer_id) as total_amount1 from customers where (select sum(total_amount) from orders where customer_id = customers.customer_id) > (select avg(total) as average_spent from (select sum(total_amount) as total from orders group by customer_id) as ct);

-- find customers who have all products in the electronic category
select count(*) from products where category = "Electronics";

select c.email 
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id 
where p.category = "Electronics" 
group by c.customer_id
having count(distinct p.product_id) = (select count(*) from products where category = "Electronics");

-- find all customers who are not from california but have purchased the same product-quantitiy combination as california customers
select oi.product_id, oi.quantity from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on oi.order_id = o.order_id
where c.state = 'CA';

select c.email, c.state, p.product_name, oi.quantity from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on oi.order_id = o.order_id
join products p on p.product_id = oi.product_id
where c.state = 'CA' and (oi.product_id, oi.quantity) in
(select oi.product_id, oi.quantity from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on oi.order_id = o.order_id
where c.state = 'CA');


-- =============================================
-- CORRELATED SUBQUERIES AND EXISTS
-- =============================================

-- Correlated Subqueries
-- A correlated subquery is a subquery that uses values from the outer query. 
-- Unlike regular subqueries which can be executed independently, correlated subqueries are dependent on the outer query and
-- must be re-evaluated for each row processed by the outer query.
-- Can Appear in Various SQL Clauses (SELECT / WHERE / HAVING)

-- Scalar subquery
-- Always Returns Exactly One Value
-- Can Be Independent or Correlated
-- Can Appear in Various SQL Clauses (SELECT / WHERE / HAVING)

-- Find customers who have placed at least one order
-- Using JOIN
select * from customers c join orders o on c.customer_id = o.customer_id;

-- Using Subquery
select * from customers c where exists (select * from orders o where c.customer_id = o.customer_id);

-- Find the customers who have not placed and orders
select * from customers c where not exists(select * from orders o where c.customer_id = o.customer_id);

-- Products that have never been ordered
select * from products p where not exists(select * from order_items oi where oi.product_id = p.product_id);

-- Find customers who have ordered electronics products
select * from customers c where exists
(
select * from orders o join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
where c.customer_id = o.customer_id and p.category = "Electronics"
);