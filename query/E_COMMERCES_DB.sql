-- CREATING DATABASE FOR E-COMMERCE GOLD 
CREATE DATABASE gold;

USE GOLD;

-- CREATING CUSTOMER TABLE FOR ALL REGISTERED CUSTOMERS
CREATE TABLE dim_customers(
	customer_key int,
	customer_id int,
	customer_number nvarchar(50),
	first_name nvarchar(50),
	last_name nvarchar(50),
	country nvarchar(50),
	marital_status nvarchar(50),
	gender nvarchar(50),
	birthdate date,
	create_date date
);
-- CREATING PRODUCT TABLE FOR ALL LISTED PRODUCT 
CREATE TABLE dim_products(
	product_key int ,
	product_id int ,
	product_number nvarchar(50) ,
	product_name nvarchar(50) ,
	category_id nvarchar(50) ,
	category nvarchar(50) ,
	subcategory nvarchar(50) ,
	maintenance nvarchar(50) ,
	cost int,
	product_line nvarchar(50),
	start_date date 
);
-- CREATING SALES TABLE OF ALL THE SALES HAPPENED 

CREATE TABLE fact_sales(
	order_number nvarchar(50),
	product_key int,
	customer_key int,
	order_date date,
	shipping_date date,
	due_date date,
	sales_amount int,
	quantity tinyint,
	price int 
);


--  LOADING DATA FROM CSV TO RESPECTIVE TABLES;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\gold.dim_customers.csv'
INTO TABLE gold.dim_customers
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\gold.dim_products.csv'
INTO TABLE gold.dim_products
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\gold.fact_sales.csv'
INTO TABLE gold.fact_sales
FIELDS TERMINATED BY ','
IGNORE 1 ROWS
(@order_number, @product_key, @customer_key, @order_date, @shipping_date,@due_date,@sales_amount,@quantity,@price)  -- HANDLING NULL VALUES
SET  
    order_number = NULLIF(@order_number, ''),  
    product_key = NULLIF(@product_key, ''),  
    customer_key = NULLIF(@customer_key, ''),  
    order_date = NULLIF(@order_date, ''),  
    shipping_date = NULLIF(@shipping_date, ''),
    due_date = NULLIF(@due_date, ''),  
    sales_amount = NULLIF(@sales_amount, ''),  
    quantity = NULLIF(@quantity, ''),  
    price= NULLIF(@price, '');  