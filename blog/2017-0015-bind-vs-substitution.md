---
permalink: "/2017/bind-vs-substitution"
title: Bind vs Substitution variables
published_date: "2017-07-01 18:02:45 +0100"
layout: post.liquid
data:
  tags: "oracle, plsql, variables, bind, substitution"
  route: blog
---
I always have difficulty remember the difference between these type of 
variables. Although now, that I've started doing a lot of ORDS related work,
the difference is become more apparent.

Also substitution variables are really a binding to a user variable.

## Bind variables

```plsql
PROMPT bind variables are...
VAR foo VARCHAR2

SET SERVEROUTPUT ON
BEGIN
  :FOO := 'in PL/SQL blocks';
  DBMS_OUTPUT.PUT_LINE('mostly used...');
END;
/
SET SERVEROUTPUT OFF

PRINT foo
```

output
```
bind variables are...

PL/SQL procedure successfully completed.

mostly used...


FOO
---
in PL/SQL blocks
```

## Substitution variables

```PLSQL
PROMPT Where as substitution variable are...
DEFINE FOO = 'useful in SQL scripts'
SET VERIFY OFF
SELECT '&FOO' AS BAR FROM DUAL;
SET VERIFY ON
```

output
```
Where as user variable are...

BAR                 
---------------------
useful in SQL scripts
```

To be explict, use bind vars to interact with PL/SQL blocks and substituion
variables could be used anywhere. The only downside to substituion variables is
that you can't DEFINE a variable with another user variable.

Also you can break substitution variables, if there's an errant `SET DEFINE OFF`, 
still not sure how you could test for this? Perhaps using default values
and testing for it i.e. like SQLCMD variables.

Further reading:

- [Literals, Substitution Variables and Bind Variables](https://oracle-base.com/articles/misc/literals-substitution-variables-and-bind-variables)
- [PL/SQL 101 : Substitution vs. Bind Variables](https://community.oracle.com/docs/DOC-915518)
