-- SQL Functions

select abs(-2.6);

select ceil(2.7);

select floor(2.7);

select round(2.3456, 2);

select round(sqrt(4.0), 0);

-- Date functions

select current_date;

select extract(Day from current_date);


select extract(Month from current_date);

select extract(Year from current_date);

select date_part('day', current_date);
select date_part('month', current_date);
select date_part('year', current_date);

select date_trunc('month', current_date);

select date_trunc('year', current_date);

select age(timestamp '2024-01-01');

select age( timestamp '2024-01-01', timestamp '2024-01-31');

select to_date('01/01/2024', 'DD/MM/YYYY');

select to_char(current_date, 'DD-MM-YYYY');

-- Time functions

select current_time;
select current_timestamp;

select localtime;

select localtimestamp;

select extract(hour from order_timestamp) from orders;


select extract(minute from order_timestamp) from orders;


select extract(second from order_timestamp) from orders;

select date_trunc('day', order_timestamp) from orders;

select age(order_timestamp) from orders;

select age(delivery_timestamp, order_timestamp) from orders;

select current_timestamp at Time Zone 'America/New_York';

-- String functions

select city || '----'|| address from customer; --concatenation

select concat(city, address) as CityAddres from customer;

select concat_ws('--', city, address) from customer;

select trim('    helllo     ');
select trim('X' from 'XXXHelloXXX');

select ltrim('   hello   ');
select btrim('   hello   ');

select upper('hello');
select lower('HELLO');
select initcap('hello');

select upper(customer_name) from customer;

select substring('Hello' from 1 for 3);
select substring('Hello' from 3 for 5);
select left('Hello', 3);
select right('Hello', 2);
select position ('test' in 'Hello test one'); -- returns 0 if not in it
select length('Hello');

-- Challenge: Capitalize each tag in Products table

select initcap(tags) from products
update products set tags = initcap(tags) -- update column to initcaps
select tags from products