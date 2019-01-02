---
permalink: "/2017/when-xml-attacks"
title: "When XML attacks!"
published_date: "2017-07-01 18:11:10 +0100"
layout: post.liquid
data:
  route: blog
  tags: "oracle, xmltype, xml, extractvalue"
---
At some point in your xml wrangling career you will hit an node whose data is
too big for Oracle's `EXTRACTVALUE` (I think the upper limit is 4000
characters) and get this lovely message.

```
ORA-01706: user function result value was too large
01706. 00000 -  "user function result value was too large"
```

To mitigate this problem, you need to switch to **XMLTABLE** and it's useful
*PASSING* attribute:

```sql
SELECT
    fix.biggie AS notorious
FROM
    source_table_with_xmltype_column o,
    XMLTABLE ( '/*'
        PASSING o.xml_field COLUMNS
            biggie VARCHAR2(4000) PATH 'substring(/path/to/offending/item/text(),1,3999)'
    ) fix;
```

The gist of the fix is to use xpath to truncate the text value before it's
handed off to Oracle. Trying to cast the `xmltype` column as a `varchar2(4000)`
will not fix it because the problem happens as **extractvalue** is parsing the
node.

## Items of note

`XML ( '/*'` - how to specify the root of an xml document

`biggie VARCHAR2(4000) PATH 'substring(/path/to/offending/item/text(),1,3999)'` 
- how to get the text from an xpath and truncate it to 4000 chars.

sources:
- [XMLTABLE : Convert XML Data into Rows and Columns using SQL](https://oracle-base.com/articles/misc/xmltable-convert-xml-data-into-rows-and-columns-using-sql)
- [SO (Answer): How to use xmltable in oracle?](http://stackoverflow.com/a/12691983/105282)
- [SO (Answer): Oracle SQL - Extracting clob value from XML with repeating nodes](http://stackoverflow.com/a/13790623/105282)
