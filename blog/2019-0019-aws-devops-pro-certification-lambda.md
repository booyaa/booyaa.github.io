---
permalink: "/2019/aws-devops-pro-certification-aws-lambda"
title: "AWS DevOps Pro Certification Blog Post Series: AWS Lambda"
categories:
  - "aws,study,certification,lambda"
layout: post.liquid
published_date: "2019-06-01 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification,lambda"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier][aws_free_tier]. You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try to refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

AWS Lambda is ...

- a Serverless function framework
- highly integrated with AWS services
- a good fit for DevOps tasks

Additional resources:

- [AWS Lambda User Guide][docs_ug]
- [AWS Lambda FAQ][docs_faq]
- [AWS Lambda API][docs_api]
- [AWS Lambda CLI][docs_cli]


## Why?

Here's some ideas that a DevOps / Infra team might use cases for AWS Lambda. None of this is new or ground breaking innovations. The only difference is that when trying to implenent these in AWS Lambda we no longer need to factor new servers, billing is per second and Lambda was built to talk with other AWS services in mind.

- Automate backups / cycle through EBS snapshots
- Generating reports - use it to audit resources on AWS (if you don't want to shell out on AWS Config)
- Perform S3 ops i.e. moving code build artefacts to location on a given S3 bucket
- Batch log processing - extract, transform and load (ETL) from various resources and consolidate into a central data warehouse
- Scheduled Tasks - perform any of the above use cases at a given scheduled, just like cron jobs
- ChatOps - running Slack chat bots to manage and report against your infrastructure

Source: [Why DevOps Engineers Love AWS (espagon)][link_devops_loves_aws_lambda]

## When?

- You need to perform a DevOps task, but don't want to go through the trouble of provisioning an application server to host it.
- You're trying to break up a monolithic management server that's responsible for scheduling and running devops tasks.

## How?

- https://docs.aws.amazon.com/lambda/latest/dg/with-userapp.html
- https://aws.amazon.com/blogs/compute/kotlin-and-groovy-jvm-languages-with-aws-lambda/

We're going to use a simple example where the DevOps engineer wants to log all files being uploaded for a given S3 bucket.

- Create role
- Create code
- Zip it
- Create function with role
- Test
- Tear down


## API and CLI features and verbs

**Features**

- Alias
- Event Source Mapping
- Function

**Verbs (CRUD)**

- create
- get/list
- update (function-[code/configuration])
- delete

**Outliers**

- add-layer-version-permission
- add-permission
- delete-function-concurrency
- delete-layer-version
- get-account-settings
- get-function-configuration
- get-layer-version
- get-layer-version-by-arn
- get-layer-version-policy
- get-policy
- invoke
- list-layer-versions
- list-layers
- list-tags
- list-versions-by-function
- publish-layer-version
- publish-version
- put-function-concurrency
- remove-layer-version-permission
- remove-permission
- tag-resource
- untag-resource
- wait

[aws_free_tier]: https://aws.amazon.com/free/
[docs_ug]: https://docs.aws.amazon.com/lambda/latest/dg/welcome.html?sc_ichannel=ha&sc_icampaign=pa_lamdbaresourcestop&sc_icontent=devguide&sc_detail=1
[docs_faq]: https://aws.amazon.com/lambda/faqs/
[docs_api]: https://docs.aws.amazon.com/lambda/latest/dg/API_Reference.html
[docs_cli]: https://docs.aws.amazon.com/cli/latest/reference/lambda/index.html
[link_devops_loves_aws_lambda]: https://epsagon.com/blog/why-devops-engineers-love-aws-lambda/


**AWS DevOps Pro Certification Blog Post Series**

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SLDC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro)
  - [CloudFormation](/2019/aws-devops-pro-certification-cloudformation)
  - [Elastic Beanstalk](/2019/aws-devops-pro-certification-elastic-beanstalk)
  - [OpsWorks](/2019/aws-devops-pro-certification-opsworks)
  - AWS Lambda
  - AWS ECS
  - AWS Config
  - AWS Systems Manager
  - AWS Managed Services
- Domain 3: Monitoring and Logging
- Domain 4: Policies and Standards Automation
- Domain 5: Incident and Event Response
- Domain 6: High Availability, Fault Tolerance, and Disaster Recovery