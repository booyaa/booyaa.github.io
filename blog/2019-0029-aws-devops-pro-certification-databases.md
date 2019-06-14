---
permalink: "/2019/aws-devops-pro-certification-databases"
title: "AWS DevOps Pro Certification Blog Post Series: Databases"
categories:
  - "aws,databases,rds,dynamodb"
layout: post.liquid
published_date: "2019-06-15 13:37:00 +0000"
is_draft: true
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

**Amazon RDS** is a managed service for Relational Database engines Service (RDS). AWS support the following engines:

- MySQL is an open source database engine
- MariaDB is a fork of MySQL when the former was acquired by Oracle (through the [acquisition][wiki_mysql] of Sun Systems)
- PostgreSQL is an open source database engine
- Oracle is a commercial engine by Oracle
- SQL Server is a commercial engine by Microsoft
- Amazon Aurora is a MySQL / Postgres compatible relational database engine

**Amazon DynamoDB* is a priopriety NoSQL dataabase service offered by Amazon.

## Why?

Managed services for database engines like all managed service remove key concerns:

- provisioning/scaling/termination of servers that host the database engines
- maintenance of servers (patching)
- backups and restores

These concerns often affect the ability to provide database server that is fault tolerant, highly available and has contingency for disaster recovery.

N.B. there's a caveat around storage scaling that it won't be applicable to SQL Server instances. The details can be found in the [SQL Server FAQs][rds_ssql_faq] (Why can’t I scale my storage?)

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

The key take away from this example is to remember Relational Databases store records tabularly in rows.

NoSQL database engines are a bit of a catch all, but in essence if you don't store your data tabularly you're probably a NoSQL database engine. Amazon DynamoDB is a Key/Value pair and Document store. Key/Value store allow you to store data like a Hash (associative array/dictionary), you provide a `key` and the value is returned, you may have used one without know as they're often referred to as cache servers i.e. Redis. Document stores allow you to data in a structured way common formats are XML and JSON, often these are the database engines most people associate with NoSQL i.e. CouchDB and MongoDB.

## When?

Amazon Aurora provides a compatble engine that is 3x faster than PostgreSQL and 5x faster than MySQL. In terms of pricing, you need to compare the other RDS engines as a multi-AZ deployment and memory optimised instances.

## How?

???

## API and CLI features and verbs

**Features**

- 1
- 2
- 3

**Verbs (CRUD)**

- create
- describe/get/list
- update/put
- delete

**Outliers**

- 1
- 2
- 3

<!-- Links -->

[aws_free_tier]: https://aws.amazon.com/free/

[wiki_mysql]: https://en.wikipedia.org/wiki/MySQL
[rds_ssql_faq]: https://aws.amazon.com/rds/sqlserver/faqs/



**AWS DevOps Pro Certification Blog Post Series**

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SLDC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
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
