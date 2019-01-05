---
permalink: "/2018/when_is_a_mysql_error_not_a_mysql_error"
title: "When is a MySQL error not a MySQL error"
categories:
  - "devops,dbops"
layout: post.liquid
published_date: "2018-10-09 20:20:00 +0000"
is_draft: false
data:
  tags: "devops,dbops"
  route: blog
---
I came across this error recently: `Mysql2::Error: Can't connect to MySQL server on 'some-db-server.example.com' (113)`

A quick [search](https://duckduckgo.com/?q=mysql+error+113&t=ffab&ia=qa) on the Internet, resulted in various Q & A sites hinting at a connectivity/routing issue to/from the MySQL server. 

Whilst this was probably enough information for me to fix, if the problem exists on a 3rd party's infrastructure you want to provide a bit more information.

The first port of call was to see if the error code `113` appears in the [MySQL reference](https://dev.mysql.com/doc/refman/8.0/en/error-handling.html). You can imagine my surprise when I couldn't find `113` anywhere in this chapter.

Luckily there is help available from MySQL in the form of a utility called [`perror`](https://dev.mysql.com/doc/refman/8.0/en/perror.html) that allows you to look up MySQL error codes.

By typing `perror` along with error code, you'll get the following:

```shell
$ perror 113
OS error code 113:  No route to host
```

So the reason we can't find this error in either the Client or Server sections of the MySQL reference manual is that it's an operating system error.

The operating system in question is Linux, so we know we're looking for C error number codes ([errno.h](https://en.wikipedia.org/wiki/Errno.h)). If you've got access to the kernel source you can find it in `/usr/src/linux-source-<VERSION>/include/uapi/asm-generic/errno.h` if you don't have the source installed you can see it see a definition of `113` [GitHub](https://github.com/torvalds/linux/blob/master/include/uapi/asm-generic/errno.h#L96):

```c
#define    EHOSTUNREACH    113    /* No route to host */
```

So armed with this information, I could contact the 3rd party and ask them to check routing and firewall rules between us and the database server.