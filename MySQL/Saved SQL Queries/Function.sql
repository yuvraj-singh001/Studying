
-- =============================================
-- SQL FUNCTIONS DEMO SCRIPT
-- A comprehensive demonstration of various SQL functions
-- =============================================

-- =================
-- STRING FUNCTIONS
-- =================

-- Create and use database for string function examples
CREATE DATABASE StringFunctionsDB;
USE StringFunctionsDB;

-- Create employees table for string function demonstrations
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    department VARCHAR(50)
);

-- Insert sample employee data
INSERT INTO employees (first_name, last_name, email, department) VALUES
('John', 'Doe', 'john.doe@example.com', 'Marketing'),
('Jane', 'Smith', 'jane.smith@example.com', 'Sales'),
('Michael', 'Johnson', 'michael.johnson@example.com', 'IT'),
('Emily', 'Davis', 'emily.davis@example.com', 'HR'),
('Chris', 'Brown', 'chris.brown@example.com', 'Finance');

select * from employees;

-- Concat
select concat(first_name,' ', last_name) as full_name from employees;

-- Length
select first_name, length(first_name) as len from employees;
select first_name, char_length(first_name) as len from employees;
select first_name, upper(first_name), lower(first_name) as len from employees;
select upper('ok');

-- Trim- remove space
select upper('      ok        ');
select trim(upper('       ok      '));

-- Substring
select first_name, substring(first_name,1,3) as first3 from employees;

-- Indexof
select first_name, locate('a', first_name) as location_of_a from employees;
select first_name, locate('ch', first_name) as position_of_ch from employees;

-- Replace - something from string
select first_name, replace(email, 'example.com', 'amazon.com') from employees;

-- Reverse
select first_name, reverse(first_name) from employees;

-- left and right - to extract letters from left and right
select first_name, left(first_name, 2) as first2, right(first_name, 2) as last2 from employees;

-- ascii - to find it
select ascii('a');
select ascii('afasjd'); -- still it gives only ascii for the first 

-- field  - its from previous lecture
select * from products order by field (category, 'Electronics' , 'AppLiances', 'furniture');

-- soundex - give same 4 len string for same sounding words(only best for english)
select soundex('smith');
select soundex('smithi');
select first_name, soundex(first_name) from employees;
select * from employees where soundex('jane') = soundex(first_name);


-- =================
-- Numeric FUNCTIONS
-- =================

CREATE DATABASE NumericFunctionsDB;
USE NumericFunctionsDB;

CREATE TABLE numbers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    num_value DECIMAL(10,5)
);

INSERT INTO numbers (num_value) VALUES
(25.6789),
(-17.5432),
(100.999),
(-0.4567),
(9.5),
(1234.56789),
(0);


select * from numbers;

-- abs = absolute value(give number without -ve sign)
select num_value, abs(num_value) from numbers;

-- ceiling and floor - for rounding
select num_value, ceil(num_value) as round_up, floor(num_value) as round_down from numbers;
select num_value, round(num_value, 2) from numbers; -- round to 2 digits

-- Truncate - till a decimal point
select num_value, truncate(num_value, 2) from numbers;

-- power
select power(2,3);

-- Mod - to find remainder
select num_value, mod(num_value, 3) from numbers;

-- sqrt - square root
select num_value, sqrt(abs(num_value)) from numbers;


-- exp - exponention 
select num_value, exp(num_value) from numbers;

-- log(x,y) - log of y base x
-- log(y) - log of y base 10
select log(2, abs(num_value)) from numbers;

-- Trigonometric functions
select num_value, sin(num_value) as sin_val, cos(num_value) as cos_val, tan(num_value) as tan_val from numbers;  -- Input is in radians here

-- pi
select pi();

-- radians and degrees - to convert angle values
select num_value, radians(num_value), degrees(num_value) from numbers;

-- bitwise operations - work on number binary values
select bit_and(num_value) from numbers;
select bit_or(num_value) from numbers;
select bit_xor(num_value) from numbers;


-- =================
-- DATE FUNCTIONS
-- =================

-- Date and time data types:
-- DATE	        YYYY-MM-DD           Stores only date without time
-- DATETIME     YYYY-MM-DD HH:MI:SS  Stores date and time
-- TIMESTAMP    YYYY-MM-DD HH:MI:SS  Stores date/time with automatic UTC conversion
-- TIME         HH:MI:SS             Stores only time
-- YEAR         YYYY                 Stores only a four-digit year


-- Current date and time functions
SELECT NOW() AS current_datetime;
SELECT CURDATE() AS current_date;
SELECT CURTIME() AS current_time;

-- Date part extraction
SELECT YEAR(NOW()) AS current_year;
SELECT MONTH(NOW()) AS current_month;
SELECT DAY(NOW()) AS current_day;
SELECT HOUR(NOW()) AS current_hour;
SELECT MINUTE(NOW()) AS current_minute;
SELECT SECOND(NOW()) AS current_second;


-- MYSQL default date fromat is yyyy-mm-dd
-- if we give %m = month number and %M = month name
select date_format('2025-03-03', '%W, %M, %e, %Y');
select date_add('2025-03-03', interval 7 day);
select date_add('2025-03-03', interval 10 month);
select date_add('2025-03-03', interval 7 year);
select date_sub('2025-03-03', interval 7 day);

-- date_diff - to find diff between dates
select datediff('2025-03-03', '2026-02-05'); -- in days

-- unix_timestamp and from_unixtime
select unix_timestamp('2025-03-03');
select from_unixtime('1740940200');

CREATE DATABASE DateExamplesDB;
USE DateExamplesDB;

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATETIME
);

INSERT INTO orders (customer_name, order_date) VALUES
('Alice', '2025-03-01 10:15:00'),
('Bob', '2025-03-02 14:45:30'),
('Charlie', '2025-03-03 09:30:15'),
('Akshay', '2024-03-01 10:15:00');

-- Querying orders in the last 2 years
SELECT * FROM orders WHERE order_date >= DATE_SUB(NOW(), INTERVAL 2 year);

-- =================
-- AGGREGATE FUNCTIONS
-- =================
-- Used to perform calculations on multiple rows of data and return a single summarized value
-- COUNT() – Returns the number of rows
-- SUM() – Returns the sum of a numeric column
-- AVG() – Returns the average value of a numeric column
-- MIN() – Returns the minimum value
-- MAX() – Returns the maximum value

CREATE DATABASE CompanyDB2;
USE CompanyDB2;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

INSERT INTO employees (name, department, salary, hire_date) VALUES
('Alice', 'HR', 50000, '2018-06-23'),
('Bob', 'IT', 70000, '2019-08-01'),
('Charlie', 'Finance', 80000, '2017-04-15'),
('David', 'HR', 55000, '2020-11-30'),
('Eve', 'IT', 75000, '2021-01-25'),
('Frank', 'Finance', 72000, '2019-07-10'),
('Grace', 'IT', 68000, '2018-09-22'),
('Hank', 'Finance', 90000, '2016-12-05'),
('Ivy', 'HR', 53000, '2022-03-19'),
('Jack', 'IT', 72000, '2017-05-12');

select count(*) from employees where department = 'HR';
select sum(salary) from employees where department = 'HR';
select avg(salary) from employees where department = 'HR';
select min(salary) from employees where department = 'HR';
select max(salary) from employees where department = 'HR';

-- Comprehensive statistics for all employees
SELECT 
    COUNT(*) AS num_employees,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary
FROM employees;

-- Group by department to get statistics per department
SELECT 
    department,
    COUNT(*) AS employee_count,
    SUM(salary) AS department_total_salary,
    ROUND(AVG(salary), 2) AS department_avg_salary,
    MIN(salary) AS department_min_salary,
    MAX(salary) AS department_max_salary
FROM employees
GROUP BY department
ORDER BY department_avg_salary DESC;