-- Database Security

-- Users
create role random with login password 'randompass' --add other properties like superuser, createdb, createrole
create role random with login password 'randompass' valid until '2024-12-31'
create role random2 with login password 'randompass' connection limit 10 -- only 10 parallel connections
create role random with login password 'randompass' in role random2 -- same like random2
create user random3 with password 'randompass'
drop user random3

-- Types of permissions
-- Select, Insert, Update, delete, execute, connect, create, temp

grant select, insert on customer to random
grant select on all tables in schema public to random -- give permision to all tables in the schema
grant select on customer to random with grant option -- random can grant select permision to others
revoke select, insert on customer from random -- remove permisions
revoke all on customer from random -- remove all permissions

-- Use roles for permission management
create role sales_team

create role admins

grant select on all tables in schema public to sales_team

grant all privileges on all tables in schema public to admins

create role sales_managers in role sales_team --Hierarchy

-- Best practices
-- Principle of least privilege, Role hierarchies, use schema-based access control
-- use NOINHERIT, application-specific roles, data encryption and masking

-- Challenge: New team member Bob, grant access to view product details

create user Bob with login password 'bobspass' 
grant select on products to Bob