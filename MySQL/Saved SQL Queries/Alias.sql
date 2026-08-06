-- MySQL Aliases Tutorial
-- Aliases are temporary names assigned to database tables, columns, or expressions 
-- to make them more readable and manageable.

-- Create and use the database
CREATE DATABASE db16;
USE db16;

-- Create employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

-- Insert initial employee data
INSERT INTO employees VALUES
    (1, 'John', 'Doe', 60000.00, '2020-01-15'),
    (2, 'Jane', 'Smith', 65000.00, '2019-11-20'),
    (3, 'Mike', 'Johnson', 55000.00, '2021-03-10');

-- View all employees
SELECT * FROM employees;

# column alias
select emp_id as id from employees;  #we can do it without as
select salary, salary*1.1 as newSalary from employees;
select concat(first_name, " ", last_name) as full_name from employees;

 -- Create departments table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

-- Insert department data
INSERT INTO departments VALUES
    (1, 'Engineering', 'New York'),
    (2, 'Marketing', 'Los Angeles'),
    (3, 'Finance', 'Chicago');

alter table employees add column department_id INT; 

#alias for table name
select e.emp_id, e.salary from employees e;
select * from employees e join departments d on e.department_id = d.dept_id;  #alias are e,d

#alias with functions
select avg(salary) as avg_salary from employees;
select avg_salary.average_salary from (select avg(salary) as average_salary from employees)as avg_salary;