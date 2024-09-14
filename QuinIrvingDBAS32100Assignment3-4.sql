/*
File:            QuinIrvingDBAS32100Assignment3-4.sql
Author:          Quin Irving
Oracle Username: S5_irvingq
Description: Options table is frequently used in queries that require optiondesc
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

/* creates a copy of the si.options table (A)
CREATE TABLE i_options
    AS
        SELECT
            *
        FROM
            si.options;
*/

/* (B)
CREATE INDEX optiondesc_idx ON
    i_options (
        optiondesc
    );
*/

/* (C)
EXPLAIN PLAN
    FOR
SELECT
    *
FROM
    i_options
WHERE
    optiondesc LIKE '%ROOF%';

SELECT
    *
FROM
    TABLE ( dbms_xplan.display() );
*/

/* (D)
DROP INDEX optiondesc_idx;

EXPLAIN PLAN
    FOR
SELECT
    *
FROM
    i_options
WHERE
    optiondesc LIKE '%ROOF%';

SELECT
    *
FROM
    TABLE ( dbms_xplan.display() );
*/

/* (E)
*/

/*
----------------------- Output begins ------------------------
Table I_OPTIONS created.

Index OPTIONDESC_IDX created.

Explained.

>>Query Run In:Query Result

Plan hash value: 2520152944
 
------------------------------------------------------------------------------------------------------
| Id  | Operation                           | Name           | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |                |     1 |    28 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| I_OPTIONS      |     1 |    28 |     2   (0)| 00:00:01 |
|*  2 |   INDEX FULL SCAN                   | OPTIONDESC_IDX |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - filter("OPTIONDESC" LIKE '%ROOF%' AND "OPTIONDESC" IS NOT NULL)

Index OPTIONDESC_IDX dropped.

Explained.

>>Query Run In:Query Result 1

Plan hash value: 2284038160
 
-------------------------------------------------------------------------------
| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |           |     1 |    28 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| I_OPTIONS |     1 |    28 |     3   (0)| 00:00:01 |
-------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("OPTIONDESC" LIKE '%ROOF%' AND "OPTIONDESC" IS NOT NULL)

----------------------- Output ends   ------------------------
*/