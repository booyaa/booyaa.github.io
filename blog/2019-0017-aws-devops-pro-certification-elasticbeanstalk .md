---
permalink: "/2019/aws-devops-pro-certification-elasticbeanstalk"
title: "AWS DevOps Pro Certification Blog Post Series: Elastic Beanstalk"
categories:
  - "aws,study,certification,elasticbeanstalk"
layout: post.liquid
published_date: "2019-05-28 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification,elasticbeanstalk"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier](https://aws.amazon.com/free/). You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try to refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

Elastic Beanstalk is

- a PaaS
- powered by CloudFormation behind the scene
- Elastic Beanstalk Extensions are...

Additional resources:

- dev.to tag for [Elastic Beanstalk][devto_elasticbeanstalk]
- [Elastic Beanstalk FAQs](https://aws.amazon.com/elasticbeanstalk/faqs/)
- [Elastic Beanstalk User Guide](https://aws.amazon.com/elasticbeanstalk/)
- [Elastic Beanstalk API](https://docs.aws.amazon.com/elasticbeanstalk/latest/api/Welcome.html)
- [Elastic Beanstalk CLI](https://docs.aws.amazon.com/cli/latest/reference/elasticbeanstalk/index.html)

## Why?

Of all the Orchestration tools provided by AWS, this is probably the easiest to use. Just like Heroku which pioneered this method of simplifying the application deployments, this is aimed at Developers who don't want to get involved in the operational side of provisioning infrastructure.

Recall the level of complexity around CloudFormation, this isn't for everyone.

## When?

- Time poor or not willing to learn a more complex, but ultimately highly configurable Orchestration tool.
- Don't have an operations or sysadmin handy

## How?

- Demo of basic docker image and non-docker image
- Elastic Beanstalk Extension

## API and CLI features and verbs

**Features**

- Application(s)
  - Version
  - Resource Lifecycle
- Environment
  - Configuration
- Platform Version
- Storage

**Verbs (CRUD) **

- Applications
  - Create (Application [Version])
  - Describe (Applications)
  - Update (Application [Resource Lifecycle])
  - Delete (Application [Version])

- Environment
- Platform Version
- Storage

**Outliers**

- Stacks
  - CancelUpdateStack
  - ContinueUpdateRollback
  - DescribeStackDriftDetectionStatus
  - EstimateTemplateCost
  - GetTemplateSummary
  - UpdateTerminationProtection
  - ValidateTemplate

- Change sets
  - ExecuteChangeSet

- Stack sets
  - StopStackSetOperation

**AWS DevOps Pro Certification Blog Post Series**

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SLDC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro)
  - CloudFormation
  - Elastic Beanstalk
  - OpsWorks
  - AWS Lambda
  - AWS ECS
  - AWS Config
  - AWS Systems Manager
  - AWS Managed Services
- Domain 3: Monitoring and Logging
- Domain 4: Policies and Standards Automation
- Domain 5: Incident and Event Response
- Domain 6: High Availability, Fault Tolerance, and Disaster Recovery

[docs_creationpolicy]: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-creationpolicy.html
[devto_elasticbeanstalk]: https://dev.to/search?q=elasticbeanstalk

[wiki_cidr]: https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing

[aws_arn]: https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html

[wiki_iso8601_durations]: https://en.wikipedia.org/wiki/ISO_8601#Durations