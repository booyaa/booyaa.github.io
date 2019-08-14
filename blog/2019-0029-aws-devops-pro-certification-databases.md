---
permalink: "/2019/aws-devops-pro-certification-databases"
title: "AWS DevOps Pro Certification Blog Post Series: Databases"
categories:
  - "aws,databases,rds,dynamodb"
layout: post.liquid
published_date: "2019-06-14 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,databases,rds,dynamodb"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier][aws_free_tier]. You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try to refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

**Amazon RDS** is a managed service for Relational Database engines Service (RDS). AWS supports the following engines:

- MySQL is an open source database engine
- MariaDB is a fork of MySQL when the former was acquired by Oracle (through the [acquisition][wiki_mysql] of Sun Systems)
- PostgreSQL is an open source database engine
- Oracle is a commercial engine by Oracle
- SQL Server is a commercial engine by Microsoft
- Amazon Aurora is a MySQL / Postgres compatible relational database engine

**Amazon DynamoDB** is a proprietary NoSQL database service offered by Amazon.

## Why?

Managed services for database engines like all managed service remove key concerns:

- provisioning/scaling/termination of servers that host the database engines
- maintenance of servers (patching)
- backups and restores

These concerns often affect the ability to provide a database server that is fault-tolerant, highly available and has a contingency for disaster recovery.

N.B. there's a caveat around storage scaling that it won't be applicable to SQL Server instances. The details can be found in the [SQL Server FAQs: Why can’t I scale my storage?][rds_ssql_faq].

To understand the difference between Amazon RDS and Amazon DynamoDB, I've provided the following examples:

Relational database engines (sometimes referred to as RDBMS) are tabular in natural, you can think of it visually as a spreadsheet with fields as the column headers and the rows being a single record of data. The term "relational" comes from the ability to link tables through a foreign key, an example of this might be a list of `developer`s and their favourite `food`s. The link would be a column in the `developers` table called `food_id`, which would reference the column called `id` in the `food` table.

`developer`(s) table

| id | name | food_id |
|----|-------|---------|
| 1 | alice | 1 |
| 2 | bob | 1 |
| 3 | carol | 2 |

`food`(s) table

| id | name |
|----|--------|
| 1 | banana |
| 2 | nuts |

If you were to delete nuts (id: `2`) from the `food` table you would trigger an error warning there were dependencies in the `developer` table.

The key takeaway from this example is to remember Relational Databases store records tabularly in rows.

NoSQL database engines are a bit of a catch-all, but in essence, if you don't store your data tabularly you're probably a NoSQL database engine. Amazon DynamoDB is a Key/Value pair and Document store. Key/Value store allows you to store data like a Hash (associative array/dictionary), you provide a `key` and the value is returned, you may have used one without knowing as they're often referred to as cache servers i.e. Redis. Document stores allow you to data in a structured way common formats are XML and JSON, often these are the database engines most people associate with NoSQL i.e. CouchDB and MongoDB.

## When?

Amazon Aurora provides a compatible engine that is 3x faster than PostgreSQL and 5x faster than MySQL. In terms of cost-effectiveness, you need to compare the other RDS engines as a multi-AZ deployment and memory optimised instances.

Things that set it apart from the other RDS offerings in terms of this domain are:

- Aurora can failover over to 1 of (up to) 15 read replicas with low impact to the primary instance.
  - You can use MySQL replicas instead of Aurora native, but you're limited to 5 replicas and there's a high impact to the primary instance.
  - The order which replicas are promoted to primary can be customised.
- Data is stored in 10GB chunks with 6 copies replicated across three availability zone.
  - Aurora will continue to handle:
    - write capability with the loss of 2 copies of data
    - read capability with the loss of 3 copies of data
- The data blocks and disks are scanned for errors and repaired automatically

Amazon RDS can be part of your disaster recovery strategy by keeping replicas of your production Oracle or SQL Server database servers.

Amazon DynamoDB requires a lot more consideration to make use of its features that make it relevant to this domain. Choosing the wrong scheme for partition keys can see your database starved of I/O.

Things to consider:

- You pay for the number of I/O you use (rather than instance size) the size of units is in kilobytes and vary depending on the type of I/O operation:
  - Read Capacity Unit (RCU) are measured in 4KB blocks, so an 8KB block of data would consume 2 RCUs
  - Write Capacity Unit (WCU) are measured in 1KB blocks, so a 5KB block of data would consume 5 WCUs
  - Data in tables are stored as 10GB partitions that can handle 3K RCU and 1K WCU
    - As you expand the table into more 10GB partitions, the RCU and WCU are distributed across the partitions i.e. if you 2 partitions then you have a max of 1.5K RCUs and 0.5K WCUs across the 2 partitions.
- Terminology
  - Table (highest level unit for Dynamo DB)
  - Item (a record)
  - Attributes (columns or fields of a record)
  - Primary Keys can consist of
    - just a Partition Key (which is often referred to as a Primary Index and is used to query the table)
    - the partition key and sort key this is known as a composite primary key
  - Secondary Indexes (allows you to query on a different attribute)
    - Local - requires the same partition key, but the sort key can be different
    - Global - can have a different attribute for the partition and sort keys
- Strategies for write-heavy use cases it's recommended you add a randomly generated number from a predetermined range. e.g. if Partition Key is a composite attribute based on invoice number (1234), then you would suffice the randomly generated number (1) to the end, so the composite key would be: `1234`-`1`.


Further reading:

- [AWS DynamoDB Cheat Sheet][link_dynamodb_cheat_sheet]
- [AWS DynamoDB Partitions and Key Design][link_dynamodb_design]
- [AWS DynamoDB: Choosing the right partition key][dynamodb_choosing_the_right_partition_key]
- [Key concepts of DynamoDB][link_concepts_dynamodb]

## How?

Amazon Aurora requires you to choose your engine compatibility i.e. MySQL or PostgreSQL after which you define:

- Create DB Cluster Parameter Group (parameters to be applied to all instance in a DB cluster)
- Create DB Cluster (the group of instances associated with a DB cluster)
- Create the Database Instance (adds a new instance to a DB cluster)

The AWS CLI features a cli [walkthrough][dyanmodb_cli_walkthrough] of how to provision a table, store an item, perform a query. It should be noted that as a rule of thumb you would probably use the [AWS SDK][aws_sdk] to store and retrieve data from DynamoDB.

## API and CLI features and verbs

### Amazon RDS

#### Features

- DB (Cluster) Parameter Group
- Db Cluster
- DB Instance
- DB (Cluster) Snapshot

#### Verbs (CRUD)

- create/copy
- describe
- modify
- delete

#### Outliers

Not my best work will see if I can optimise this list.

- add-option-to-option-group
- add-role-to-db-cluster
- add-role-to-db-instance
- add-source-identifier-to-subscription
- add-tags-to-resource
- apply-pending-maintenance-action
- authorize-db-security-group-ingress
- backtrack-db-cluster
- copy-option-group
- create-db-cluster-endpoint
- create-db-instance-read-replica
- create-db-security-group
- create-db-subnet-group
- create-event-subscription
- create-global-cluster
- create-option-group
- delete-db-cluster-endpoint
- delete-db-instance-automated-backup
- delete-db-parameter-group
- delete-db-security-group
- delete-db-snapshot
- delete-db-subnet-group
- delete-event-subscription
- delete-global-cluster
- delete-option-group
- describe-account-attributes
- describe-certificates
- describe-db-cluster-backtracks
- describe-db-cluster-endpoints
- describe-db-cluster-parameters
- describe-db-cluster-snapshot-attributes
- describe-db-engine-versions
- describe-db-instance-automated-backups
- describe-db-log-files
- describe-db-parameter-groups
- describe-db-parameters
- describe-db-security-groups
- describe-db-snapshot-attributes
- describe-db-subnet-groups
- describe-engine-default-cluster-parameters
- describe-engine-default-parameters
- describe-event-categories
- describe-event-subscriptions
- describe-events
- describe-global-clusters
- describe-option-group-options
- describe-option-groups
- describe-orderable-db-instance-options
- describe-pending-maintenance-actions
- describe-reserved-db-instances
- describe-reserved-db-instances-offerings
- describe-source-regions
- describe-valid-db-instance-modifications
- download-db-log-file-portion
- failover-db-cluster
- generate-db-auth-token
- list-tags-for-resource
- modify-current-db-cluster-capacity
- modify-db-cluster-endpoint
- modify-db-cluster-snapshot-attribute
- modify-db-snapshot-attribute
- modify-db-subnet-group
- modify-event-subscription
- modify-global-cluster
- promote-read-replica
- promote-read-replica-db-cluster
- purchase-reserved-db-instances-offering
- reboot-db-instance
- remove-from-global-cluster
- remove-option-from-option-group
- remove-role-from-db-cluster
- remove-role-from-db-instance
- remove-source-identifier-from-subscription
- remove-tags-from-resource
- reset-db-cluster-parameter-group
- reset-db-parameter-group
- restore-db-cluster-from-s3
- restore-db-cluster-from-snapshot
- restore-db-cluster-to-point-in-time
- restore-db-instance-from-db-snapshot
- restore-db-instance-from-s3
- restore-db-instance-to-point-in-time
- revoke-db-security-group-ingress
- start-activity-stream
- start-db-cluster
- start-db-instance
- stop-activity-stream
- stop-db-cluster
- stop-db-instance
- wait

### Amazon DynamoDB

#### Features

- Item
- Backup
- (Global) Table

#### Verbs (CRUD)

- create (global table, table and backup)
- describe/list (global table, table and backup), get-item, batch-get-item
- update (global table, table and backup), put-item, batch-put-item
- delete

#### Outliers

- describe-continuous-backups
- describe-endpoints
- describe-global-table-settings
- describe-limits
- describe-time-to-live
- list-tags-of-resource
- query
- restore-table-from-backup
- restore-table-to-point-in-time
- scan
- tag-resource
- transact-get-items
- transact-write-items
- untag-resource
- update-continuous-backups
- update-global-table-settings
- update-time-to-live
- wait

<!-- Links -->

[aws_free_tier]: https://aws.amazon.com/free/

[wiki_mysql]: https://en.wikipedia.org/wiki/MySQL
[rds_ssql_faq]: https://aws.amazon.com/rds/sqlserver/faqs/

[dynamodb_aws_sdk]: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.html
[dyanmodb_cli_walkthrough]: https://docs.aws.amazon.com/cli/latest/userguide/cli-services-dynamodb.html
[link_dynamodb_cheat_sheet]: http://serverlessarchitecture.com/2016/03/22/aws-dynamodb-cheat-sheet/
[link_dynamodb_design]: https://read.korzh.cloud/aws-dynamodb-partitions-and-key-design-56688bee8502
[dynamodb_choosing_the_right_partition_key]: https://aws.amazon.com/blogs/database/choosing-the-right-dynamodb-partition-key/
[link_concepts_dynamodb]: https://www.dynamodbguide.com/key-concepts/

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro/)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging/)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
  - [Amazon Single-Sign On](/2019/aws-devops-pro-certification-sso-cloudfront-autoscaling-route53/)
  - [Amazon CloudFront](/2019/aws-devops-pro-certification-sso-cloudfront-autoscaling-route53/)
  - [Auto Scaling](/2019/aws-devops-pro-certification-sso-cloudfront-autoscaling-route53/)
  - [Amazon Route53](/2019/aws-devops-pro-certification-sso-cloudfront-autoscaling-route53/)
  - Databases
    - Amazon RDS
    - Amazon Aurora
    - Amazon DynamoDB
