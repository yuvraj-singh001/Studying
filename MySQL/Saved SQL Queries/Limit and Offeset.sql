-- =============================================
-- MySQL LIMIT Clause Lecture
-- =============================================

-- 1. Setup and Sample Data

CREATE DATABASE db13;
USE db13;
-- Create products table
CREATE TABLE products (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100),
price DECIMAL(10,2),
category VARCHAR(50),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Insert sample data
INSERT INTO products (name, price, category) VALUES
('Laptop', 999.99, 'Electronics'),
('Smartphone', 499.99, 'Electronics'),
('Coffee Maker', 79.99, 'Appliances'),
('Headphones', 149.99, 'Electronics'),
('Blender', 59.99, 'Appliances'),
('Tablet', 299.99, 'Electronics'),
('Microwave', 199.99, 'Appliances'),
('Smart Watch', 249.99, 'Electronics'),
('Toaster', 39.99, 'Appliances'),
('Speaker', 89.99, 'Electronics');

-- 2. Basic LIMIT Usage
select * from products;

#Limit clause is used to control the number of records returned by a query 
select * from products order by id limit 2;

#pagination - next 10 records in next query and so on and it is done by using "offset"
select * from products order by id limit 2 offset 2;

#EX - page size :3 items per page
select * from products order by id limit 3 offset 0;
select * from products order by id limit 3 offset 3;
select * from products order by id limit 3 offset 6;

select * from products order by id desc limit 0,3;  #offset , limit respectivly
select * from products order by id limit 3,3;
select * from products order by id limit 6, 3;

#Generic Formula for Pagination
-- Limit (page_number-1) * items_per_page, Items_per_page

#Limit with functions
select * from products order by rand() limit 5; # rand() for random order of items(inefficient)
