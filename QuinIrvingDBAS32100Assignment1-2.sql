/* 
File Name: QuinIrvingDBAS32100Assignment1-2.sql
My Name: Quin Irving
Oracle User Name: S5_irvingq
Question 2: SI schema contains customers that have bought one or more vehicles.
They must be classified using the following criteria:
    a. Customers that have bought only one car (Silver level)
    b. Customers that have bought two cars (Gold level)
    c. Customers that have bought more than two cars (Platinum level)
Using a single SELECT statement, display a list of customer names and what type
of buyer they are for all those customers that have bought Acura car make(s). 
(5 marks) 
*/

SET LINESIZE 132

SET PAGESIZE 255

SET SERVEROUTPUT ON

SET VERIFY ON

SET FEEDBACK ON

SELECT
    c.custname
    ,CASE COUNT(*)
        WHEN 1 THEN
            'Silver'
        WHEN 2 THEN
            'Gold'
        ELSE
            'Platinum'
      END AS "Customer Type"
FROM
         si.car c
    INNER JOIN si.saleinv s ON c.carserial = s.carserial
GROUP BY
    c.custname
HAVING
    COUNT(
        CASE
            WHEN c.carmake = 'ACURA' THEN
                1
        END
    ) > 0
ORDER BY
    c.custname;
    
/*
-------------------------------- Output begins --------------------------------
CUSTNAME                  Customer Type
------------------------- -------------------------
ABDALLA FREIHAT           Silver
ANDREW AUBERTINSS         Silver
ANDREW GREENIZAN          Silver

<51 rows removed...>

VIKKI WONG                Silver
YOUCHAN KIM               Silver
(null)                    Platinum

57 rows selected.
-------------------------------- Output ends   --------------------------------
*/