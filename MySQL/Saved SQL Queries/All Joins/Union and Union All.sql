-- ====================================================================
-- MySQL UNION Lecture - Complete SQL Script
-- ====================================================================

-- Introduction to UNION and UNION ALL
-- ====================================================================
-- UNION allows us to combine result sets from multiple SELECT queries into a single result set
-- Key points:
-- - Combines rows from multiple queries into a single result set
-- - Appends rows vertically (stacks them on top of each other)
-- - Requires that all queries have the same number of columns
-- - Column data types must be compatible across all queries
-- - Eliminates duplicate rows by default (use UNION ALL to keep duplicates)
-- - Uses the column names from the first SELECT statement for the final result set
-- - Ignores column names from subsequent queries

-- Database Setup
-- ====================================================================
CREATE DATABASE union_demo;
USE union_demo;

-- Create tables for our demonstration
CREATE TABLE headquarters_employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE branch_employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    signup_date DATE,
    status VARCHAR(20)
);

-- Sample Data
-- ====================================================================
-- Insert data into headquarters_employees
INSERT INTO headquarters_employees VALUES
(101, 'John', 'Smith', 'john.smith@company.com', '2018-03-15', 'IT', 75000.00),
(102, 'Mary', 'Johnson', 'mary.johnson@company.com', '2019-06-22', 'HR', 65000.00),
(103, 'Robert', 'Williams', 'robert.williams@company.com', '2017-11-08', 'Finance', 82000.00),
(104, 'Susan', 'Brown', 'susan.brown@company.com', '2020-01-30', 'Marketing', 68000.00),
(105, 'Michael', 'Davis', 'michael.davis@company.com', '2018-09-12', 'IT', 78000.00);

-- Insert data into branch_employees
INSERT INTO branch_employees VALUES
(201, 'James', 'Wilson', 'james.wilson@company.com', '2019-04-18', 'Sales', 62000.00),
(202, 'Patricia', 'Moore', 'patricia.moore@company.com', '2020-07-25', 'Marketing', 59000.00),
(203, 'Linda', 'Taylor', 'linda.taylor@company.com', '2018-08-15', 'HR', 61000.00),
(204, 'Robert', 'Williams', 'robert.williams@company.com', '2017-11-08', 'Finance', 82000.00), -- Duplicate employee who works at both locations
(205, 'Elizabeth', 'Anderson', 'elizabeth.anderson@company.com', '2019-12-03', 'Sales', 64000.00);

-- Insert data into customers
INSERT INTO customers VALUES
(1001, 'David', 'Miller', 'david.miller@email.com', '2019-02-14', 'Active'),
(1002, 'Sarah', 'Wilson', 'sarah.wilson@email.com', '2020-05-20', 'Active'),
(1003, 'Michael', 'Davis', 'michael.davis@email.com', '2018-11-30', 'Inactive'), -- Same name as an employee
(1004, 'Jennifer', 'Garcia', 'jennifer.garcia@email.com', '2021-01-05', 'Active'),
(1005, 'Robert', 'Martinez', 'robert.martinez@email.com', '2019-08-22', 'Active');

-- View table data
-- ====================================================================
SELECT * FROM headquarters_employees;
SELECT * FROM branch_employees;
SELECT * FROM customers;


-- Union remove the duplicate from the both union tables only if every column is same
select * from headquarters_employees
union 
select * from branch_employees;

-- Basic UNION Examples
-- ====================================================================
-- Example 1: UNION vs UNION ALL
-- Get a list of all employees from both locations (without duplicates)
select first_name, last_name, email from headquarters_employees
union 
select first_name, last_name, email from branch_employees;

-- Get a list of all employees from both locations (with duplicates)
select first_name, last_name, email from headquarters_employees
union all
select first_name, last_name, email from branch_employees;

-- combine employee and customer contact information
select first_name, last_name, email, 'Employee' as contact_type from headquarters_employees
union
select first_name, last_name, email, 'Customer' as contact_type from customers;

-- get all employ sorted by last name
select employee_id, first_name, last_name, department from headquarters_employees
union
select employee_id, first_name, last_name, department from branch_employees
order by last_name;

-- filtering 
select employee_id, first_name, last_name, department, salary from headquarters_employees
where salary > 70000
union
select employee_id, first_name, last_name, department, salary from branch_employees
where salary > 70000
order by salary;

-- union of two different no of columns tables
select employee_id, first_name, last_name, department, salary, null as status from headquarters_employees
union
select customer_id, first_name, last_name, null, null, status from customers
order by first_name , last_name;

-- find all departments in headquaters and branch office
select department
from branch_employees
union
select department from headquarters_employees;

-- find all the common departments in headquaters and branch offices
select department, count(department) as total from (select distinct department
from branch_employees
union all
select distinct department from headquarters_employees) as Combined
group by department having total = 2;