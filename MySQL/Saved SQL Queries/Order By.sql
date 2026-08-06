CREATE DATABASE db12;
USE db12;

-- Create a products table with various data types
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT,
    last_updated TIMESTAMP
);

-- Insert initial sample data
INSERT INTO products VALUES
(1, 'Laptop Pro', 'Electronics', 1299.99, 50, '2024-01-15 10:00:00'),
(2, 'Desk Chair', 'Furniture', 199.99, 30, '2024-01-16 11:30:00'),
(3, 'Coffee Maker', 'Appliances', 79.99, 100, '2024-01-14 09:15:00'),
(4, 'Gaming Mouse', 'Electronics', 59.99, 200, '2024-01-17 14:20:00'),
(5, 'Bookshelf', 'Furniture', 149.99, 25, '2024-01-13 16:45:00');

select * from products;

select * from products order by price asc; 

# Sorting by multiple column
select * from products order by category desc, price asc;

#sorting by column positions
select * from products order by 4;

# sorting with where clause
select * from products where category = 'electronics' order by price;

# for case sensitive sorting
select * from products order by binary price;

# sorting with functions
select * from products order by length(product_name);
select * from products order by day(last_updated);

# sorting with limit
select * from products order by stock_quantity desc limit 1;



#Custom Sorting using field function
select * from products order by field(category , 'electronics', 'appliances', 'furniture'), price ;

#Custom sorting using "case"
-- low stock and price high
--  let's say:
-- low stock = less than 50 items
-- Good price = less than $200
-- Best deals = low stock and good price
# it provide the whole table first which is false according to condition and then according to condition for condition first we need to apply "DESC"

select *, stock_quantity <= 50 and price >=200 from products order by (stock_quantity <= 50 and price >=200) desc;  #It not readable so we use case

#Case 
select *, case 
	when stock_quantity <=50 and price >= 200 then 1  # this 2 and 4 is priority
    when stock_quantity <=50 then 2
    else 3
end as priority 
from products order by 
case 
	when stock_quantity <=50 and price >= 200 then 1  # this 2 and 4 is priority
    when stock_quantity <=50 then 2
    else 3
end;

-- Handling NULL Values

INSERT INTO products VALUES
(6, 'Desk Lamp', 'Furniture', NULL, 45, '2024-01-18 13:25:00'),
(7, 'Keyboard', 'Electronics', 89.99, NULL, '2024-01-19 15:10:00');

# null will come at the top by default
select * from products order by price;

# we can also use case and condition 
select *, price is null from products order by price is null;

-- Sorting with calculated columns
select *, price * stock_quantity as total_value from products order by price * stock_quantity; 