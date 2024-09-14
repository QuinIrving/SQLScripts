/*
File:            QuinIrvingDBAS32100Assignment3-3.sql
Author:          Quin Irving
Oracle Username: S5_irvingq
Description: For each customer from London, return the price of the car they
bought and the difference between that price and the average price of the cars
sold in that city. (5 marks)
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

SELECT
    c.custname
    ,s.carsaleprice
    ,( s.carsaleprice - AVG(s.carsaleprice)
                         OVER() ) AS customer_vs_cityaverage
FROM
         customer c
    INNER JOIN saleinv s
    ON c.custname = s.custname
WHERE
    lower(c.custcity) = 'london';

/*
----------------------- Output begins ------------------------
CUSTNAME                  CARSALEPRICE              CUSTOMER_VS_CITYAVERAGE
------------------------- ------------------------- -------------------------
STEPHEN BALINT	          84354.4	                -1464.902
KANISHK SAHNI	          37895.68	                -47923.622
NICK ROSE	              75096.43	                -10722.872
NADINE MIDANY	          113750	                27930.698
JOON AN	                  118000	                32180.698

5 rows selected.
----------------------- Output ends   ------------------------
*/