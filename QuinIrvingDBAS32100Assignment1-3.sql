/* 
File Name: QuinIrvingDBAS32100Assignment1-3.sql
My Name: Quin Irving
Oracle User Name: S5_irvingq
Question 3: Using SET operations, display a list of customers that both bought 
a car from SI and serviced that car at SI. (Hint: consider the serial number)
(5 marks) 
*/

SET LINESIZE 132

SET PAGESIZE 255

SET SERVEROUTPUT ON

SET VERIFY ON

SET FEEDBACK ON

SELECT
    sa.custname
    ,sa.carserial
FROM
    si.saleinv sa
INTERSECT
SELECT
    se.custname
    ,se.carserial
FROM
    si.servinv se
ORDER BY
    custname;
    
/*
-------------------------------- Output begins --------------------------------
CUSTNAME                  CARSERIAL
------------------------- -------------------------
ABDUL BASIT               M17GS653
ADAM                      L16WDEF9
ALEX                      J10YCOO0

<99 rows removed...>

VIKKI WONG                A16LMDX0
YOGESH THAKUR             A17RMDX4
ZACH FISCH                N11GROG0

105 rows selected.
-------------------------------- Output ends   --------------------------------
*/