
/*
 * PRIMARY KEYS IN SQL
 * This script demonstrates the concepts and best practices for using primary keys in database design
 */

-- Primary Keys - Key Benefits:
-- They uniquely identify each record in a table
-- They ensure no duplicate records exist
-- They provide a reference point for relationships between tables
-- They optimize database performance for record retrieval

-- SECTION 1: Basic Primary Key Implementation
-- Creating a table with a simple primary key
create database student_db;
use student_db;
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100)
);

-- Inserting records with valid primary keys
INSERT INTO students (student_id, first_name, last_name, email)
VALUES 
(1, 'John', 'Smith', 'john.smith@example.com'),
(2, 'Maria', 'Garcia', 'maria.garcia@example.com'),
(3, 'Ahmed', 'Khan', 'ahmed.khan@example.com');

-- Demonstrating primary key constraint - This will fail
INSERT INTO students (student_id, first_name, last_name, email)
VALUES (1, 'Jane', 'Doe', 'jane.doe@example.com');
-- Error Code: 1062. Duplicate entry '1' for key 'PRIMARY'


-- SECTION 2: Auto-increment Primary Keys
-- Creating a table with an auto-increment primary key
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT
);

-- With auto-increment, we don't need to specify the primary key value
INSERT INTO products (product_name, price, description)
VALUES 
('Laptop', 1299.99, 'High-performance laptop'),
('Smartphone', 799.99, 'Latest model smartphone'),
('Headphones', 199.99, 'Noise-cancelling headphones');

-- View the auto-generated IDs
SELECT * FROM products;

-- writing primary key at the end
create table orders(
	order_id Int,
    customer_id int,
    order_date Date not null,
    total_amount Decimal(10,2) not null,
    primary key (order_id)
);


-- Create table without primary key
CREATE TABLE suppliers (
    supplier_id INT,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100)
);

-- Adding primary key afterwards
alter table suppliers add primary key (supplier_id);

-- composite primary key- primary key formed by multiple columns
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    grade VARCHAR(2),
    PRIMARY KEY (student_id, course_id)
);

-- Insert records with unique combinations of the composite key
INSERT INTO enrollments (student_id, course_id, enrollment_date, grade)
VALUES 
(1, 101, '2023-01-15', 'A'),
(1, 102, '2023-01-15', 'B+'),  -- Same student, different course - OK
(2, 101, '2023-01-16', 'A-'),  -- Different student, same course - OK
(3, 103, '2023-01-17', 'B');

-- This will fail - duplicate composite key (student_id + course_id)
INSERT INTO enrollments (student_id, course_id, enrollment_date, grade)
VALUES (1, 101, '2023-02-01', 'C');
-- Error: Duplicate entry '1-101' for key 'PRIMARY'

-- Primary Key Best Practices:
-- 1. Always include a primary key in every table
-- 2. Use auto-increment unless you have a specific reason not to
-- 3. Keep primary keys simple - use INT or BIGINT for numeric IDs