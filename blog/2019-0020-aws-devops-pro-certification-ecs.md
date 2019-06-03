---
permalink: "/2019/aws-devops-pro-certification-ecs"
title: "AWS DevOps Pro Certification Blog Post Series: AWS ECS"
categories:
  - "aws,study,certification,ecs"
layout: post.liquid
published_date: "2019-06-03 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification,ecs"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier][aws_free_tier]. You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try to refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

AWS ECS ...

- is Amazon's Docker managed service. Naturally you also get a container registry service in the form of Elastic Container Registry (ECR).
- comes in two varieties: EC2 or Fargate.
  - EC2 based clusters as the name imples.. the original would create an EC2 instance to host your containers. Fargate adopts the serverless abstraction and treats each container as a standalone task.
- 
- 

Additional resources:

- [AWS ECS User Guide][docs_ug]
- [AWS ECS FAQ][docs_faq]
- [AWS ECS API][docs_api]
- [AWS ECS CLI][docs_cli]


## Why?

...

## When?

- 1
- 2

## How?

...

## API and CLI features and verbs

**Features**

- x
- y
- z

**Verbs (CRUD)**

- create
- get/list
- update (function-[code/configuration])
- delete

**Outliers**

- xxx

[aws_free_tier]: https://aws.amazon.com/free/
[docs_ug]: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html
[docs_faq]: https://aws.amazon.com/ecs/faqs/
[docs_api]: https://docs.aws.amazon.com/AmazonECS/latest/APIReference/Welcome.html
[docs_cli]: https://docs.aws.amazon.com/cli/latest/reference/ecs/index.html

**AWS DevOps Pro Certification Blog Post Series**

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SLDC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro)
  - [CloudFormation](/2019/aws-devops-pro-certification-cloudformation)
  - [Elastic Beanstalk](/2019/aws-devops-pro-certification-elastic-beanstalk)
  - [OpsWorks](/2019/aws-devops-pro-certification-opsworks)
  - [AWS Lambda](/2019/aws-devops-pro-certification-lambda/)
  - AWS ECS
  - AWS Config
  - AWS Systems Manager
  - AWS Managed Services
- Domain 3: Monitoring and Logging
- Domain 4: Policies and Standards Automation
- Domain 5: Incident and Event Response
- Domain 6: High Availability, Fault Tolerance, and Disaster Recovery