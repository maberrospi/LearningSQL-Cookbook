-- Indexes and Performance

-- Index - makes search much faster and efficient
-- Should be created based on common query patterns, they might slow down write ops

-- Single column index
create index idx_customer_email on customer(email)
create index idx_prod_cat on products(category_id)

-- Composite index (2 or more columns)
create index idx_cust_order on orders(customer_id,order_timestamp)

-- Unique index
create unique index idx_prod_name on products(name)

-- Clustered index

-- Performance

-- Explain and analyze commands
explain analyze select * from orders where order_id=1
explain select * from orders where order_id=1

select * from pg_stat_user_indexes where relname='orders' -- see what indexes exist and when are utilized
select * from pg_stat_user_indexes

-- Performance tuning

select * from orders where customer_id=1 order by order_timestamp desc
-- Improved using index
create index idx_cust on orders(customer_id,order_timestamp)
-- Limit records retrieved
select * from orders where customer_id=1 order by order_timestamp desc limit 2
-- Optimize subquery using Common Table Expression (CTE)

-- Challenge: Use index to improve order searching using timestamp column
create index idx_order_timestamp on orders(order_timestamp)