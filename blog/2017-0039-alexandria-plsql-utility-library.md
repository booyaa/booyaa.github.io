---
permalink: "/2017/alexandria-plsql-utility-library"
title: Alexandria PL/SQL Utility Library
published_date: "2017-10-11 07:39:34 +0100"
layout: post.liquid
data:
  route: blog
  tags: "oracle,plsql,ooxml,microsoft"
---
Imagine if BatMan was an Oracle DBA, his utility belt would be the [Alexandria PL/SQL Utility Library](https://github.com/mortenbra/alexandria-plsql-utils).

## How to install Microsoft Office document parsers (OOXML)

### Assumptions

- This has been tested on 12c r1, I imagine it should still work for 11G.
- `SCHEMA_ALEX_INSTALL` - This is the schema you have created that will host the Alexandria library.
- Using SQLPlus or [Oracle SQL Developer](http://www.oracle.com/technetwork/developer-tools/sql-developer/overview/index.html) (in SQLPlus mode)
- Script have installed to a path that SQLPlus can find


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

As `SCHEMA_ALEX_INSTALL` 

```sql
HOST md d:\temp\devtest -- Un*x users: mkdir /path/to/devtest
CREATE DIRECTORY devtest_temp_dir AS 'd:\temp\devtest'; -- Un*x 
SET SERVEROUTPUT ON

DECLARE
    l_blob    BLOB;
    l_props   ooxml_util_pkg.t_xlsx_properties;
BEGIN
    debug_pkg.debug_on;
    l_blob := file_util_pkg.get_blob_from_file('DEVTEST_TEMP_DIR','hello_excel.xlsx');
    l_props := ooxml_util_pkg.get_xlsx_properties(l_blob);
    debug_pkg.printf(
        'title = %1,modified = %2,creator = %3,application = %4',
        l_props.core.title,
        l_props.core.modified_date,
        l_props.core.creator,
        l_props.app.application
    );

END;
/
```
