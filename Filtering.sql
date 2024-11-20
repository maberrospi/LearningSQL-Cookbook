select name, price from products

select * from orders where total_amount>100

select * from customer where customer_name like 'A%'

select * from products order by price;

select * from customer order by customer_name

-- Descending order

select * from customer order by customer_name desc

-- Order by price and then by name

select * from products order by price, name

-- Using a (or multiple) condition with order by

select * from products where price<100 and category_id=1 order by price 

-- Challenge: Find list of customers in NY and arrange in alphabetical order by names

select * from customer where city='New York' order by customer_name

