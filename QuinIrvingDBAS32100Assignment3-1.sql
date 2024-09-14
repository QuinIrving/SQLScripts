/*
File:            QuinIrvingDBAS32100Assignment3-1.sql
Author:          Quin Irving
Oracle Username: S5_irvingq
Description: Using analytic functions (also known as windowing functions),
display the highest and the lowest carsaleprice for each car make in SI database 
and show them in descending order based on the highest price. (5 marks)
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
    c.carmodel
    ,MIN(s.carsaleprice) KEEP(DENSE_RANK FIRST ORDER BY s.carsaleprice)
    OVER(PARTITION BY c.carmodel) AS lowest
    ,MAX(s.carsaleprice) KEEP(DENSE_RANK LAST ORDER BY s.carsaleprice)
    OVER(PARTITION BY c.carmodel) AS highest
FROM
         saleinv s
    INNER JOIN car c
    ON s.carserial = c.carserial
ORDER BY
    highest DESC;

/*
----------------------- Output begins ------------------------
CARMODEL                  LOWEST                    HIGHEST             
------------------------- ------------------------- -------------------------
CLA	                      27590.44	                466700
AAA	                      391300	                391300
SL	                      15000	                    367095.57

<117 rows removed...>

JAGUAR	                  500	                    500
S600	                  500	                    500
SL1	                      500	                    500

123 rows selected.
----------------------- Output ends   ------------------------
*/