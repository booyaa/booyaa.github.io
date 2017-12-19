extends: post.liquid
title: Message Queue Miscellany
date: 12 Aug 2017 14:13:12 +0100
path: 2017/message-queue-miscellany
tags: mq,messagequeue
route: blog
---
This is a bit of a hodge podge of message queue notes. Very IBM centric at the moment.

## Command line tools

### Cheatsheet

```
SET MQSERVER=CHANNEL.NAME/TCP/HOST OR IP ADDRESS(PORT)
AMQSPUTC QUEUENAME QUEUEMANAGER < SOME\FILE\CALLED\HELLO.TXT
AMQSGETC QUEUENAME QUEUEMANAGER
```

### Display library version

Win (or c:\windows\assembly)

```
C:\IBM\WebSphere MQ\dspmqver -i
```

Unix (should be in path

```
dspmqver -i
```

source: http://www-01.ibm.com/support/docview.wss?uid=swg21621707
tag: mq , .net , dll

### RFHUtilc

Queue Manager Name: CHANNEL NAME/TCP/HOSTNAME(PORT)
