-- SQL DELETE Tutorial
-- Demonstrates how to remove records from a database table
-- DELETE FROM table_name WHERE condition;

-- Create a database for our examples
CREATE DATABASE delete_tutorial;

-- Use the database
USE delete_tutorial;

-- Create a simple product inventory table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    stock_quantity INT
);

-- Insert sample data
INSERT INTO products VALUES
(1, 'Laptop', 999.99, 10),
(2, 'Smartphone', 499.99, 25),
(3, 'Headphones', 89.99, 50),
(4, 'Tablet', 349.99, 15),
(5, 'Keyboard', 59.99, 30),
(6, 'Mouse', 29.99, 45),
(7, 'Monitor', 249.99, 12),
(8, 'Printer', 179.99, 8),
(9, 'External Hard Drive', 129.99, 20),
(10, 'USB Drive', 19.99, 100);

-- Verify the data
SELECT * FROM products;

-- Deleting using delete command using conditions
Delete from products where product_id = 10;

-- With multiple conditions
delete from products where price < 50 ;

-- for all product deletion
delete from products;


-- Creating a table with a foreign key reference
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert an order
INSERT INTO orders VALUES (1, 2, 3);

-- Check the order
SELECT * FROM orders;

-- Now if we try to delete product with id 2 it throws error
delete from products where product_id = 2;

show create table orders;
-- orders_ibfk_1
-- but if we still want to delete it we do this

alter table orders drop foreign key orders_ibfk_1;	
alter table orders add constraint orders_ibfk_1
foreign key (product_id) references products(product_id)
on delete cascade;

delete from products where product_id = 2;

-- if we dont want to delect complete entry but want to add null to all fields
INSERT INTO orders VALUES (1, 3, 2);
alter table orders drop foreign key orders_ibfk_1;

alter table orders drop foreign key orders_ibfk_1;	

alter table orders add constraint orders_ibfk_1
foreign key (product_id) references products(product_id)
on delete set null;

delete from products where product_id = 3;

-- Auto-increment behavior with DELETE
CREATE TABLE auto_example (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

-- Insert some data
INSERT INTO auto_example (name) VALUES ('Item 1'), ('Item 2'), ('Item 3');

-- Delete all records
DELETE FROM auto_example;

-- Insert a new record (notice the ID continues from previous sequence) auto increment counter dosen't reset after deleting
INSERT INTO auto_example (name) VALUES ('New Item');

-- Check the result
SELECT * FROM auto_example;

-- TRUNCATE TABLE demonstration
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2)
);

-- Insert some employee data
INSERT INTO employees (name, email, hire_date, salary) VALUES
('John Doe', 'john.doe@example.com', '2023-01-15', 65000.00),
('Jane Smith', 'jane.smith@example.com', '2023-02-20', 72000.00),
('Michael Brown', 'michael.brown@example.com', '2023-03-10', 58000.00);

-- Check the employee data
SELECT * FROM employees;

-- Remove all employees using TRUNCATE (faster than DELETE)
TRUNCATE TABLE employees;
-- Alternative syntax: TRUNCATE employees;

-- Check the result (empty table)
SELECT * FROM employees;

-- For comparison, DELETE can also remove all rows
DELETE FROM employees;

-- Key differences between TRUNCATE and DELETE:
-- Speed: TRUNCATE is generally faster because it drops and recreates the table rather than removing rows one by one.
-- Logging: DELETE logs individual row removals, while TRUNCATE only logs table deallocation.
-- WHERE clause: DELETE supports WHERE conditions to remove specific rows, while TRUNCATE always removes all rows.
-- Auto-increment: TRUNCATE resets auto-increment counters to their initial value, while DELETE preserves the current counter value.
-- Triggers: DELETE activates DELETE triggers, while TRUNCATE does not fire any triggers.
-- Rollback: DELETE operations can be rolled back in a transaction, while TRUNCATE generally cannot
-- SQL Categories: TRUNCATE is a DDL (Data Definition Language) command, DELETE is a DML (Data Manipulation Language) command