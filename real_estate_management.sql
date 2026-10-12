CREATE DATABASE real_estate_db;

USE real_estate_db;

SHOW DATABASES;

CREATE TABLE agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(100),
    city VARCHAR(50),
    experience_years INT
);

DESC agents;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    customer_type VARCHAR(20)
);

DESC customers;

CREATE TABLE properties (
    property_id INT PRIMARY KEY,
    property_type VARCHAR(50),
    city VARCHAR(50),
    bedrooms INT,
    listing_price DECIMAL(12,2),
    listing_date DATE,
    agent_id INT,
    FOREIGN KEY (agent_id)
        REFERENCES agents(agent_id)
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    property_id INT,
    customer_id INT,
    transaction_type VARCHAR(20),
    transaction_date DATE,
    sale_price DECIMAL(12,2),
    FOREIGN KEY (property_id)
        REFERENCES properties(property_id),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

INSERT INTO agents VALUES
(101,'Amit Sharma','Mumbai',8),
(102,'Priya Singh','Delhi',6),
(103,'Rahul Mehta','Pune',10),
(104,'Sneha Patel','Bangalore',5);

INSERT INTO customers VALUES
(1,'Rahul Verma','Mumbai','Buyer'),
(2,'Anjali Gupta','Delhi','Tenant'),
(3,'Rohan Patel','Pune','Buyer'),
(4,'Neha Sharma','Bangalore','Tenant'),
(5,'Aakash Shah','Hyderabad','Buyer');

INSERT INTO properties VALUES
(1001,'Apartment','Mumbai',2,8500000,'2025-01-05',101),
(1002,'Villa','Delhi',4,22000000,'2025-01-08',102),
(1003,'Apartment','Pune',3,9500000,'2025-01-12',103),
(1004,'Studio','Bangalore',1,4200000,'2025-01-15',104),
(1005,'Villa','Hyderabad',5,28000000,'2025-01-18',103);

INSERT INTO transactions VALUES
(5001,1001,1,'Sale','2025-02-01',8300000),
(5002,1002,2,'Rent','2025-02-03',45000),
(5003,1003,3,'Sale','2025-02-05',9200000),
(5004,1004,4,'Rent','2025-02-08',28000),
(5005,1005,5,'Sale','2025-02-12',27500000);

SELECT * FROM agents;
SELECT * FROM customers;
SELECT * FROM properties;
SELECT * FROM transactions;

-- Q1. Total Properties Listed
SELECT COUNT(*) AS total_properties
FROM properties;

-- Q2. Total Agents
SELECT COUNT(*) AS total_agents
FROM agents;

-- Q3. Total Customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Q4. Show Properties From Mumbai
SELECT *
FROM properties
WHERE city = 'Mumbai';

-- Q5. Show Properties With More Than 3 Bedrooms
SELECT *
FROM properties
WHERE bedrooms > 3;

-- Q6. Properties Above ₹1 Crore

-- Database मध्ये prices actual rupees मध्ये आहेत.

-- ₹1 crore = 10000000

SELECT *
FROM properties
WHERE listing_price > 10000000;

SELECT
    a.agent_name,
    a.city,
    p.property_id,
    p.property_type,
    p.listing_price
FROM agents a
INNER JOIN properties p
ON a.agent_id = p.agent_id;

SELECT
    a.agent_name,
    a.city,
    p.property_id,
    p.property_type,
    p.listing_price
FROM agents a
INNER JOIN properties p
ON a.agent_id = p.agent_id;

SELECT
    t.transaction_id,
    p.property_type,
    p.city,
    c.customer_name,
    t.transaction_type,
    t.transaction_date,
    t.sale_price
FROM transactions t
INNER JOIN properties p
    ON t.property_id = p.property_id
INNER JOIN customers c
    ON t.customer_id = c.customer_id;
    
    SELECT
    SUM(sale_price) AS total_sales_revenue
FROM transactions
WHERE transaction_type = 'Sale';

SELECT
    AVG(listing_price) AS average_property_price
FROM properties;

SELECT
    AVG(sale_price) AS average_rent
FROM transactions
WHERE transaction_type = 'Rent';

SELECT
    p.city,
    SUM(t.sale_price) AS total_revenue
FROM transactions t
INNER JOIN properties p
    ON t.property_id = p.property_id
WHERE t.transaction_type = 'Sale'
GROUP BY p.city;


SELECT
    p.property_type,
    SUM(t.sale_price) AS total_revenue
FROM transactions t
INNER JOIN properties p
    ON t.property_id = p.property_id
WHERE t.transaction_type = 'Sale'
GROUP BY p.property_type;

SELECT
    a.agent_name,
    COUNT(t.transaction_id) AS total_transactions,
    SUM(
        CASE
            WHEN t.transaction_type = 'Sale'
            THEN t.sale_price
            ELSE 0
        END
    ) AS total_sales
FROM agents a
INNER JOIN properties p
    ON a.agent_id = p.agent_id
INNER JOIN transactions t
    ON p.property_id = t.property_id
GROUP BY a.agent_id, a.agent_name
ORDER BY total_sales DESC;

SELECT
    customer_type,
    COUNT(*) AS total_customers
FROM customers
GROUP BY customer_type;

SELECT
    p.property_id,
    p.property_type,
    p.city,
    t.sale_price
FROM properties p
INNER JOIN transactions t
    ON p.property_id = t.property_id
WHERE t.transaction_type = 'Sale'
ORDER BY t.sale_price DESC
LIMIT 1;

SELECT
    p.property_id,
    p.property_type,
    p.city,
    t.sale_price
FROM properties p
INNER JOIN transactions t
    ON p.property_id = t.property_id
WHERE t.transaction_type = 'Sale'
ORDER BY t.sale_price ASC
LIMIT 1;

SELECT
    a.agent_id,
    a.agent_name,
    p.property_id,
    p.property_type,
    p.city
FROM agents a
LEFT JOIN properties p
ON a.agent_id = p.agent_id;

USE real_estate_db;

SELECT DATABASE();

SHOW TABLES;

CREATE TABLE agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(100),
    city VARCHAR(50),
    experience_years INT
);

INSERT INTO agents VALUES
(101,'Amit Sharma','Mumbai',8),
(102,'Priya Singh','Delhi',6),
(103,'Rahul Mehta','Pune',10),
(104,'Sneha Patel','Bangalore',5);

SELECT * FROM agents;


SELECT
    a.agent_id,
    a.agent_name,
    p.property_id,
    p.property_type,
    p.city
FROM agents a
LEFT JOIN properties p
ON a.agent_id = p.agent_id;

SELECT
    a.agent_id,
    a.agent_name,
    p.property_id,
    p.property_type,
    p.city
FROM agents a
LEFT JOIN properties p
ON a.agent_id = p.agent_id;

	SELECT
    a.agent_name,
    COUNT(p.property_id) AS total_properties
FROM agents a
LEFT JOIN properties p
ON a.agent_id = p.agent_id
GROUP BY a.agent_id, a.agent_name;

SELECT
    a.agent_name,
    COUNT(p.property_id) AS total_properties
FROM agents a
LEFT JOIN properties p
ON a.agent_id = p.agent_id
GROUP BY a.agent_id, a.agent_name
HAVING COUNT(p.property_id) > 1;

SELECT
    property_id,
    property_type,
    listing_price,
    CASE
        WHEN listing_price < 5000000 THEN 'Budget'
        WHEN listing_price <= 10000000 THEN 'Mid Range'
        ELSE 'Luxury'
    END AS price_category
FROM properties;

SELECT
    transaction_id,
    transaction_type,
    sale_price,
    CASE
        WHEN transaction_type = 'Sale'
        THEN 'Property Sold'
        WHEN transaction_type = 'Rent'
        THEN 'Property Rented'
        ELSE 'Other'
    END AS transaction_status
FROM transactions;

SELECT
    transaction_id,
    transaction_date,
    YEAR(transaction_date) AS transaction_year
FROM transactions;

SELECT
    transaction_id,
    transaction_date,
    MONTH(transaction_date) AS transaction_month
FROM transactions;

SELECT
    transaction_id,
    transaction_date,
    MONTHNAME(transaction_date) AS month_name
FROM transactions;

SELECT
    MONTHNAME(transaction_date) AS month_name,
    SUM(sale_price) AS total_sales
FROM transactions
WHERE transaction_type = 'Sale'
GROUP BY MONTH(transaction_date), MONTHNAME(transaction_date)
ORDER BY MONTH(transaction_date);

WITH agent_sales AS (
    SELECT
        p.agent_id,
        SUM(t.sale_price) AS total_sales
    FROM properties p
    INNER JOIN transactions t
        ON p.property_id = t.property_id
    WHERE t.transaction_type = 'Sale'
    GROUP BY p.agent_id
)
SELECT *
FROM agent_sales;





WITH agent_sales AS (
    SELECT
        p.agent_id,
        SUM(t.sale_price) AS total_sales
    FROM properties p
    INNER JOIN transactions t
        ON p.property_id = t.property_id
    WHERE t.transaction_type = 'Sale'
    GROUP BY p.agent_id
)
SELECT
    a.agent_name,
    agent_sales.total_sales
FROM agents a
INNER JOIN agent_sales
    ON a.agent_id = agent_sales.agent_id
ORDER BY agent_sales.total_sales DESC;





SELECT
    a.agent_name,
    SUM(t.sale_price) AS total_sales,
    RANK() OVER (
        ORDER BY SUM(t.sale_price) DESC
    ) AS sales_rank
FROM agents a
INNER JOIN properties p
    ON a.agent_id = p.agent_id
INNER JOIN transactions t
    ON p.property_id = t.property_id
WHERE t.transaction_type = 'Sale'
GROUP BY a.agent_id, a.agent_name;


SELECT
    property_id,
    property_type,
    listing_price,
    ROW_NUMBER() OVER (
        ORDER BY listing_price DESC
    ) AS property_rank
FROM properties;

-- step 34

SELECT
    property_id,
    property_type,
    listing_price,
    DENSE_RANK() OVER (
        ORDER BY listing_price DESC
    ) AS price_rank
FROM properties;



SELECT
    property_id,
    property_type,
    listing_price,
    DENSE_RANK() OVER (
        ORDER BY listing_price DESC
    ) AS price_rank
FROM properties;



SELECT
    a.agent_name,
    COUNT(t.transaction_id) AS total_transactions,
    SUM(t.sale_price) AS total_sales
FROM agents a
INNER JOIN properties p
    ON a.agent_id = p.agent_id
INNER JOIN transactions t
    ON p.property_id = t.property_id
WHERE t.transaction_type = 'Sale'
GROUP BY a.agent_id, a.agent_name
ORDER BY total_sales DESC;



SELECT
    COUNT(DISTINCT t.property_id) AS sold_properties,
    COUNT(p.property_id) AS total_properties,
    ROUND(
        COUNT(DISTINCT t.property_id) * 100.0
        / COUNT(p.property_id),
        2
    ) AS conversion_rate
FROM properties p
LEFT JOIN transactions t
    ON p.property_id = t.property_id
    AND t.transaction_type = 'Sale';
    
    
    
    
    
    
    
    
    SELECT
    COUNT(DISTINCT p.property_id) AS total_properties,

    COUNT(DISTINCT CASE
        WHEN t.transaction_type = 'Sale'
        THEN t.property_id
    END) AS total_sold,

    COUNT(DISTINCT CASE
        WHEN t.transaction_type = 'Rent'
        THEN t.property_id
    END) AS total_rented,

    SUM(CASE
        WHEN t.transaction_type = 'Sale'
        THEN t.sale_price
        ELSE 0
    END) AS total_sales_revenue,

    AVG(p.listing_price) AS average_listing_price,

    AVG(CASE
        WHEN t.transaction_type = 'Rent'
        THEN t.sale_price
    END) AS average_rent

FROM properties p
LEFT JOIN transactions t
    ON p.property_id = t.property_id;
    
    
    
    






