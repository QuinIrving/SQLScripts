/*
File:            QuinIrvingDBAS32100Assignment3-5.sql
Author:          Quin Irving
Oracle Username: S5_irvingq
Description: Place all the SQL code that would perform the above written steps
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

DROP TABLE i_options;

CREATE TABLE i_options
    AS
        SELECT
            *
        FROM
            si.options;

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

CREATE INDEX optiondesc_idx ON
    i_options (
        optiondesc
    );

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

DROP INDEX optiondesc_idx;

/*
----------------------- Output begins ------------------------
Table I_OPTIONS dropped.

Table I_OPTIONS created.

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
----------------------- Output ends   ------------------------
*/