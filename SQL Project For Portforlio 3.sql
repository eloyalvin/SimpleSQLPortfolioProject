/* 
	SQL Portfolio Project III
	Utilizing MySQL and MySQL Workbench
	Created by Eloy Alvin Luna 
	Published on ?? ??, 2024

	Note: The database utilized here was obtained from 
   	https://www.kaggle.com/datasets/dillonmyrick/bike-store-sample-database 
    	on Wednesday, May 8, 2024 (CT).
    
    	The owner of the database in Kaggle is Dillon Myrick and it was published 
    	under the conditions that it cannot be used for commercial purposes.
*/ 

/* 
	1. Displaying a list of all existing databases.
*/
SHOW DATABASES;

/* 
	2. Create a new database with the name 'bike_store_db', display the list of all 
    the existing databases again, and then use the 'bike_store_db' database as the 
    current database for subsequent statements.
*/
CREATE DATABASE bike_store_db;
SHOW DATABASES;
USE bike_store_db;

/* 
	3. Using MySQL Workbench, import the nine Comma-Separated Value files of the
	Bike Store Relational Database named:
		a. brands.csv
        b. categories.csv
		c. customers.csv
        d. order_items.csv
        e. orders.csv
        f. products.csv
        g. staffs.csv
        i. stocks.csv
        j. stores.csv
        
	Confirm by displaying a list of all the tables.
*/
SHOW TABLES;
-- For the complete answer of question 3, see the slides pdf presentation in my Electronic Portfolio.

/* 
	4. Create a new table with the name 'tables_dimensions' and display its structure. Its 
    columns and types should be as follows:
    
		a. table_id (INTEGER AUTO_INCREMENT) <- Primary Key
        b. table_name (VARCHAR(11) NOT NULL)
        c. num_rows (INTEGER NOT NULL)
        d. num_cols (INTEGER NOT NULL)
        
	Make sure you drop any existing table with that name before creating it.
*/
DROP TABLE IF EXISTS tables_dimensions; 
CREATE TABLE tables_dimensions (
	table_id INTEGER AUTO_INCREMENT,
    table_name VARCHAR(11) NOT NULL,
    num_rows INTEGER NOT NULL,
    num_cols INTEGER NOT NULL,
    PRIMARY KEY (table_id)
    ); 
DESCRIBE tables_dimensions;

/*
	5. Insert into the 'tables_dimensions' table the names of each of the original tables, with
    the number or rows and columns of each table. Display the content of the 'tables_dimensions'
    table after inserting the data.
*/
INSERT INTO tables_dimensions (table_name, num_rows, num_cols)
	SELECT 
		'brands' AS table_name,
		(SELECT COUNT(*) FROM brands) AS num_rows,
		(SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_schema = 'bike_store_db' AND table_name = 'brands') AS num_cols;
INSERT INTO tables_dimensions (table_name, num_rows, num_cols)
	SELECT 
		'categories' AS table_name,
		(SELECT COUNT(*) FROM categories) AS num_rows,
		(SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_schema = 'bike_store_db' AND table_name = 'categories') AS num_cols;
INSERT INTO tables_dimensions (table_name, num_rows, num_cols)
	SELECT 
		'customers' AS table_name,
		(SELECT COUNT(*) FROM customers) AS num_rows,
		(SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_schema = 'bike_store_db' AND table_name = 'customers') AS num_cols;
INSERT INTO tables_dimensions (table_name, num_rows, num_cols)
	SELECT 
		'order_items' AS table_name,
		(SELECT COUNT(*) FROM order_items) AS num_rows,
		(SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_schema = 'bike_store_db' AND table_name = 'order_items') AS num_cols;
INSERT INTO tables_dimensions (table_name, num_rows, num_cols)
	SELECT 
		'orders' AS table_name,
		(SELECT COUNT(*) FROM orders) AS num_rows,
		(SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_schema = 'bike_store_db' AND table_name = 'orders') AS num_cols;
INSERT INTO tables_dimensions (table_name, num_rows, num_cols)
	SELECT 
		'products' AS table_name,
		(SELECT COUNT(*) FROM products) AS num_rows,
		(SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_schema = 'bike_store_db' AND table_name = 'products') AS num_cols;
INSERT INTO tables_dimensions (table_name, num_rows, num_cols)
	SELECT 
		'staffs' AS table_name,
		(SELECT COUNT(*) FROM staffs) AS num_rows,
		(SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_schema = 'bike_store_db' AND table_name = 'staffs') AS num_cols;
INSERT INTO tables_dimensions (table_name, num_rows, num_cols)
	SELECT 
		'stocks' AS table_name,
		(SELECT COUNT(*) FROM stocks) AS num_rows,
		(SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_schema = 'bike_store_db' AND table_name = 'stocks') AS num_cols;
INSERT INTO tables_dimensions (table_name, num_rows, num_cols)
	SELECT 
		'stores' AS table_name,
		(SELECT COUNT(*) FROM stores) AS num_rows,
		(SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_schema = 'bike_store_db' AND table_name = 'stores') AS num_cols;
SELECT * FROM tables_dimensions;

/*
	6. Detect any instances of missing data within the original tables. Then, establish a new table 
    named 'tables_missing_values.' This table will exclusively store the following details: table ID 
    numbers (referencing the 'tables_dimensions' table), along with the names of columns containing 
    missing values and the corresponding counts of such missing values. Display the completed table's
    structure and all its data. Make sure you drop any existing table with that name before creating it.
*/
SELECT COUNT(*) - COUNT(brand_id) AS mv_brand_id, 
	COUNT(*) - COUNT(brand_name) AS mv_brand_name 
    FROM brands;
SELECT COUNT(*) - COUNT(category_id) AS mv_category_id, 
	COUNT(*) - COUNT(category_name) AS mv_category_name 
    FROM categories;
SELECT COUNT(*) - COUNT(customer_id) AS mv_customer_id, 
	COUNT(*) - COUNT(first_name) AS mv_first_name,
    COUNT(*) - COUNT(last_name) AS mv_last_name,
    COUNT(*) - COUNT(phone) AS mv_phone,
    COUNT(*) - COUNT(email) AS mv_email,
    COUNT(*) - COUNT(street) AS street,
    COUNT(*) - COUNT(city) AS mv_city,
    COUNT(*) - COUNT(state) AS mv_state,
    COUNT(*) - COUNT(zip_code) AS mv_zip_code
    FROM customers;
SELECT COUNT(*) - COUNT(order_id) AS mv_order_id, 
	COUNT(*) - COUNT(item_id) AS mv_item_id,
    COUNT(*) - COUNT(product_id) AS mv_product_id,
    COUNT(*) - COUNT(quantity) AS mv_quantity,
    COUNT(*) - COUNT(list_price) AS mv_list_price,
    COUNT(*) - COUNT(discount) AS mv_discount
    FROM order_items;
SELECT COUNT(*) - COUNT(order_id) AS mv_order_id, 
	COUNT(*) - COUNT(customer_id) AS mv_customer_id,
    COUNT(*) - COUNT(order_status) AS mv_order_status,
    COUNT(*) - COUNT(order_date) AS mv_order_date,
    COUNT(*) - COUNT(required_date) AS mv_required_date,
    COUNT(*) - COUNT(shipped_date) AS mv_shipped_date,
    COUNT(*) - COUNT(store_id) AS mv_store_id,
    COUNT(*) - COUNT(staff_id) AS mv_staff_id
    FROM orders;
SELECT COUNT(*) - COUNT(product_id) AS mv_product_id, 
	COUNT(*) - COUNT(product_name) AS mv_product_name,
    COUNT(*) - COUNT(brand_id) AS mv_brand_id,
    COUNT(*) - COUNT(category_id) AS mv_category_id,
    COUNT(*) - COUNT(model_year) AS mv_model_year,
    COUNT(*) - COUNT(list_price) AS mv_list_price
    FROM products;
SELECT COUNT(*) - COUNT(staff_id) AS mv_staff_id, 
	COUNT(*) - COUNT(first_name) AS mv_first_name,
    COUNT(*) - COUNT(last_name) AS mv_last_name,
    COUNT(*) - COUNT(email) AS mv_email,
    COUNT(*) - COUNT(phone) AS mv_phone,
    COUNT(*) - COUNT(active) AS mv_active,
    COUNT(*) - COUNT(store_id) AS mv_store_id,
    COUNT(*) - COUNT(manager_id) AS mv_manager_id
    FROM staffs;
SELECT COUNT(*) - COUNT(store_id) AS mv_store_id,
	COUNT(*) - COUNT(product_id) AS mv_product_id,
    COUNT(*) - COUNT(quantity) AS mv_quantity
    FROM stocks;
SELECT COUNT(*) - COUNT(store_id) AS mv_store_id, 
	COUNT(*) - COUNT(store_name) AS mv_store_name, 
    COUNT(*) - COUNT(phone) AS mv_phone, 
    COUNT(*) - COUNT(email) AS mv_email, 
    COUNT(*) - COUNT(street) AS mv_street, 
    COUNT(*) - COUNT(city) AS mv_city, 
    COUNT(*) - COUNT(state) AS mv_state, 
    COUNT(*) - COUNT(zip_code) AS mv_zip_code
    FROM stores;
DROP TABLE IF EXISTS tables_missing_values;
CREATE TABLE tables_missing_values (
	table_id INTEGER NOT NULL,
    col_name VARCHAR(13) NOT NULL,
    mv_num INTEGER NOT NULL,
    FOREIGN KEY (table_id) REFERENCES tables_dimensions(table_id)
    ); 
INSERT INTO tables_missing_values(table_id, col_name, mv_num)
	VALUES (3, 'phone', 1267);
INSERT INTO tables_missing_values(table_id, col_name, mv_num)
	VALUES (5, 'shipped_date', 170);
INSERT INTO tables_missing_values(table_id, col_name, mv_num)
	VALUES (7, 'manager_id', 1);
DESCRIBE tables_missing_values;
SELECT * FROM tables_missing_values;

/*
	7. Create a VIEW named 'vw_combined_dims_and_mv' with combined information from the two newly created tables. Join 
    the information of the table 'tables_missing_values' with the information of the table 'tables_dimensions' using the 
    'table_id' field. The VIEW columns should be as follows:
		a. 'table_id' (from 'tables_missing_values')
        b. 'table_name' (from 'tables_dimensions')
        c. 'col_name' (from 'tables_missing_values')
        d. 'mv_num' (from 'tables_missing_values')
        e. 'num_rows' (from 'tables_missing_values')
        f. 'num_cols' (from 'tables_missing_values')
    
    After completion, display the VIEW's content. 
    
    Note: Make sure you drop any existing VIEW with that name before creating it.
*/
DROP VIEW IF EXISTS vw_combined_dims_and_mv;
CREATE VIEW vw_combined_dims_and_mv AS
	SELECT tables_missing_values.table_id, 
		tables_dimensions.table_name, 
		tables_missing_values.col_name, 
		tables_missing_values.mv_num, 
		tables_dimensions.num_rows, 
		tables_dimensions.num_cols 
		FROM tables_missing_values 
		JOIN tables_dimensions 
		ON tables_missing_values.table_id = tables_dimensions.table_id;
SELECT * FROM vw_combined_dims_and_mv;

-- Unique (distinct) values:
SELECT COUNT(DISTINCT(brand_name)) FROM brands;
SELECT DISTINCT(brand_name) FROM brands ORDER BY brand_name ASC;

SELECT COUNT(DISTINCT(category_name)) FROM categories;
SELECT DISTINCT(category_name) FROM categories ORDER BY category_name ASC;


/*
	8. Create frequency tables of the cities and states of the table 'customers'. Calculate the Mode 
    of both columns (if multiple Modes, display only one of them).
*/
-- Frequency tables:
SELECT state, COUNT(*) AS frequency FROM customers GROUP BY state ORDER BY frequency DESC;
SELECT city, COUNT(*) AS frequency FROM customers GROUP BY city ORDER BY frequency DESC;
-- Modes:
SELECT state, COUNT(*) AS frequency FROM customers GROUP BY state ORDER BY frequency DESC LIMIT 1;
SELECT city, COUNT(*) AS frequency FROM customers GROUP BY city ORDER BY frequency DESC LIMIT 1;

/* 
	9. Create a temporary table with the name 'z_prices_and_discounts' and display its structure. 
    Its columns and type should be as follows:
    
		a. idx (INTEGER AUTO_INCREMENT) <- Primary Key
        b. order_id (INTEGER NOT NULL)
        c. tot_amt_per_ord_id (FLOAT NOT NULL)
        d. tot_dis_per_ord_id (FLOAT NOT NULL)
        
	Make sure you drop any existing table with that name before creating it.
    
    Note: This temporary table will be used for the remainder exercises.
*/
DROP TEMPORARY TABLE IF EXISTS z_prices_and_discounts;
CREATE TEMPORARY TABLE z_prices_and_discounts (
	idx INTEGER AUTO_INCREMENT,
    order_id INTEGER NOT NULL,
    tot_amt_per_ord_id FLOAT NOT NULL,
    tot_dis_per_ord_id FLOAT NOT NULL,
    PRIMARY KEY (idx)
    ); 
DESCRIBE z_prices_and_discounts;

/*
	10. Insert into the temporary table 'z_prices_and_discounts' the following information
    from the table 'order_items':
    
		a. 'order_id'
        b. 'list_price'
        c. 'discount'
        
	The columns 'list_price' and 'discount' should be added as the summation of all the values
    within their respective columns by each unique 'order_id'. The 'list_price' column summation
    should be named 'tot_amt_per_ord_id' and the 'discount' column summation should have the
    name 'tot_dis_per_ord_id'. The data should be ordered by the column 'tot_amt_per_ord_id'
    before insertion.
    
    Later, display the first 10 rows of the temporary table.
*/
INSERT INTO z_prices_and_discounts(order_id, tot_amt_per_ord_id, tot_dis_per_ord_id)
	SELECT 
		order_id AS order_id, 
		SUM(list_price) AS tot_amt_per_ord_id, 
		SUM(discount) AS tot_dis_per_ord_id 
		FROM order_items 
		GROUP BY order_id ORDER BY tot_amt_per_ord_id;
SELECT * FROM z_prices_and_discounts LIMIT 10;

/*
    11. Calculate the Range of the columns 'tot_amt_per_ord_id' and 'tot_dis_per_ord_id'.
*/
-- Range calculations for the column 'tot_amt_per_ord_id':
SELECT ROUND(MIN(tot_amt_per_ord_id), 2) FROM z_prices_and_discounts INTO @amt_min;
SELECT ROUND(MAX(tot_amt_per_ord_id), 2) FROM z_prices_and_discounts INTO @amt_max;
SELECT ROUND(@amt_max - @amt_min, 2) INTO @amt_range;
SELECT @amt_min AS Amount_Min, @amt_max AS Amount_Max, @amt_range AS Amount_Range;
-- Range calculations for the column 'tot_dis_per_ord_id':
SELECT ROUND(MIN(tot_dis_per_ord_id), 2) FROM z_prices_and_discounts INTO @dis_min;
SELECT ROUND(MAX(tot_dis_per_ord_id), 2) FROM z_prices_and_discounts INTO @dis_max;
SELECT ROUND(@dis_max - @dis_min, 2) INTO @dis_range;
SELECT @dis_min AS Discount_Min, @dis_max AS Discount_Max, @dis_range AS Discount_Range;

/*
	12. Manually, calculate the mean of the 'tot_amt_per_ord_id' column?
    
    Confirm your answer is correct utilizing the AVG() MySQL built-in functions.
*/
-- Manual Mean calculation for the 'tot_amt_per_ord_id' column:
SELECT SUM(tot_amt_per_ord_id) FROM z_prices_and_discounts INTO @sum;
SET @amt_mean = @sum / @tot_observations;
SELECT @amt_mean;
-- Mean calculation for the 'tot_amt_per_ord_id' column utilizing the AVG() functions.
SELECT AVG(tot_amt_per_ord_id) FROM z_prices_and_discounts;

/*
	13. Calculate the median of the 'tot_amt_per_ord_id' column.
*/
SELECT COUNT(*) INTO @tot_observations FROM z_prices_and_discounts; -- Gets the count of observations (rows).
-- For even number of observations:
/*
	In this case, for the even numbers, I started by dividing the count of the total of
    observations number by 2. I made sure the result number will be an integer by using
    the ROUND() function.
*/
SET @mid_idx = ROUND(@tot_observations / 2, 0);
SELECT @mid_idx;
/*
	The position and value of the observation at position (n/2) were
    calculated here.
*/
SET @pre_idx = @mid_idx;
SELECT tot_amt_per_ord_id FROM z_prices_and_discounts WHERE idx = @pre_idx INTO @pre_value;
SELECT @pre_idx;
SELECT ROUND(@pre_value, 2);
/*
	In this code, the position and value of the observation at position ((n/2)+1) were
    calculated.
*/
SET @post_idx = @mid_idx + 1;
SELECT tot_amt_per_ord_id FROM z_prices_and_discounts WHERE idx = @post_idx INTO @post_value;
SELECT @post_idx;
SELECT ROUND(@post_value, 2);
/*
	Here, both the position of the median and the median where obtained by calculating
    the average (mean) of the observations at positions (n/2) and ((n/2)+1).
*/
SET @idx_even = ROUND((@pre_idx + @post_idx) / 2, 1);
SET @median_even = (@pre_value + @post_value) / 2;
SELECT @idx_even;
SELECT ROUND(@median_even, 2);
-- For odd number of observations:
/*
	For the odd numbers, I began by adding a 1 to the count of the total of
    observations number and then, I divided that number by 2. I used the ROUND() function
    to get an integer number.
*/
SET @mid_idx = ROUND((@tot_observations + 1) / 2, 0);
SELECT @mid_idx;
/*
	I obtanined the position of the median and the median by using the observation
    at the position ((n+1)/2), which is exactly the number calculated previously and named
    @mid_idx.
*/
SET @idx_uneven = @mid_idx;
SELECT tot_amt_per_ord_id FROM z_prices_and_discounts WHERE idx = @idx_uneven INTO @median_uneven;
SELECT @idx_uneven;
SELECT ROUND(@median_uneven, 2);

/*
    14. Calculate the Standard Deviation and the Variance of the columns 'tot_amt_per_ord_id' and 
    'tot_dis_per_ord_id'.
*/
-- Standard Deviation and Variace calculations for the column 'tot_amt_per_ord_id':
SELECT ROUND(STDDEV(tot_amt_per_ord_id), 2) FROM z_prices_and_discounts INTO @amt_stddev;
SELECT ROUND(VARIANCE(tot_amt_per_ord_id), 2) FROM z_prices_and_discounts INTO @amt_variance;
SELECT @amt_stddev AS Amount_Std_Dev, @amt_variance AS Amount_Variance;
-- Standard Deviation and Variace calculations for the column 'tot_amt_per_ord_id':
SELECT ROUND(STDDEV(tot_dis_per_ord_id), 2) FROM z_prices_and_discounts INTO @dis_stddev;
SELECT ROUND(VARIANCE(tot_dis_per_ord_id), 2) FROM z_prices_and_discounts INTO @dis_variance;
SELECT @dis_stddev AS Discount_Std_Dev, @dis_variance AS Discount_Variance;

/*
	15. Delete the 'bike_store_db' database from MySQL.
*/
DROP DATABASE bike_store_db;
SHOW DATABASES;


