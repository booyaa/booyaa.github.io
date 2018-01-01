permalink: "/2017/oracle-messaging-gateway-tips"
title: Oracle Messaging Gateway Tips
published_date: "2017-06-04 16:49:09 +0100"
layout: post.liquid
data:
  tags: "oracle,omg,mq,aq,messaging,queue"
---
## Assumptions

- I've used the Messaging Gateway (MG) to link Oracle's Advanced Queueing to IBM's (neé WebSphere) Message Queue. 
- SQL commands issued as the MG admin schema unless otherwise stated.
- MG is installed on Linux, so all command line examples will be in default shell (usually BASH).

## Creating an auto dequeuing queue (MQ > AQ > Table)

1. Create Queue Table (multiple consumers is true)
2. Create Queue
3. Enable Queue
4. Create MGW Link (skip if you've already done this)
5. Create Foreign queue
6. Create Propagation Job


## Removing jobs

Always use force parameter (`dbms_mgwadm.remove_job(job_name => 'job_foo_in', force => dbms_mgwadm.force)`), if there's anything wrong with foreign queue i.e. MQ doesn't exist or the user account doesn't exist the call to `dbms_mgwadm.remove_job` will fail. 

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

agent_status should be `RUNNING` and agent_ping is `REACHABLE`. If the last_error_msg column is populated, then it might be a good idea to add the last_error_date and/or last_error_time columns to see when the error occurred.

### MG log

Search for any MQ client issues, pass these onto your IBM MQ admin team to investigate. Usually these exception occur when commissioning a new queue.

```shell
cd $ORACLE_HOME/mgw/log
grep com.ibm.mq.MQException $(ls -t | head -1)
```

## ORA-32831 - timed out trying acquire administration lock

One of our Message Queue on the IBM side wasn't permissioned correctly. The associated propgation job failed and was left in a `PENDING DELETION` state. Attempts to shutdown agent (`dbms_mgwadmn.shutdown`) fail with `ORA-32831`.

The only option left is to shutdown and restart database server:

```sql
$ sqlplus /nolog

(omitting banner stuff)

SQL> connect / as sysdba
Connected.
SQL> shutdown immediate
Database closed.
Database dismounted.
ORACLE instance shut down.
SQL> startup
ORACLE instance started.

(ommitting startup stats)
SQL> exit
```

Check the gateway status

```sql
SET SERVEROUTPUT ON
SET FEEDBACK ON
CLEAR SCREEN
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

If agent_status is `START_SCHEDULED` then the agent will restart shortly, otherwise use `dbms_mgadm.startup` to start it manually.

Should you now find any pending deletions in `mgw_jobs` have been excuted, also any jobs that failed to delete will be reset to a ready state.

## Reference

I've not needed to use these web pages (yet), but they could useful for future issues.

- [Monitoring Oracle Messaging Gateway](https://docs.oracle.com/database/121/ADQUE/mg_trble.htm#ADQUE3389)
- [Cleaning up Messaging Gateway objects left in an invalid state](http://nadvi.blogspot.co.uk/2011/10/cleanup-message-queue-mq-gateway-agent.html)
