-- MySQL DISTINCT Tutorial
-- The DISTINCT clause eliminates duplicate rows from the result set
-- Syntax: SELECT DISTINCT column1, column2 FROM table_name;

-- Create and use the database
CREATE DATABASE EmployeeDB;
USE EmployeeDB;

-- Create employees table
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

-- Insert sample data including duplicates
INSERT INTO employees (name, department, salary) VALUES
    ('Alice', 'HR', 50000),
    ('Bob', 'Finance', 60000),
    ('Charlie', 'IT', 70000),
    ('Alice', 'HR', 50000),      -- Duplicate record
    ('David', 'Finance', 55000),
    ('Eve', 'IT', 70000),        -- Duplicate salary
    ('Frank', 'HR', 50000);      -- Duplicate department & salary

-- View all employees
                                                SELECT * FROM employees;

-- For unique data
select distinct department from employees;

-- For unique combination of columns
select distinct department , salary from employees;
select count(distinct department) as unique_departments from employees;

-- get distinct salary values started in descending order
select distinct salary from employees order by salary desc;

select distinct name, department from employees;

-- Using Distinct with functions
select distinct concat(name,"-" , department) from employees;

-- how to handle null values
INSERT INTO employees (name, department, salary) VALUES 
    ('Grace', NULL, 48000),
    ('Bobby', NULL, 48000);