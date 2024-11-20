-- Real world insurance project

---Customers Table---------
CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender CHAR(1),
    Address VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10)
);

---2. PolicyTypes Table

CREATE TABLE PolicyTypes (
    PolicyTypeID SERIAL PRIMARY KEY,
    PolicyTypeName VARCHAR(50),
    Description TEXT
);

----3. Policies Table

CREATE TABLE Policies (
    PolicyID SERIAL PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    PolicyTypeID INT REFERENCES PolicyTypes(PolicyTypeID),
    PolicyStartDate DATE,
    PolicyEndDate DATE,
    Premium DECIMAL(10,2)
);

---4. Claims Table

CREATE TABLE Claims (
    ClaimID SERIAL PRIMARY KEY,
    PolicyID INT REFERENCES Policies(PolicyID),
    ClaimDate DATE,
    ClaimAmount DECIMAL(10,2),
    ClaimDescription TEXT,
    ClaimStatus VARCHAR(50)
);


---5. Data population

insert into customers (FirstName, LastName, DateOfBirth, Gender, Address, City, State, ZipCode) Values
('John', 'Doe', '1980-04-12', 'M', '123 Elm St', 'Springfield', 'IL', '62704'),
('Jane', 'Smith', '1975-09-23', 'F', '456 Maple Ave', 'Greenville', 'TX', '75402'),
('Emily', 'Johnson', '1990-01-17', 'F', '789 Oak Dr', 'Phoenix', 'AZ', '85001'),
('Michael', 'Brown', '1985-07-30', 'M', '321 Pine St', 'Riverside', 'CA', '92501');

insert into claims (policyid,claimdate,claimamount,claimdescription,claimstatus) values
(1, '2021-06-15', 500.00, 'Car accident', 'Approved'),
(2, '2021-07-20', 1000.00, 'House fire', 'Pending'),
(3, '2021-08-05', 20000.00, 'Life insurance claim', 'Approved'),
(4, '2021-09-10', 150.00, 'Doctor visit', 'Denied'),
(5, '2021-10-22', 300.00, 'Car theft', 'Approved');

insert into policies (customerid,policytypeid,policystartdate,policyenddate,premium) values
(1, 1, '2021-01-01', '2022-01-01', 120.00),
(2, 2, '2021-02-01', '2022-02-01', 150.00),
(1, 3, '2021-03-01', '2024-03-01', 300.00),
(3, 4, '2021-04-01', '2022-04-01', 200.00),
(4, 1, '2021-05-01', '2022-05-01', 100.00);

insert into policytypes (policytypename,description) values
('Auto', 'Insurance coverage for automobiles'),
('Home', 'Insurance coverage for residential homes'),
('Life', 'Long-term insurance coverage upon the policyholder''s death'),
('Health', 'Insurance coverage for medical and surgical expenses');

---6. Analytical querries

---6.1 Calculate total number of claims per policy type
with policy_count as (
select pt.policytypename,pt.policytypeid, p.policyid from policytypes pt join policies p on pt.policytypeid=p.policytypeid
)
select pc.policytypename, count(c.claimid) as total_claims from policy_count pc join claims c on pc.policyid=c.policyid
group by policytypename
order by total_claims desc

--Proposed solution
SELECT
    pt.PolicyTypeName,
    COUNT(c.ClaimID) AS TotalClaims
FROM
    Claims c
JOIN
    Policies p ON c.PolicyID = p.PolicyID
JOIN
    PolicyTypes pt ON p.PolicyTypeID = pt.PolicyTypeID
GROUP BY
    pt.PolicyTypeName
ORDER BY
    TotalClaims DESC;

---6.2 Determine monthly claim frequency and average claim amount
select date_trunc('month',claimdate) as claimmonth, count(claimid) as claimfrequency, avg(claimamount) from claims
group by claimmonth
order by claimmonth

-- Proposed solution
SELECT
    DATE_TRUNC('month', ClaimDate) AS ClaimMonth,
    COUNT(*) AS ClaimFrequency,
    AVG(ClaimAmount) AS AverageClaimAmount
FROM
    Claims
GROUP BY
    ClaimMonth
ORDER BY
    ClaimMonth;

---7. Optimization
---7.1 Create indexes where needed to optimize
create index idx_policytypename on policytype(policytypename);
create index idx_claimsclaimdate on claims(claimdate);

---8. Roles and Permissions
---8.1 Create ClaimsAnalyst and ClaimsManager roles
create role Claims
grant select on claims,policies,policytypes to Claims
create role ClaimsAnalysts with login password 'analystpass' in role Claims
create role ClaimsManager with login password 'managerpass' in role Claims
grant insert,update,delete on policies,policytypes to ClaimsManager

-- See priviliges of the created users
select * from information_schema.role_table_grants
where grantee in ('claimsmanager','claimsanalysts','claims')
order by grantee

-- Proposed solution

--Task 5: Roles and Permissions
	-- Create roles: ClaimsAnalyst and ClaimsManager.
	-- ‘ClaimsAnalyst’ role should have read-only access to claims and policies data.
	-- ‘ClaimsManager’ role should have full access to claims data and the ability to update policy information.
	
CREATE ROLE ClaimsAnalyst  LOGIN PASSWORD 'password1';

-- Create ClaimsManager Role
CREATE ROLE ClaimsManager  LOGIN PASSWORD 'password2';


-- Grant select on necessary tables
GRANT SELECT ON Claims, Policies, PolicyTypes TO ClaimsAnalyst;

GRANT SELECT, INSERT, UPDATE, DELETE ON Claims, Policies, PolicyTypes TO ClaimsManager;


