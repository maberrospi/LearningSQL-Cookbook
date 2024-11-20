-- Handling null values
-- Nulls cannot compare directly
select * from products where price is null

-- Aggregate functions don't consider null values (except count)

-- Coalesce handles null values by providing an alternative value
-- Nullif returns null if two expressions are equal

-- Practical example
SELECT
    DATE_TRUNC('month', o.order_timestamp) AS order_month,
    SUM(o.total_quantity * p.price) AS total_sales
FROM
    orders o
JOIN
    products p ON o.product_id = p.product_id
WHERE
    o.order_timestamp >= '2023-01-01' AND
    o.order_timestamp < '2025-04-01'
GROUP BY
    order_month
ORDER BY
    order_month;

-- This returns some Null values in the second column
-- We identify the components that are nul and then update them (one way)

select * from orders where total_quantity is null

select * from products where price is null

select * from orders where product_id in (1, 4)

update products set price =200 where product_id =4