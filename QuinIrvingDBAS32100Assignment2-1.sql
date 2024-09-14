/*
File:            QuinIrvingDBAS32100Assignment3-1.sql
Author:          Quin Irving
Oracle Username: S5_irvingq
Description: 
*/

SET LINESIZE 132  
-- controls where lines wrap
SET PAGESIZE 255
-- controls how often headers appear
SET SERVEROUTPUT ON
-- enables dbms_output.put_line results
SET VERIFY ON
-- enables old:/new: substitution results
SET FEEDBACK ON
-- provides feedback like records selected
/*
CREATE OR REPLACE PROCEDURE campus_rooms (
    pl_campus_id IN campus.campus_id%TYPE
  , v_rooms      OUT NUMBER
  , v_capacity   OUT NUMBER
  , v_average    OUT NUMBER
) AS
BEGIN
    SELECT
        COUNT(rl.room_no)
      , SUM(r.capacity)
      , AVG(r.capacity)
    INTO
        v_rooms
    , v_capacity
    , v_average
    FROM
             roomlocation rl
        INNER JOIN room r
        ON rl.room_no = r.room_no
    WHERE
        rl.campus_id = pl_campus_id
    GROUP BY
        rl.campus_id;

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line(pl_campus_id || ' not found');
    WHEN OTHERS THEN
        dbms_output.put_line('An unknown error occurred');
END;
/
*/

/*
Using analytic functions (also known as windowing functions), display 
the highest and the lowest carsaleprice for each car make in SI database 
and show them in descending order based on the highest price. (5 marks)
*/
/*
 -----
 SELECT c.carmodel,
    FIRST_VALUE(s.carsaleprice) OVER(
        PARTITION BY c.carmodel
        ORDER BY s.carsaleprice
    ) AS lowest
FROM saleinv s INNER JOIN car c ON s.carserial = c.carserial
ORDER BY s.carsaleprice DESC;
 ----
*/
/* ----- WORKS AS WELL------ USE THIS BOTTOM ONE
SELECT DISTINCT c.carmodel,
    MIN(s.carsaleprice) KEEP (DENSE_RANK FIRST ORDER BY s.carsaleprice) OVER(
          PARTITION BY c.carmodel
       ) AS lowest,
       MAX(s.carsaleprice) KEEP (DENSE_RANK LAST ORDER BY s.carsaleprice) OVER(
          PARTITION BY c.carmodel
       ) AS highest
FROM saleinv s INNER JOIN car c ON s.carserial = c.carserial
ORDER BY highest DESC;
*/
/*
Using analytic functions return the name of only the customer who bought
the fourth most expensive car. (5 marks)
*/

/* Get NTH_VALUE to get the 4th value of MAX of a carsale price I guess */
/* saleinv only? */
/*
 SELECT c.carmodel,
    FIRST_VALUE(s.carsaleprice) OVER(
        PARTITION BY c.carmodel
        ORDER BY s.carsaleprice
    ) AS lowest
FROM saleinv s INNER JOIN car c ON s.carserial = c.carserial
ORDER BY s.carsaleprice DESC;
*/
/*
------- WORKS DOWN HERE!!!---
SELECT DISTINCT NTH_VALUE (custname, 4)
    OVER(
        ORDER BY carsaleprice DESC
        RANGE BETWEEN
            UNBOUNDED PRECEDING AND
            UNBOUNDED FOLLOWING
    ) AS Customer
FROM saleinv;
*/
/*
For each customer from London, return the price of the car they bought
and the difference between that price and the average price of the cars
sold in that city. (5 marks)
*/

/* Get average price of cars for each city, get customers purchase,  
then just customers purchase - average price of cars at the city that
the customer purchased that car*/
/* Customer and saleinv*/

/*
---- THIS ONE BELOW WORKS!!!! -----
SELECT c.custname, s.carsaleprice,
    (s.carsaleprice - AVG(s.carsaleprice) OVER (
    )) AS Customer_VS_CityAverage
FROM customer c INNER JOIN saleinv s ON c.custname = s.custname
WHERE Lower(c.custcity) = 'london'
ORDER BY c.custcity;
*/

/*
Options table is frequently used in queries that require optiondesc
as part of the condition. For example:
SELECT * FROM options WHERE optiondesc LIKE '%ROOF%';
Create an index that will improve the performance of this query. 
You can copy the table and the data from si.options table to test your 
code. Submit (a) the code used for copying the table and the data,
(b) the code for creating the index, and (c) the query performance with
and (d) without index as well as (e) the results of your code execution
and testing. You will have to use command line statements for explaining
the plan and displaying it to be able to print the results on the console
for copying. (5 marks)
*/

/*  
Function-based index?
*/
/* creates a copy of the si.options table (A)
CREATE TABLE i_options AS SELECT * FROM si.options;
*/

/* (B)
CREATE INDEX optiondesc_idx ON i_options(optiondesc);
*/

/* (C)
SELECT * FROM i_options WHERE optiondesc LIKE '%ROOF%';
(with index), cardinality 1,1,1, cost 2,2,1 TO DISPLAY USE table display explain plan stuff?
*/
/*
EXPLAIN PLAN FOR
SELECT * FROM i_options WHERE optiondesc LIKE '%ROOF%';

SELECT * FROM TABLE(dbms_xplan.display());
*/

/* (D)
DROP INDEX optiondesc_idx;
SELECT * FROM i_options WHERE optiondesc LIKE '%ROOF%';
(without index), cardinality 4,4, cost 3,3

DROP INDEX optiondesc_idx;

EXPLAIN PLAN FOR
SELECT * FROM i_options WHERE optiondesc LIKE '%ROOF%';

SELECT * FROM TABLE(dbms_xplan.display());
*/

/* (E)
*/


/*
Place all the SQL code that would perform the above written steps
(in 4) in one single file and run it as a single transaction.
Submit the results of the whole transaction. (5 marks)
The transaction output must do the following:
Remove the table (this step will allow you to run your transaction
multiple times without errors. Comment it out when you run the
transaction the first time)
Create the table and copy the data from si.options
Explain plan command for the query shown in the previous question.
Display the plan
Create index for optiondesc column
Explain plan command for the query shown in the previous question.
Display the plan
*/

/* */

/*
----------------------- Output begins ------------------------
PL/SQL procedure successfully completed.
----------------------- Output ends   ------------------------
*/