create database bookstore;

use bookstore;

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(50),
    price DECIMAL(10,2),
    publication_date DATE,
    category VARCHAR(30),
    in_stock INT
);

INSERT INTO books VALUES
(1, 'The MySQL Guide', 'John Smith', 29.99, '2023-01-15', 'Technology', 50),
(2, 'Data Science Basics', 'Sarah Johnson', 34.99, '2023-03-20', 'Technology', 30),
(3, 'Mystery at Midnight', 'Michael Brown', 19.99, '2023-02-10', 'Mystery', 100),
(4, 'Cooking Essentials', 'Lisa Anderson', 24.99, '2023-04-05', 'Cooking', 75);

insert into books values(5, 'Cook Book', null, 25.32, '2023-04-06', 'Cooking', 25); 
insert into books values(6, ' Mini Cook Book', 'Gohn Smith', 35, '2023-06-06', 'Cooking', 27); 

# LOGICAL OPERATORS -:
select * from books;

select * from books where publication_date >= '2023-03-01';

select * from books where category = 'Technology' and price < 30;

select * from books where (category = 'Technology' or category = 'Mystery') and price < 30;

# we can use =, !=, >=, <= , and , or , not

# FINDING NULL VALUES -:
select * from books where author is null;
select * from books where not author is null;
select * from books where author is not null;

#PATTERN MATCHING -:
select * from books where title like '%SQL%';   # case insensitive
select * from books where title like '%the%';   # anywhere to find "the"
select * from books where title like 'the% ';    # "the" at the start

select * from books where title like binary '%The%'; # case sensitive search
select * from books where author like binary '_ohn%'; # for finding the author in which only one letter is before "ohn"
select * from books where price between 20 and 30; #for finding in range

select * from books where category in ('cooking', 'technology'); #to select from a category(Case Insensitive)

select * from books where price between 20 and 35 and publication_date >= '2023-01-01'; #combination of queries
select * from books where price > (select avg(price) from books); 

select * from books where year(publication_date) = 2023 and price < (select avg(price) from books);
select * from books where category = 'Technology' and title like '%data%' and in_stock > 50;
select * from books where (category = 'technology' and price > 30) or (category = 'mystery' and price < 20);
select * from books where (title like '%son%' or title like '%th%') and publication_date > '2023-03-31';