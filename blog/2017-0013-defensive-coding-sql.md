---
permalink: "/2017/defensive-coding-sql"
title: Defensive coding in SQL
published_date: "2017-07-01 16:33:04 +0100"
layout: post.liquid
data:
  tags: ""
  route: blog
---
Always wrap ON clauses in parens to avoid predicates being deleted
accidentally. The following code will scream if you delete the AND clause.

```sql
SELECT *
  FROM foo
  LEFT JOIN bar
    ON ((foo.id = bar.id)
        AND (foo.fizz = bar.buzz))
```

Where as the following won't.

```sql
SELECT *
  FROM foo
  LEFT JOIN bar
    ON foo.id = bar.id
        AND foo.fizz = bar.buzz
```
