-- START OF FILE ================================================================
--
--		    ============================
--
--          MICE CINEMAS -- ASSIGNMENT 2
--
--          ============================
--
-- TASK ONE - Insertion of data ( 3 parts )
-- TASK TWO - Queries ( 12 in total )
--
-- PLESE READ THIS DOCUMENT CAREFULLY.
-- -----------------------------------
--
-- BEFORE YOU START you must check you have completed the following:
-- 
--  0 Download MICE_Table_and_Data.sql from CANVAS. It is available
--    from the assignment description window
--  0 Upload and run script (F5) on MICE_Table_and_Data.sql in an
--    SQL Developer worksheet.
--    You should see the following output:
--
-- Dropping Tables ...
-- Create Tables ...
--  ... A2_CINEMA
--  ... A2_STAFF
--  ... A2_CINEMA (FK Manager added)
--  ... A2_SCREEN
--  ... A2_FILM
--  ... A2_SHOWING
--  ... A2_PERFORMANCE
 
-- All tables created.

-- Populate Tables ...
--  ... A2_Cinema
--  ... A2_Staff
--  ... A2_Film
--  ... A2_Screen
--  ... A2_Showing
--  ... A2_Performance
--
-- All tables populated.
--
--  0 Confirm that 6 new tables exist all starting in A2_ and they contain data
--
--  0 PLEASE NOTE: all tables referenced in your inserts and queries must start
--    with A2_ . This distinguishes them from previous tables and they all appear
--    in a group on the SQL Developer connections window.
--
--  0 Check each table contains data records. The number of records in each is
--    given above as reported when running MICE_Table_and_Data.sql.
--
--  0 ONLY once you are happy with the tables and data, should you progress to
--    the two tasks:
--
--
-- TASK ONE - ADDING DATA - 16 marks in total
-- ======================
--
-- You must add the following data to that already inserted into the 6 table
-- schema.
-- DO NOT remove any existing records
--
-- ADD the following:
--
--  1 - Create a yourself as a member of staff which includes your name and where
--      the Employee_No is  your SRN. The remaining attributes can be data you make
--      up. There should be no duplication between your SRN and the data in the
--      dataset, but if this does occur, add 1 to your SRN.
--      You can choose which cinema you are employed at unsupervised!!
--                                                                  [ 4 marks ]
--
--  2 - Create two showings at a cinema and screen of your choice from the database.
--
--      Showing 1 MUST contain a single performance of a new film you must also add
--      to the film table. 
--						  						                    [ 6 marks ]
--
--  3 - Showing 2 MUST contain three performances of a film already in the
--      database showing on consecutive days.
--								  				                    [ 6 marks ]
--
--
--  NOTES:
--	Its a good idea to store your final INSERT commands in a script file
--
--	If during this process, you corrupt the dataset, go back and use the
--      script downloaded to reset the original tables and data
--
--	Once you are happy ALL INSERTS are correct, it may be a good idea to
--      run the two scripts ( supplied and yours) again to refresh the
--      dataset before starting Task 2
--
-- END OF ASSIGNMENT TASK ONE ----------------------------------------------------
--
--
-- TASK TWO - QUERYING  [ 7 marks per query ] 84 in total
-- ===================
--
-- For this task use SQL Developer to build queries that provide the correct
-- answer to the question asked. Once the query is correct, COPY THE CODE INTO
-- THE SPACES PROVIDED. Answer as many questions if you can.
--
-- Hints are provided to help you understand what is needed
--
-- Solution Tests indicate how the output should appear if correct and contains
-- formatting guidance.
--
-- Submission instructions are given at the end of this file.
--
--
-- QUESTION 1
-- ==========
--
-- Produce a list of film names which have a date of release this century.  
-- 
-- Solution Test: 6 Films meet this criteria
--
-- FILM_NAME                                                                       
-- ---------------------------
-- Black Panther
-- Parasite
-- Avengers: Endgame
-- Knives Out
-- Us
-- Get Out
--
-- Type your query below:

 SELECT Film_Name, Year_Released 
 FROM A2_Film
 WHERE Year_Released >= '01-JAN-2000' ;


-- QUESTION 2
-- ==========
--
-- Use a nested select statement to provide the full name and adress details of the cinemas
-- managed by the staff called Claire Wilson and Coren O'Halloran (DO NOT manually lookup
-- their Employee Numbers.)
-- 
-- Solution Test: 
-- CINEMA_NAME                                        LOCATION                                                                                            
-- -------------------------------------------------- -----------------------------------
-- The Glory Showhouse                                16, Leevale Drive, Linton                                                                           
-- Masterton Multiplex                                11, High Street, Masterton
--
-- Type your query below:

SELECT cinema_name,location
FROM a2_cinema
WHERE manager IN
        (SELECT employee_no
         FROM a2_staff
         WHERE name IN ('Claire Wilson','Coren O''Halloran'));



-- QUESTION 3
-- ==========
--
-- Lec Dombrovski has phoned in sick, Create a query to report the name and phone
-- number of his supervisor.
--
-- Solution Test: 
-- NAME                                      PHONE_NO   
-- ----------------------------------------- -----------
-- Petr Cillich                              04992730026
--
-- Type your query below:

SELECT name,phone_no
FROM a2_staff
WHERE employee_no =
        (SELECT supervisor
         FROM a2_staff
         WHERE name = 'Lec Dombrovski');


-- QUESTION 4
-- ==========
--
-- Write a report of all films shown in August 2021 more than 16 times, give the films name,
-- how many performances of these films there were and how much those films took in total
-- over that period. List the films by the film that took the most money first, and provide
-- meaningful headings to the columns in the output as shown in the Solution Test below.
--
-- Hint: 
--
-- Solution Test:

-- FILM_NAME                   Performances Total Takings         
-- --------------------------- ------------ ----------------------
-- It Happened One Night       39               �63,571 
-- Modern Times                38               �58,332 
-- Parasite                    23               �37,195 
-- Knives Out                  22               �34,362 
-- Citizen Kane                25               �32,711 
-- The Wizard of Oz            18               �21,716 
-- Avengers: Endgame           18               �17,081
--
-- Type your query below:

SELECT a2_film.film_name, COUNT(A2_FILM.FILM_NAME) AS PERFORMANCES, '�' || SUM(A2_PERFORMANCE.TAKINGS) AS TOTAL_TAKINGS
FROM A2_PERFORMANCE JOIN A2_SHOWING ON (A2_PERFORMANCE.SHOWING_NO = A2_SHOWING.SHOWING_NO)
JOIN A2_FILM ON (A2_SHOWING.FILM_NO = A2_FILM.FILM_NO)
WHERE A2_PERFORMANCE.PERFORMANCE_DATE BETWEEN '01-AUG-21' AND '31-AUG-21'
GROUP BY a2_film.film_name
HAVING COUNT(A2_FILM.FILM_NAME) > 16
ORDER BY TOTAL_TAKINGS DESC;




-- QUESTION 5
-- ==========
--
-- Report how much each cinema took on the 12th August, the report should
-- include the name of the cinema and the value of the takings in the report.
-- Order by highest takings first. The output should also be formatted as
-- shown below.
--
-- Cinema                         Takings on August 12  
-- ------------------------------ ----------------------
-- Masterton Multiplex            �5,731 
-- The Glory Showhouse            �2,424 
-- Grange Cinema                  �1,974 
-- Treban Picturehouse            �1,719 
-- Marvale Rex                    �1,005
--
-- Hint: Use the format operator (L) to create the use of the �
-- symbol.
--
-- Solution Test: 
--
-- Type your query below:

SELECT A2_SHOWING.CINEMA, '�' || SUM(A2_PERFORMANCE.TAKINGS) AS TAKINGS_ON_AUGUST_12 
FROM A2_PERFORMANCE JOIN A2_SHOWING 
ON (A2_PERFORMANCE.SHOWING_NO = A2_SHOWING.SHOWING_NO)
WHERE A2_PERFORMANCE.PERFORMANCE_DATE = '12-AUG-21'
GROUP BY A2_SHOWING.CINEMA
ORDER BY TAKINGS_ON_AUGUST_12 DESC;



-- QUESTION 6
-- ==========
--
-- List the age in years of the oldest employee at each cinema. Order the report by the
-- cinema with the most employees first. Output should be formatted as below.
--
-- Hint: Use the examples in the SQL Sessions to determine the age in years of staff.
--
-- Solution Test:   
--
-- Cinema                                              Oldest Employee
-- -------------------------------------------------- ----------------
-- Masterton Multiplex                                              56
-- Grange Cinema                                                    48
-- The Glory Showhouse                                              52
-- Marvale Rex                                                      62
-- Odeon on the Hill                                                61
-- Flix                                                             57
-- Treban Picturehouse                                              34
--
-- Type your query below:

SELECT CINEMA, MAX(TRUNC(MONTHS_BETWEEN(SYSDATE,DOB)/12)) AS Oldest_Employee
FROM A2_STAFF
GROUP BY CINEMA
ORDER BY COUNT(CINEMA) DESC;


-- QUESTION 7
-- ==========
--  
-- Which were the showings with the most performances? In which cinema were,
-- they shown, on which screen and how many performances were there starting
-- on which date. Format the output as given below:
--
-- Hint: Reserach the formatting operators fm and th
--
-- Solution Test: 
--
-- Cinema                                                 Screen Performances Started on                                                                     
-- -------------------------------------------------- ---------- ------------ -------------------------------------------------------------------------------
-- Marvale Rex                                                 1            9 Friday, September 3rd                                                          
-- Treban Picturehouse                                         2            9 Monday, August 9th                                                             
-- Treban Picturehouse                                         1            9 Monday, September 20th                                                         
-- Odeon on the Hill                                           2            9 Sunday, August 15th
--
-- Type your query below:

SELECT A2_SHOWING.CINEMA, A2_SHOWING.SCREEN,COUNT(a2_performance.showing_no) AS PERFORMANCES
FROM A2_PERFORMANCE JOIN A2_SHOWING 
ON (A2_PERFORMANCE.SHOWING_NO = A2_SHOWING.SHOWING_NO) 
group by A2_SHOWING.CINEMA, A2_SHOWING.SCREEN 
HAVING COUNT(a2_performance.performance_date)>8
ORDER by A2_SHOWING.CINEMA;


-- QUESTION 8
-- ==========
--  
-- Produce a report for all showings of "Casablanca", providing the film name,
-- in which cinema each showing took place and the takings per seat available
-- and takings per person attending.
--
-- Hint: Use the total takings and the total capacity to determine the average
--       not the AVG function. Use formatting to limit the decimal places to 2.
--
-- Solution Test: 
-- FILM_NAME  CINEMA                                             Takings per seat Takings per person   
-- ---------- -------------------------------------------------- ---------------- ------------------
-- Casablanca Marvale Rex                                                   �9.62             �12.81 
-- Casablanca The Glory Showhouse                                          �12.14             �12.67 
-- Casablanca Treban Picturehouse                                          �10.87             �13.31 
-- Casablanca Grange Cinema                                                �15.02             �19.25 
--
-- Type your query below:

SELECT A2_FILM.FILM_NAME, A2_SHOWING.CINEMA, CAST(SUM(A2_PERFORMANCE.TAKINGS)/SUM(A2_SCREEN.CAPACITY) AS DECIMAL(16, 2)) AS TAKINGS_PER_SEAT,
CAST(SUM(A2_PERFORMANCE.TAKINGS)/SUM(A2_PERFORMANCE.ATTENDEES) AS DECIMAL(16, 2)) AS TAKINGS_PER_PERSON
FROM A2_PERFORMANCE JOIN A2_SHOWING
ON (A2_PERFORMANCE.SHOWING_NO = A2_SHOWING.SHOWING_NO)
JOIN A2_FILM ON (A2_SHOWING.FILM_NO = A2_FILM.FILM_NO)
JOIN A2_SCREEN ON (A2_SHOWING.CINEMA = A2_SCREEN.CINEMA AND A2_SHOWING.SCREEN = A2_SCREEN.SCREEN)
WHERE A2_FILM.FILM_NAME = 'Casablanca'
GROUP BY A2_SHOWING.CINEMA, FILM_NAME;



-- QUESTION 9
-- ==========
--
-- Write a query to list the cinema names of all cinemas which employ more than 12 employees.
-- 
-- Solution Test: 
--
-- CINEMA_NAME                                   Number of Staff
-- --------------------------------------------- ---------------
-- Grange Cinema                                              20
-- Masterton Multiplex                                        27
-- The Glory Showhouse                                        15
--
-- Type your query below:

SELECT CINEMA AS CINEMA_NAME, COUNT(NAME) AS NUMBER_OF_STAFF
FROM A2_STAFF
GROUP BY CINEMA
HAVING COUNT(NAME) > 12;


-- QUESTION 10, 11, 12
-- ===================
-- Write three queries to provide information about YOU and YOUR orders from
-- Task 1
-- 
-- 10
-- ==
--
-- Create a single line report containing YOUR details as entered on the database
-- in the following format:
--
-- Fullname                        Address                                                   Employed for                                                                       
-- ------------------------------- --------------------------------------------------------- ---------------------------
-- Leon Marvin                     The Marches, Teal Avenue, Lindon                          9y 10m                                                                             
--	Fullname         Address                              Employed for                                                                    
--
-- Where 9y 10m indicates you has been employed for 9 complete years
-- plus 10 complete months at the time the query is run
--
-- Hint: 
--
-- https://docs.oracle.com/cd/E11882_01/server.112/e41084/functions002.htm#SQLRF51178
--
-- Type your query below:

SELECT NAME, ADDRESS, TRUNC(MONTHS_BETWEEN(SYSDATE, DATE_JOINED)/12) || 'y ' || MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, DATE_JOINED)),12) || 'm' 
AS "Employeed for"
FROM A2_STAFF
WHERE NAME = 'Rishiraj Tripathi';



--
-- 11
-- ==
--
-- Write a query to output the details of single film performance onput in
-- Task 1 part 2.
-- The details needed are the film name, and the cinema, screen, and date and
-- time it is being shown.
--
-- The headings and details should be meaningful to any reader of the report.
-- I.e.
--
-- Film Title                            Cinema                                Screen Date              Time 
-- ------------------------------------- ------------------------------------- ------ ----------------- -----
-- Modern Times                          Grange Cinema                         2      Wed 01-Sep-2021   08:15
--
-- Hint: 
--
-- Type your query below:

SELECT A2_FILM.FILM_NAME AS FILM_TITLE, A2_SHOWING.CINEMA, A2_SHOWING.SCREEN, A2_PERFORMANCE.PERFORMANCE_DATE, A2_PERFORMANCE.PERFORMANCE_TIME
FROM A2_PERFORMANCE JOIN A2_SHOWING
ON (A2_SHOWING.SHOWING_NO = A2_PERFORMANCE.SHOWING_NO)
JOIN A2_FILM ON (A2_FILM.FILM_NO = A2_SHOWING.FILM_NO)
WHERE A2_PERFORMANCE.SHOWING_NO = '183633';




--
-- 12
-- ==
--
-- Write a query to output the details of the three night showing you entered as shown
-- below.
--
-- Showin Film Title            Cinema          Screen First Night    Last Night                                          
-- ------ --------------------- --------------- ------ -------------- ---------------
-- 183557 Knives Out            Grange Cinema        3 Fri August 6  Sun August 8                                    
--
-- Hint: 
--
-- Type your query below:

SELECT A2_FILM.FILM_NAME AS FILM_TITLE, A2_SHOWING.CINEMA, A2_SHOWING.SCREEN, A2_PERFORMANCE.PERFORMANCE_DATE AS FIRST_NIGHT
FROM A2_PERFORMANCE JOIN A2_SHOWING
ON (A2_SHOWING.SHOWING_NO = A2_PERFORMANCE.SHOWING_NO)
JOIN A2_FILM ON (A2_FILM.FILM_NO = A2_SHOWING.FILM_NO)
WHERE A2_PERFORMANCE.SHOWING_NO = '183612';




-- END OF ASSIGNMENT TASK TWO ---------------------------------------------------

-- SUBMISSION REQUIREMENTS
-- =======================
--
-- Once your queries are tested and the final code placed in the file above in
-- the appropriate places, the following should be done in order to meet the
-- submission requirements.
--
-- MARKS WILL BE DEDUCTED FOR FAILURE TO FOLLOW THESE INSTRUCTIONS.
--
--  1  Rename this file in the following format:
--
--			aa99aaa-Ass2.sql
--
--     where the aa99aaa is replaced by YOUR Oracle username
--
--  2  Open this file in an SQL Worksheet in SQL Developer, clear the Script
--     Output window using the eraser icon, and ensure your 6 table schema is
--     correct and includes your entered data.
--
--  3  Use the "Run Script (F5)" icon (sheet of paper with small green triangle)
--     to run your script completely. Ensure all commands are run.
--
--  4  Save the Script Output text by clicking on the floppy disk icon, use the
--     popup window to save the file as aa99aaa-Ass2.txt, again relacing aa99aaa
--     with your username.
--
--  5  Double check both the aa99aaa-Ass2.sql and aa99aaa-Ass2.txt files, then
--     upload them onto CANVAS in the Assignment 2 point.
--
--  6  Congratualations, you are done!
--
-- END OF FILE ==================================================================



