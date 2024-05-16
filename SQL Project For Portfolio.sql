/* 
	SQL Portfolio Project I
	Utilizing MySQL and MySQL Workbench
	Created by Eloy Alvin Luna 
	Published on April 1, 2024

	SQL Portfolio Project I, Utilizing MySQL and MySQL Workbench © 2024 by 
	Eloy Alvin Luna is licensed under Creative Commons Attribution-NonCommercial 
	4.0 International.

	Note: The database utilized here was obtained from 
   	https://www.kaggle.com/datasets/rizwanali324/clinic-case-study-dataset 
    	on Monday, March 11, 2024 (CT).
    
    	The owner of the database is Rizwan Ali, and it was published under the license 
	CC0: Public Domain license.

*/

SHOW DATABASES;
USE clinic_analysis_db;
/*
	1. What are the names of the tables within the 'clinic_analysis_db' database?
*/
SHOW TABLES;
/*
	2. Using SQL commands, could you present the structure for each table in the database?
*/
Describe appointment;
Describe doctor;
DESCRIBE medication;
Describe patient;
Describe prescription;
Describe speciality;
/* 
	3. What are the Primary Keys (PK) and Foreign Keys (FK) for each table in the database? 
*/
-- See the pdf slide presentation in my e-portfolio.

/* 
	4. Generate an Entity-Relationship Diagram (ERD) for this database schema. 
*/
-- See the pdf slide presentation in my e-portfolio.

/* 
	5. Using SQL commands only, retrieve the count of rows and columns of each table from 
the database. Demonstrate the procedure for one table. 
*/
-- See the pdf slide presentation in my e-portfolio for a completed table with the count 
-- for all tables.
SELECT COUNT(*) FROM speciality; -- Count of rows for the 'speciality' table.
SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_schema = 'clinic_analysis_db' 
AND table_name = 'speciality'; -- Count of columns for the 'speciality' table.

/* 
	6. Get the count of the unique values of one column of any of the tables. Display 
a few of those values. 
*/
SELECT COUNT(DISTINCT manufacturer) FROM medication; -- Count of unique medications within the 'medication' table.
SELECT DISTINCT manufacturer FROM medication; -- List of unique medications within the 'medication' table.

/* 
	7. Create a table named "reminders" to track appointment reminder letters sent to patients. 
Its Primary Key will be "reminder_id" and Foreign Keys will be "appointment_id" (from the 
appointment table), "patient_id" (from the patient table), and "doctor_id" (from the doctor table). 
Also, add columns to track if the letters were sent or not, the date the letters were sent (if they
 were), and for notes made by the clinic personnel. Show the code used to create the table and 
 its structure. 
*/
CREATE TABLE reminders (
	reminder_id INTEGER AUTO_INCREMENT,
    appointment_id INTEGER NOT NULL,
    patient_id INTEGER NOT NULL,
    doctor_id INTEGER NOT NULL,
    shipped BOOLEAN NOT NULL,
    shipment_date DATE,
    notes TEXT,
    PRIMARY KEY (reminder_id),
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
    ); -- Creates the 'reminders' table.
DESCRIBE reminders; -- Displays the structure of the table 'appointment'.

/* 
	8. Insert a new appointment entry to the 'appointment' table and update the 'reminders' table for a letter 
sent to the patient. The patient is Henry Jackson (Patient ID 50) and he will be seen by Doctor Victoria 
Davis (Doctor ID 30). The appointment date will be on May 2, 2024 at 9:35 am and it will be for an annual 
checkup. The reminder letter was sent to the patient on March 28, 2024, to the address on file at 789 Pine 
Rd in Western Australia. Show the code used to edit the tables and the respective entries in each table. 
*/
INSERT INTO appointment (patient_id, doctor_id, appointment_date, notes)
	VALUES (50, 30, '2024-05-02 09:35:00', 'Annual checkup'); -- Inserting the new value into the 'appointment' table.
SELECT * FROM appointment ORDER BY appointment_date DESC; -- Displaying the new entry by ordering the table by the appointment dates in descending order. 
INSERT INTO reminders (appointment_id, patient_id, doctor_id, shipped, shipment_date, notes)
	VALUES	(234, 50, 30, TRUE, '2024-03-28', 'Sent to home on file at 789 Pine Rd in Western Australia'); -- Inserting the new value into the 'reminders' table.
SELECT * FROM reminders; -- Shows the entries in the 'reminders' table.

/* 
	9. The clinic personnel forgot to include something in the notes for the letter sent with the reminder 
ID 1 and they want to add it now before they forget about it. Add the following to the end of the note: 
'List of medication requested'. Show the code used to edit the table and the entry with the changes done. 
*/
UPDATE reminders SET notes = CONCAT(notes, ' List of medication requested.') WHERE reminder_id = 1; -- Concatenate the new text at the end of the note.
SELECT * FROM reminders; -- Shows the entries in the 'reminders' table.

/* 
	10. You were told by the General Manager of the clinic that they would like to include the patient's 
doctor's telephone number in the reminder letter and that they want to track which numbers were given 
to the patients in the reminder letters. The General Manager instructed you to add a field for the 
'area code' and another for the 'telephone number'. Add two new columns to the 'reminders' table with 
the names 'area code' and 'telephone', and set their Data Type as integer. Show the code used to edit 
the table and display its new structure. 
*/
ALTER TABLE reminders ADD (area_code INTEGER, telephone_number INTEGER); -- Alters the table 'reminders' by adding the two new columns.
SELECT * FROM reminders; -- Shows the entries in the 'reminders' table.

/* 
	11. During a meeting it was determined that the column for the area code was not needed any longer 
and that the telephone numbers should be recorded as some type of text instead of as integer. Do the 
necessary changes to the 'reminders' table to meet the previous mentioned requirements. Limit the 
telephone numbers to 10 characters. Show the code used to edit the table and display its new structure. 
*/
ALTER TABLE reminders DROP COLUMN area_code; -- Removes the 'area_code' column from the 'reminders' table.
ALTER TABLE reminders MODIFY telephone_number VARCHAR(10); -- Modifies the data type of the 'telephone_number' column.
DESCRIBE reminders; -- Displays the structure of the table 'appointment'.

/* 
	12. After further consideration, it was decided that they clinic won't need a table to keep track of letters 
sent as appointment reminders. Delete the table named "reminders" from the database. Show the code used and 
the tables of the database before and after the deletion. 
*/
SHOW tables; -- Displays all the tables in that database.
DROP TABLE reminders; -- Removes the 'reminders' table from the database 'clinic_analysis_db'.
SHOW tables; -- Displays all the tables in that database.
