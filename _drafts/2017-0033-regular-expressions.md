extends: post.liquid
title: Regular Expressions Miscellany
date: 13 August 2017 12:34:56 +0100
path: 2017/message-queue-miscellany
tags: regularexpression,regex,oracle,notepad++
---

## Oracle related regular expressions

regexp_count
regexp_replace
regexp_like - to act like a case in

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
