---
permalink: "/2019/aws-devops-pro-certification-config-managed-services"
title: "AWS DevOps Pro Certification Blog Post Series: AWS ECS"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-06-04 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier][aws_free_tier]. You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try to refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

I've decided to cover AWS Config and AWS Managed services together since it didn't seem to have two very short blog posts.

AWS Config

- is...

AWS Managed Service

- is...

Additional resources:

- [AWS Config Product Page][aws_config]
- [AWS Config FAQ][docs_config_faq]
- [AWS Config Developer Guide][docs_config_dg]
- [AWS Config API][docs_config_api]
- [AWS Config CLI][docs_config_cli]
- [AWS Managed Services Product Page][aws_managed_services]
- [AWS Managed Services FAQ][docs_managed_services_faq]


## Why?

AWS Config...

AWS Managed Service...

## When?

AWS Config...

AWS Managed Service...

## How?

There's no practical sections for these two services.

Reminder: AWS Config will cost money if you decide to play around with it as it's not covered by the free tier.

## API and CLI features and verbs

There's no section for AWS Managed Services because there's no API/CLI.

Whilst there is an API/CLI for AWS Config, the common consensus is that you need to be aware of the service. If you have come across a question that did rely on knowning the API please let me know.

[aws_free_tier]: https://aws.amazon.com/free/
[aws_config]: https://aws.amazon.com/config/
[docs_config_dg]: https://docs.aws.amazon.com/config/latest/developerguide/WhatIsConfig.html
[docs_config_faq]: https://aws.amazon.com/config/faq/
[docs_config_api]: https://docs.aws.amazon.com/config/latest/APIReference/Welcome.html
[docs_config_cli]: https://docs.aws.amazon.com/cli/latest/reference/configservice/index.html
[aws_managed_services]: https://aws.amazon.com/managed-services/
[docs_managed_services_faq]: https://aws.amazon.com/managed-services/faqs/

**AWS DevOps Pro Certification Blog Post Series**

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SLDC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro)
  - [CloudFormation](/2019/aws-devops-pro-certification-cloudformation)
  - [Elastic Beanstalk](/2019/aws-devops-pro-certification-elastic-beanstalk)
  - [OpsWorks](/2019/aws-devops-pro-certification-opsworks)
  - [AWS Lambda](/2019/aws-devops-pro-certification-lambda/)
  - [AWS ECS](/2019/aws-devops-pro-certification-ecs)
  - AWS Config
  - AWS Managed Services
- Domain 3: Monitoring and Logging
- Domain 4: Policies and Standards Automation
- Domain 5: Incident and Event Response
- Domain 6: High Availability, Fault Tolerance, and Disaster Recovery