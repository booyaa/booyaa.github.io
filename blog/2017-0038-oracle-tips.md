extends: post.liquid
title: Oracle tips
date: 28 Sep 2017 17:12:37 +0100
path: 2017/oracle-tips
tags: oracle,plsql,tips
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
