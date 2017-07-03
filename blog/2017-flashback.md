extends: post.liquid
title: Flashback, what did this data look like previously?
date: 1 Jul 2017 18:44:06 +0100
path: 2017/flashback
tags: oracle, flashback, lsd
---
I'm only scratching the surface of what you can do with flashbacks in Oracle. 
Our DBAs are absolute ninjas when it comes to using this witchcraft from Oracle.

The example below lets us look at a data dictionary for materialized refresh
groups and what the values were an hour ago.

```sql
CLEAR SCREEN

COL name FORMAT a30
COL rname FORMAT a30

SELECT
    name,
    rname
FROM
    all_refresh_children AS OF TIMESTAMP ( trunc(SYSDATE - 1 / 24) )
WHERE
    rname = 'RFG_GROUP2';
```

where:

 - `1 / 24` is an hour ago
 - `36 / 24` is yesterday an hour and half ago