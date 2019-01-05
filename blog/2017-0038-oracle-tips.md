---
permalink: "/2017/oracle-tips"
title: Oracle tips
published_date: "2017-09-28 17:12:37 +0100"
layout: post.liquid
data:
  route: blog
  tags: "oracle,plsql,tips"
---
## Hiding user input

Sometimes you need to keep something secret (shoulder surfing), this will only work in SQL/Plus or Oracle SQL Developer (F5/Run script mode aka broken SQL/Plus mode).

```plsql
SET SERVEROUTPUT ON

SET VERIFY OFF

ACCEPT sekrit PROMPT 'enter a secret (warning we''re going to print it on screen!)' HIDE

BEGIN
    dbms_output.put_line('sekrit: ' || '&sekrit');
END;
/
```

If you ran the script correctly, the input dialogue will echo stars `*` instead of your "secret".

If you can see the data you're entering, you ran Oracle SQL Developer statement mode (CTRL-ENTER).

## Sessions

### Finding

```sql
SET LINESIZE 140
SET PAGESIZE 50
COL sid FORMAT a5
COL serial FORMAT a5
COL username FORMAT a30
COL osuser FORMAT a30
COL machine FORMAT a30
COL client_ip FORMAT a20
SELECT
    sid,
    serial# AS serial,
    osuser,
    username,
    machine,
    logon_time,
    utl_inaddr.get_host_address(regexp_replace(machine,'^.+\\') ) AS client_ip
FROM
    v$session
WHERE
        username IS NOT NULL
    AND
        status <> 'KILLED';
```

### Killing

`alter system kill session 'sid,serial#';`

Code generated example

```sql
SELECT 
    'alter system kill session ''' ||sid||','||serial#|| ''';' as sql
FROM
    v$session
WHERE
    username = 'VICTIM';
```

