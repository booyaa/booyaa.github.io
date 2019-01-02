---
permalink: "/2017/sql-developer-format-hints"
title: "SQL Developer's new format hints"
published_date: "2017-07-01 18:40:24 +0100"
layout: post.liquid
data:
  tags: "sqldeveloper,csv,format"
  route: blog
---
One of my favourite cool features in SQL Developer is the ability to turn a sql
query output into an entirely different format. It doesn't even require 
breaking out the import/export wizard.

```sql
SPOOL C:\TEMP\foobar.csv

SELECT /*csv*/ *
  FROM foo
  LEFT
  JOIN bar
    ON foo.id = bar.id
 WHERE foo.name LIKE '%HURR%';
 
 SPOOL OFF
```

Complete list of formats

```sql
SELECT /*csv*/ * FROM scott.emp;
SELECT /*xml*/ * FROM scott.emp;
SELECT /*html*/ * FROM scott.emp;
SELECT /*delimited*/ * FROM scott.emp;
SELECT /*insert*/ * FROM scott.emp;
SELECT /*loader*/ * FROM scott.emp;
SELECT /*fixed*/ * FROM scott.emp;
SELECT /*text*/ * FROM scott.emp;
```

Full details and source can be  [here](http://www.thatjeffsmith.com/archive/2012/05/formatting-query-results-to-csv-in-oracle-sql-developer/).
