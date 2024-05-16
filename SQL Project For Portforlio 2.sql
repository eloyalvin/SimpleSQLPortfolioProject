/* 
	SQL Portfolio Project II
	Utilizing MySQL and MySQL Workbench
	Created by Eloy Alvin Luna 
	Published on April 19, 2024

	SQL Portfolio Project II, Utilizing MySQL and MySQL Workbench © 2024 by 
	Eloy Alvin Luna is licensed under Creative Commons Attribution-NonCommercial 
	4.0 International.

	Note: The database utilized here was obtained from 
   	https://www.kaggle.com/datasets/bhavikjikadara/student-study-performance 
	on Thursday, April 11, 2024 (CT).
    
	The owner of the database is Bhavik Jikadara and it was published under the 
	license CC BY 4.0 DEED Attribution 4.0 International.
*/


/* 1. Displaying a list of all existing databases.
*/
SHOW DATABASES;

/* 2. Create a new database and a new table as follows:
		a. The name of the new database should be 'for_practice_db'.
		b. The table should be named 'study_performance'. The column's names and data type should be:
*/
CREATE DATABASE for_practice_db;
SHOW DATABASES;
USE for_practice_db;
CREATE TABLE study_performance (
	study_performance_id INTEGER AUTO_INCREMENT,
	gender VARCHAR(6) NOT NULL, 
	race_ethnicity VARCHAR(7) NOT NULL, 
	parental_level_of_education VARCHAR(18) NOT NULL, 
	lunch VARCHAR(12) NOT NULL, 
	test_preparation_course VARCHAR(9) NOT NULL, 
	math_score INTEGER,  
	reading_score INTEGER, 
	writing_score INTEGER,
    PRIMARY KEY (study_performance_id)
    );
SHOW TABLES;

/* 3. Using MySQL Workbench:
		a. Import the data from the Comma-Separated Value file named 'study_performance.csv'.
		b. The data from that file needs to be added to the table 'study_performace' (that was 
        previously created) under the database 'for_practice_db'.
		c. Demonstrate these procedures with pictures.
*/
-- For the answer of question 3, see the pdf presentation.

/* 4. Create a View, which is essentially a virtual table generated based on a specified query, distinct 
from a Temporary Table:
		a.Create a view named 'test_results' containing the scores for math, reading, and writing, along 
        with the Study Performance ID. 
		b. Afterwards, provide visual representations, including screenshots of the view's schema and the 
        first five rows of data.
*/
CREATE VIEW test_results AS SELECT study_performance_id, math_score, 
	reading_score, writing_score FROM study_performance;
SHOW tables;
DESCRIBE test_results;
SELECT * FROM test_results LIMIT 5;

/* 5. Create two new users for the 'for_practice_db' database:
		a. Both of these users should only have access to the database named 'for_practice_db'.
		b. The firs user's name is Marie Hayes and should have all privileges to that database. Use the 
        default password of 'Welcome01'.
		c. The second user's name is Oscar Castro. He should only have the privileges of viewing the 
        tables and 'views' and to do queries. Use the same default passwords for this user too.
		d. Force the users to change their password upon login.
*/
USE mysql;
SELECT * FROM user;
-- Creates the user 'marie_hayes' with the default password 'Welcome01':
CREATE USER 'marie_hayes'@'localhost' IDENTIFIED BY 'Welcome01';
ALTER USER 'marie_hayes'@'localhost' PASSWORD EXPIRE;
GRANT ALL PRIVILEGES ON for_practice_db.* TO 'marie_hayes'@'localhost';
FLUSH PRIVILEGES;
SELECT * FROM user;
SHOW GRANTS FOR 'marie_hayes'@'localhost';
-- Creates the user 'oscar_castro' with the default password 'Welcome01':
CREATE USER 'oscar_castro'@'localhost' IDENTIFIED BY 'Welcome01';
ALTER USER 'oscar_castro'@'localhost' PASSWORD EXPIRE;
GRANT SELECT, SHOW VIEW ON for_practice_db.* TO 'oscar_castro'@'localhost';
FLUSH PRIVILEGES;
SELECT * FROM user;
SHOW GRANTS FOR 'oscar_castro'@'localhost';

/* 6. Remove all Oscar's privileges and delete his user account from MySQL. 
*/
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'oscar_castro'@'localhost';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'oscar_castro'@'localhost';
-- Delete the user 'oscar_castro':
DROP USER 'oscar_castro'@'localhost';
SELECT * FROM user;

/* 7. Create a backup of the 'for_practice_db' database as follows:
		a. All tables, including Views, will need to be part of the backup.
		b. Export it as a Self-Contained file with the file extension sql.
		c. Include Create Schema and the some must be in a single transaction.
		d. Lastly, delete the 'for_practice_db' database from MySQL.
*/
-- For the answers of question 7.a, 7.b, and 7.c, see the pdf presentation.
DROP DATABASE for_practice_db;
SHOW DATABASES;
