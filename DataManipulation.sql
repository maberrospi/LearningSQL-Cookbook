-- Data manipulation

-- Insert, update, delete

insert into products (name, price, description, tags, category_id, Supplier)
values ('Ipad', 100, 'High-performance ipad for professionals', 'electronics, portable, tech', 1, 'SupplierA')

select * from products

update products set price=500 where product_id=6
update products set price=500, category_id=2 where product_id=6

delete from products where product_id=6

-- To delete entire table data can use these two
-- Truncate is faster if you want to delete a lot of data

delete from public."FruitJuice"
truncate public."FruitJuice"

-- Drop will completely delete the table

drop table public."FruitJuice"

-- Challenge: remove the order with id #10 from the order list

delete from orders where order_id=10