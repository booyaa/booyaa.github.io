extends: post.liquid
title: Alexandria PL/SQL Utility Library
date: 4 Jun 2017 16:49:09 +0100
path: 2017/alexandria-plsql-utility-library
tags: oracle,plsql,
---

Imagine if BatMan was an Oracle DBA, his utility belt would be the [Alexandria PL/SQL Utility Library](https://github.com/mortenbra/alexandria-plsql-utils).

## How to install Microsoft Office document parsers (OOXML)


### Assumptions

- This has been tested on 12c r1, I imagine it should still work for 11G.
- `SCHEMA_ALEX_INSTALL` - This is the schema you have created that will host the Alexandria library.


### Installation instructions

As `sys` or similiar

```sql
grant execute on dbms_random to SCHEMA_ALEX_INSTALL;
grant execute on dbms_lob to SCHEMA_ALEX_INSTALL;
grant execute on util_file to SCHEMA_ALEX_INSTALL;
grant create any directory to SCHEMA_ALEX_INSTALL;
```

As `SCHEMA_ALEX_INSTALL`

```sql
set scan off;

prompt Creating types
@types.sql

prompt Creating MICROSOFT package specifications
@../ora/string_util_pkg.pks
@../ora/zip_util_pkg.pks
@../ora/xml_util_pkg.pks
@../ora/sql_util_pkg.pks
@../ora/file_util_pkg.pks
@../ora/debug_pkg.pks
@../ora/xml_builder_pkg.pks
@../ora/xml_dataset_pkg.pks
@../ora/xml_stylesheet_pkg.pks
@../ora/xml_util_pkg.pks
@../ora/ooxml_util_pkg.pks


prompt Creating MICROSOFT package bodies
@../ora/string_util_pkg.pkb 
@../ora/zip_util_pkg.pkb
@../ora/xml_util_pkg.pkb
@../ora/sql_util_pkg.pkb
@../ora/file_util_pkg.pkb
@../ora/debug_pkg.pkb
@../ora/xml_builder_pkg.pkb
@../ora/xml_dataset_pkg.pkb
@../ora/xml_stylesheet_pkg.pkb
@../ora/xml_util_pkg.pkb
@../ora/ooxml_util_pkg.pkb

prompt Done!
```

### Verifying the installation
