## XML over ORDS

Turns out you can emit XML via ORDS. I'll assume you have a working ORDS install and the schema is already enabled


```plsql
BEGIN
  ORDS.DEFINE_MODULE(
      p_module_name    => 'reporting',
      p_base_path      => '/reporting/',
      p_items_per_page =>  0,
      p_status         => 'PUBLISHED',
      p_comments       => NULL);      
  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'reporting',
      p_pattern        => 'hello_xml',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => NULL);
  ORDS.DEFINE_HANDLER(
      p_module_name    => 'reporting',
      p_pattern        => 'hello_xml',
      p_method         => 'GET',
      p_source_type    => 'plsql/block',
      p_items_per_page =>  0,
      p_mimes_allowed  => '',
      p_comments       => NULL,
      p_source         => 
'DECLARE
    l_clob   CLOB;
BEGIN
    SELECT
        ''<xml>hello world</xml>''
    INTO
        l_clob
    FROM
        dual;

    owa_util.mime_header(
        ccontent_type   => ''text/xml'',
        bclose_header   => true,
        ccharset        => ''ISO-8859-4''
    );

    htp.print(l_clob);
END;'
      );
  COMMIT; 
END;
```

```shell
$ curl -v http://oracle.rocks:8080/ords/scott/reporting/mime_works
* About to connect() to oracle.rocks port 8080 (#0)
*   Trying 1.2.3.4... connected
* Connected to oracle.rocks (1.2.3.4) port 8080 (#0)
> GET /ords/scott/reporting/mime_works HTTP/1.1
> User-Agent: curl/7.19.7 (x86_64-redhat-linux-gnu) libcurl/7.19.7 NSS/3.27.1 zlib/1.2.3 libidn/1.18 libssh2/1.4.2
> Host: oracle.rocks:8080
> Accept: */*
>
< HTTP/1.1 200 OK
< Content-Type: text/xml; charset=ISO-8859-4
< ETag: "WaloI8WDL3PY2G0ZN6+I8C+c0FxVaUBuDc/v7LKXTpE6dTuJR1s2bLF/0hqW2fVzaXNYpr9TFXqucyoq6dO2Xw=="
< Transfer-Encoding: chunked
<
<xml>hello world</xml>
* Connection #0 to host oracle.rocks left intact
* Closing connection #0
```

Important item of note is the mime header, it's important that `bclose_header` is always `true` because this is literally the last HTTP header before the response body. Setting this to false will result in no data.


### References
- [ORACLE-BASE](https://oracle-base.com/articles/misc/oracle-rest-data-services-ords-create-basic-rest-web-services-using-plsql#stored-procedure-xml)
