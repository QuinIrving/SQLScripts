/*
File:            QuinIrvingDBAS32100Assignment3-2.sql
Author:          Quin Irving
Oracle Username: S5_irvingq
Description: Using analytic functions return the name of only the customer who
bought the fourth most expensive car. (5 marks)
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

SELECT DISTINCT
    NTH_VALUE(custname, 4)
    OVER(
        ORDER BY
            carsaleprice DESC
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS customer
FROM
    saleinv;

/*
----------------------- Output begins ------------------------
CUSTOMER                           
-------------------------
JAMES BARREDO

1 rows selected.
----------------------- Output ends   ------------------------
*/