---
permalink: "/2017/message-queue-miscellany"
title: Regular Expressions Miscellany
published_date: "2017-08-17 08:42:25 +0100"
layout: post.liquid
data:
  route: blog
  tags: "regularexpression,regex,oracle,notepad++"
---
## Oracle related regular expressions

## regexp_count and regexp_replace functions

Let say you have a column that contains `source` for an Oracle object. We want to extract  documentation hidden in sql multiline comment block `/* .... */`, it's been wrapped in a pair of `@@` for easy identification.

| ID | source                                | documentation |
|----|---------------------------------------|---------------|
| 1  | /*@@treasure@@*/                      | treasure      |
|    | select foo from bar                   |               |
| 2  | select fizz from buzz                 |               |

The little gotcha is that there's a linebreak between the documentation and the actual code.

Whilst not regular expression as per se you want to use `translate` to remove any type of non printing whitespace (tabs, line breaks and carriage returns).

`translate(source, CHR(10)||CHR(11)||CHR(13), '    ')`

This will allow you to supply `regexp_replace` with the following regular expression `'^..@@(.*)@@(.*)'` and extract the documentation.

Here's the entire solution with a common table expression to provide some test data.

```sql
COL source FORMAT a30
COL documentation FORMAT a30

WITH data AS (
    SELECT
        '/*@@treasure@@*/'
         || CHR(10)
         || 'select foo from bar' AS source
    FROM
        dual
    UNION ALL
    SELECT
        'select fizz from buzz'
    FROM
        dual
) SELECT
    source,
        CASE
            WHEN regexp_count(source,'^..@@(.*)@@(.*)') > 0 THEN regexp_replace(
                translate(
                    source,
                    CHR(10)
                     || CHR(11)
                     || CHR(13),
                    '    '
                ),
                '^..@@(.*)@@(.*)',
                '\1'
            )
        END
    AS documentation
FROM
    data;
```

The only addition is a check to see if the regular expression was matched against the `source` field so we only processed those columns and return no data in the documentation field.

I used this to enhance this handy [ORDS to Swagger](https://github.com/postak/ords2swagger) script to provide documentation in the description tags rather than the source code (which it to fail validation).

## notepad++

### Creating fake data as an in-memory SQL table

you want to turn this

```
JEB JIBBLY 1234 3
BOBBY TABLES 2314 1
WHISKY JACK 2241 2
```

into this

```
WITH FOO AS 
( SELECT 'JEB JIBBLY' "FULL_NAME", '1234' "PIN", '3' "FAILED_ATTEMPTS" FROM DUAL 
  UNION ALL
  SELECT 'BOBBY TABLES' "FULL_NAME", '2314' "PIN", '1' "FAILED_ATTEMPTS" FROM DUAL
  UNION ALL
  SELECT 'WHISKY JACK' "FULL_NAME", '2241' "PIN", '2' "FAILED_ATTEMPTS" FROM DUAL)

SELECT * FROM FOO;  
```

notepad++ regexp

find what: ```(.*)\s+(\d{4})\s(\d+)```
replace with: ```SELECT '\1' "FULL_NAME", '\2' "PIN", '\3' "FAILED_ATTEMPTS" FROM DUAL UNION ALL```

make sure you have enabled regular expression in search mode!

then obviously you'll have to format and remove unnecessary UNIONs
