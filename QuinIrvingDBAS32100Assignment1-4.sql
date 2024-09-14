/* 
File Name: QuinIrvingDBAS32100Assignment1-4.sql
My Name: Quin Irving
Oracle User Name: S5_irvingq
Question 4: Using a single SELECT statement, show a list of total money spent
on the labour cost of servicing Land Rover cars. Show the subtotals for each 
model as well as each make (5 marks) 
*/

SET LINESIZE 132

SET PAGESIZE 255

SET SERVEROUTPUT ON

SET VERIFY ON

SET FEEDBACK ON

SELECT
    c.carmake
    ,c.carmodel
    ,SUM(s.laborcost) AS "Total Money Spent"
FROM
         si.car c
    INNER JOIN si.servinv s
    ON c.carserial = s.carserial
WHERE
    c.carmake = 'LAND ROVER'
GROUP BY
    ROLLUP(c.carmake
           ,c.carmodel);

/*
-------------------------------- Output begins --------------------------------
CARMAKE                   CARMODEL                  Total Money Spent
------------------------- ------------------------- -------------------------
LAND ROVER                G4                        50
LAND ROVER                SC                        200
LAND ROVER                123                       300

<16 rows removed...>

LAND ROVER                SERIESII                  72.74
LAND ROVER                (null)                    6298.71
(null)                    (null)                    6298.71

22 rows selected.
-------------------------------- Output ends   --------------------------------
*/