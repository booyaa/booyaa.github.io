extends: post.liquid
title: PL/SQL script to query a refcursor
date: 1 Jul 2017 16:49:01 +0100
path: 2017/plsql-script-cursors
tags: cursors, oracle, plsql
route: blog
---
This will probably work in pipelined functions or packages too. Note the use of
the bind variable to link the PL/SQL script variables to the out refcursor.

```plsql
SET SERVEROUTPUT ON
CLEAR SCREEN

VAR P_NAME CHAR
VAR P_TABLES REFCURSOR

DECLARE
  PROCEDURE table_get(p_name IN VARCHAR2, p_tables OUT SYS_REFCURSOR)
  AS
  BEGIN
    OPEN p_tables 
     FOR
        SELECT * 
          FROM user_tables 
         WHERE TABLE_NAME LIKE P_NAME;
  END;
BEGIN  
  :P_NAME := '%REQ%';
  table_get(:P_NAME, :P_TABLES);
END;
/

PRINT P_TABLES
```
