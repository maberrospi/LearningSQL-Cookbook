-- Advanced Data Querying

-- Left, right, inner and full joins - Joins two tables
-- Final result combines data horizontally (adds columns)
-- Inner
select name,description,total_amount from orders o inner join products p on p.product_id = o.product_id

select customer_name,total_amount from orders o join customer c on c.customer_id = o.customer_id

-- Left
select customer_name,total_amount from customer c left join orders o on c.customer_id = o.customer_id order by customer_name

-- Right
select name, total_quantity from orders o right join products p on p.product_id = o.product_id

-- Full
select customer_name, total_quantity from orders o full outer join customer c on c.customer_id = o.customer_id

select customer_name, name, total_quantity from customer c full join orders o on c.customer_id = o.customer_id full join
products p on p.product_id = o.product_id

-- Union - Joins two querries
-- Final result combines data vertically (same column)
-- Type and number of return columns must be the same

select name from products where category_id=1
UNION --all maintains duplicates
select name from products p inner join orders o on o.product_id = p.product_id where o.total_quantity>1

-- Case expression (like switch statement)

select name, description,price,
case
	when price isnull then 'Unknown'
	when price<100 then 'Cheap'
	when price>100 and price<500 then 'Affordable'
	else 'Expensive'
	end as ProductType
from products

-- Group by (categorize data)

select city,count(customer_id) from customer group by city

select p.category_id,c.name from products p left join categories c on p.category_id=c.category_id 
select p.category_id,c.name, count(p.product_id) from products p left join categories c on p.category_id=c.category_id group by p.category_id, c.name 
select c.name,c.category_id, count(c.category_id) from products p join categories c on p.category_id=c.category_id group by c.category_id 

-- Agreggate functions
select count(customer_id) as Total_Row_Count from customer; --Bit better performance than *

select count(*) as Total_Row_Count from customer;

select count( distinct customer_id) as Total_Row_Count from customer; -- Like unique

select sum(total_amount) from orders;

select max(total_amount) from orders;

select min(total_amount) from orders;


select avg(total_amount) from orders;
select stddev(total_amount) from orders;

-- Having clause to be used together with group by for filtering instead of where

select city, count(city) from customer group by city having count(*)>100

select c.name, c.category_id, count(p.product_id) from categories c join products p on c.category_id = p.category_id group by c.category_id having count(p.product_id)>1

-- Challenge: Find all product names with their IDs that belong to category 'Electronics'
select product_id, p.name, c.name from products p join categories c on p.category_id=c.category_id
where c.name = 'Electronics'