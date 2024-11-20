-- Analytical Functions
-- Perform data manipulation and performance optimization and is scalable

-- Ranking functions
select customer_id,
rank() over (partition by customer_id order by total_amount desc) as order_rank,
total_amount from orders

-- Dense rank doesnt provide gaps like simple rank
select customer_id,
dense_rank() over (partition by customer_id order by total_amount desc) as order_rank,
total_amount from orders

-- Window functions
select order_id, customer_id, order_timestamp,
row_number() over (partition by customer_id order by order_timestamp asc) as order_sequence_num
from orders

-- Lag() retrieve data fromp revious row. Lead() retrieve data from the next row
-- Returns null if no value found
select customer_id, order_id, order_timestamp,
lag(order_timestamp,1) over (partition by customer_id order by order_timestamp asc) as prev_order
from orders

select customer_id, order_id, order_timestamp,
lead(order_timestamp,1) over (partition by customer_id order by order_timestamp asc) as next_order
from orders

-- remove nulls from window functions
select *
	from (
		select customer_id, order_id, order_timestamp,
		lead(order_timestamp,1) over (partition by customer_id order by order_timestamp asc) as next_order
		from orders
	) lag_res
where lag_res.next_order is not null

-- with CTE
with lag_res as (
select customer_id, order_id, order_timestamp,
lead(order_timestamp,1) over (partition by customer_id order by order_timestamp asc) as next_order
from orders
)
select * from lag_res where lag_res.next_order is not null

-- Aggregate functions

select customer_id, order_id, total_amount,order_timestamp,
sum(total_amount) over (partition by customer_id order by order_timestamp) as total_customer_amount
from orders

select product_id, order_timestamp,total_quantity,
sum(total_quantity) over (partition by product_id order by order_timestamp) as running_qty
from orders

-- Moving average
-- Use previous data info for current point avg calculation, smooths the changes
-- Useful for trend analysis

select order_id, customer_id, order_timestamp, total_amount,
avg(total_amount) over (partition by customer_id order by order_timestamp
	rows between 1 preceding and current row) as mvg_avg
	from orders

-- Challenge: Find cumulative sales volume of each product over time
-- In other words running total of quantity for each product id

select product_id, total_quantity, order_timestamp,
sum(total_quantity) over (partition by product_id order by order_timestamp) as running_qty
from orders
