extends: post.liquid
title: Oracle Messaging Gateway Tips
date: 4 Jun 2017 16:49:09 +0100
path: 2017/oracle-messaging-gateway-tips
tags: oracle,omg,mq,aq,messaging,queue
---

## reference
- http://nadvi.blogspot.co.uk/2011/10/cleanup-message-queue-mq-gateway-agent.html

## Assumptions

- I've used the Messaging Gateway (MG) to link Oracle's Advanced Queueing to IBM's (nee WebSphere) Message Queue. 
- SQL commands issued as theMG admin unless otherwise stated.
- MG is installed on Linux, so all command line examples will be in default shell (usually BASH).

## Troubleshooting

### Gateway status

The first port of call is to check the health of the gateway.

```sql
SET LINESIZE 200
SET WRAP OFF
COL agent_status FORMAT a30
COL agent_ping FORMAT a30
COL agent_start_time FORMAT a30
COL last_error_msg FORMAT a30

SELECT
    agent_status,
    agent_ping,
    agent_start_time,
    last_error_msg
FROM
    mgw_gateway;
```

Agent status should be `RUNNING` and Agent ping is `REACHABLE`. If the Last Error Message column is populated, then it might be a good idea to add the Last Error Date and Time columns to see what the error was.

### MG log

Search for any MQ client issues, pass these onto your IBM MQ admin team to investigate. Usually these exception occur when commissioning a new queue.

```shell
cd $ORACLE_HOME/mgw/log
grep com.ibm.mq.MQException $(ls -t | head -1)
```
