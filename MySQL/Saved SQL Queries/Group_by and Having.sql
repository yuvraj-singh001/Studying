-- GROUP BY Examples in SQL
-- =============================================
-- This file demonstrates various examples of using GROUP BY in SQL queries
-- for data summarization and aggregation operations.

-- Database Setup
-- =============================================
CREATE DATABASE db_for_group_by;
USE db_for_group_by;

-- Table Creation
-- =============================================
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    joining_date DATE
);

-- Initial Data Insertion
-- =============================================
INSERT INTO employees (name, department, salary, joining_date) VALUES
('Alice', 'HR', 50000, '2020-06-15'),
('Bob', 'HR', 55000, '2019-08-20'),
('Charlie', 'IT', 70000, '2018-03-25'),
('David', 'IT', 72000, '2017-07-10'),
('Eve', 'IT', 73000, '2021-02-15'),
('Frank', 'Finance', 60000, '2020-11-05'),
('Grace', 'Finance', 65000, '2019-05-30'),
('Hannah', 'Finance', 62000, '2021-01-12');

-- Additional Data Insertion
-- =============================================
INSERT INTO employees (name, department, salary, joining_date) VALUES
('Tim', 'HR', 65000, '2019-05-30'),
('Tom', 'IT', 62000, '2021-01-12');

select * from employees;

-- count employs in each department
select department, count(department) from employees group by department;

-- get avg salary per department
select department, avg(salary) from employees group by department;

-- get the highest and the lowest salary per department
select department, max(salary), min(salary) from employees group by department;

-- count employees per department and joining year
select department, year(joining_date), count(*) from employees group by department, year(joining_date);

-- order department by the highest avg salary
select department, avg(salary) from employees group by department order by avg(salary) desc;

select *,
	case
		when salary < 60000 then 'Low Salary'
        when salary between 60000 and 70000 then 'Medium Salary'
        else 'High Salary'
	end as salary_range
from employees group by salary_range; 

-- find departments with max number of employees
select department, count(*) from employees group by department order by count(*) desc limit 1;

-- find department with more than 2 employees
-- having - is used after group by to filter things
select department,count(*) as t from employees group by department having t > 2;
select department,count(*) as t from employees where joining_date > '2017-07-10' group by department having t > 2;

-- departments with more than 2 employees and having avg salary > 55000
select department,count(*) as t, avg(salary) as avg_salary from employees group by department having t > 2 && avg_salary > 55000;