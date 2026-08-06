use test;

#to select only the column you want 
select first_name, email from employees;



# making new database
create database company;
use company;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

INSERT INTO employees (first_name, last_name, department, salary, hire_date) VALUES
('John', 'Doe', 'HR', 60000.00, '2022-05-10'),
('Jane', 'Smith', 'IT', 75000.00, '2021-08-15'),
('Alice', 'Johnson', 'Finance', 82000.00, '2019-03-20'),
('Bob', 'Williams', 'IT', 72000.00, '2020-11-25'),
('Charlie', 'Brown', 'Marketing', 65000.00, '2023-01-05');

SELECT * FROM employees;

select first_name as 'First Name', last_name as 'Last Name', department as 'Departments' from employees;

select * from employees where department = 'IT';

select * from employees order by salary DESC;

select * from employees limit 2;

# To find unique departments
select distinct department from employees ; 


# These expressions only work for view purpose
select first_name, last_name, salary*1.1 as 'Salary After Raise' from employees;  


#Concatination
select concat(first_name, ' ' , last_name) as 'Full Name' from employees;

#To select year only from hire date as YEAR(c1), month(c1)
select year(hire_date) from employees;

# Round off some numbers - round(column_name , how much)
select round(salary,1) from employees;

#Average using sub query
select salary from employees where salary > (select avg(salary) from employees);

# to combine data of 2 or more queries
select first_name , last_name from employees where department = 'IT' UNION
select first_name , last_name from employees where department = 'HR';


select count(*), department from employees group by department;


# select as calculater
select now();
select 2+2;
select length('hello');
select 5<3;