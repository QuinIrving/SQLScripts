/* 
File Name: QuinIrvingDBAS32100Assignment1-5.sql
My Name: Quin Irving
Oracle User Name: S5_irvingq
Question 5: Write a query using analytic functions that will show the serial
number, the model and the sale price of each model of Land Rover as well as the
cumulative sale price totals. (5 marks)
*/

SET LINESIZE 132

SET PAGESIZE 255

SET SERVEROUTPUT ON

SET VERIFY ON

SET FEEDBACK ON

SELECT
    c.carserial
    ,c.carmodel
    ,s.carsaleprice
    ,SUM(s.carsaleprice)
      OVER(PARTITION BY c.carmodel
        ORDER BY
            c.carmodel
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      ) AS "Model Cumulative Price"
    ,SUM(s.carsaleprice)
      OVER(
        ORDER BY
            c.carmodel
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      ) AS "Total Cumulative Sale Price"
FROM
         si.car c
    INNER JOIN si.saleinv s
    ON c.carserial = s.carserial
WHERE
    c.carmake = 'LAND ROVER'
ORDER BY
    c.carmodel;
    
/*
-------------------------------- Output begins --------------------------------
CARSERIAL                 CARMODEL                  CARSALEPRICE              Model Cumulative Price    Total Cumulative Sale Price
------------------------- ------------------------- ------------------------- ------------------------- -------------------------
L13BBNG0                  BNG                       22368.33                  22368.33                  22368.33
L16WDEF9                  DEFEN-90                  35000                     35000                     57368.33
L18RDEF1                  DEFENDER                  76093.12                  76093.12                  133461.45

<14 rows removed...>

L15BLR46                  LR4                       1841.84                   70515.52                  778766.54
L17BRRS9                  RRS                       63500                     63500                     842266.54
L16SSPO2                  SPORT                     91386                     91386                     933652.54

20 rows selected.
-------------------------------- Output ends   --------------------------------
*/