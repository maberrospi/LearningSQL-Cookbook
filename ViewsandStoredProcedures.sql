-- Views - Virtual table from a result of a query
-- Use to simplify reporting, increase data security, adaptability, code reusability, performance opt.
-- Limitations: Performance, non-indexable, no ownership of data, complexity in maintenance using multiple views

-- Standard view
create view customer_order_summary as
select customer_id, count(order_id), sum(total_amount)
from orders
group by customer_id

select * from customer_order_summary where customer_id=1

-- Materialized views - Fast since query execution not performed every time

-- Stored Procedures - Prepared sql code to save and reuse like traditional functions
-- Have query optimization that are reused in subsequent invocations

create procedure add_category(cat_id int,cat_name varchar)
language plpgsql -- programmable postgresql
as
$$
BEGIN
 insert into categories values (cat_id,cat_name);
END;
$$;

call add_category(6, 'Fashion')

select * from categories

drop procedure add_category

-- Challenge: Create a view to get the product name and category name

create view product_categories as
select p.product_id,p.name as product_name, c.name as category_name
from products p join categories c on p.category_id = c.category_id
order by c.name

select * from product_categories

drop view product_categories