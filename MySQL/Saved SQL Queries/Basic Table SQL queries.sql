create table employees(
employ_id int primary key auto_increment,
first_name varchar(50) not null,
last_name varchar(50) not null,
hire_date date default (current_date()),
email varchar(100) unique,
phone_number varchar(100) unique,
salary decimal(10,2) check (salary > 0.0),
employment_status enum('active', 'on leave', 'terminated') default 'active',
created_at timestamp default (current_timestamp()),
updated_at timestamp default (current_timestamp()) on update current_timestamp #current_timestamp can be used without brackets   
);



insert into employees (
first_name,
last_name,
hire_date,
email,
phone_number,
salary,
employment_status,
description,
emergency_contact,
department_id
)
values(
'miks',
'hackman',
'2026-01-15',
'miks.hackman@gmail.com',
'+1-555-123-4328',
'75000.00',
'active',
'xyz',
'+1-323-523-5464',
'3'
);



create table departments(
	department_id int primary key auto_increment,
    department_name varchar(100) not null,
    location varchar(100),
    created_at timestamp default (current_timestamp()),
	updated_at timestamp default (current_timestamp()) on update current_timestamp
);



insert into departments(department_name, location) values 
('IT', 'Building A'),
('HR', 'Building B'),
('Sales', 'Building C');



alter table employees add column description varchar(100);

alter table employees add column emergency_contact varchar(100) not null;

alter table employees rename column emergency_contact to em_contact;

alter table employees add column department_id int;

alter table employees add foreign key (department_id) references departments(department_id);


select * from employees;
select * from departments;