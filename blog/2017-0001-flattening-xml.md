---
permalink: "/2017/flattening-xml"
title: Code generation scripts in PL/SQL
published_date: "2017-05-10 16:49:09 +0100"
layout: post.liquid
data:
  route: blog
  tags: "codegen, plsql, oracle, xml"
---
## Flattening XML paths

The table `elephant_castle` has a `XMLTYPE` column `details` that we want to
get a list of distinct node paths.

```sql
WITH node_list AS (
    SELECT
        x.*
    FROM
        elephant_castle ec
        CROSS JOIN XMLTABLE ( 
'declare function local:path-to-node( $nodes as node()* ) as xs:string* { 
    $nodes/string-join(ancestor-or-self::*/name(.),''/'') 
}
;for $i in $doc//*
    let $node_path := local:path-to-node($i)  
    (: still don''t have a clue how this func works :)
    let $node_value := $i/text()
    where string-length($node_value) > 0        
    (: how to exclude nodes without values :)

    return <data>
                <path>{$node_path}</path>
                <value>{$node_value}</value>
            </data>'
                PASSING ec.details AS "doc" COLUMNS
                    node_path VARCHAR2(4000) PATH 'path',
                    node_value VARCHAR2(4000) PATH 'value' /* debugging */
            ) x
) SELECT distinct nl.node_path
FROM
    node_list nl;    
```


## Generate a query that combines existing fields with newly flatten XML paths

This script allows you to apply boiler plate (fields from the existing table
using the data dictionary) and then make call out to another sqlplus script
that contains table specific mappings. The call out script is assumed to be
called `TableName.sql`.

```plsql
REM Suppress all headings, page breaks, titles
SET PAGESIZE 0
REM Do not list the text of a command before and after replacing substitution 
REM variables with values
SET VERIFY OFF
REM  Do not display the number of records returned (when rows >= n )
SET FEEDBACK OFF

CLEAR SCREEN

DEFINE TableName=STANDINGORDER
DEFINE TableAlias=so
DEFINE TableSchema=BPHADMIN

/*******************************************************************************
** Generate existing column list, excluding XMLTYPE, BLOB and CLOB types.
*******************************************************************************/
WITH column_list AS (
    SELECT
        column_id,
        column_name
    FROM
        all_tab_cols
    WHERE
        owner = '&TableSchema'
    AND
        table_name = '&TableName'
    AND
        data_type NOT IN (
            'XMLTYPE','BLOB','CLOB'
        )
    ORDER BY column_id
) SELECT
    CASE column_id  
        WHEN 1 THEN 'SELECT &TableAlias'|| '.' || column_name
        ELSE ',&TableAlias'|| '.' || column_name
    END as sql
FROM
    column_list;

/*******************************************************************************
** Call out script with custom XML flattening logic (usually field name tweaks)
*******************************************************************************/
@&TableName

/*******************************************************************************
** Add "FROM" statement
*******************************************************************************/
PROMPT FROM &TableName &TableAlias;;
```
