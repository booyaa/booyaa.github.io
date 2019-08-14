---
permalink: "/2019/aws-devops-pro-certification-config-managed-services"
title: "AWS DevOps Pro Certification Blog Post Series: AWS Config and Managed Services"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-06-04 13:37:01 +0000"
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

AWS Config is a service that allows you to assess, audit and evaluate the configuration of your AWS resources. At a very basic level, this allows you to audit and track changes made to your environment.

AWS Managed Service is a service where AWS managed and operate your infrastructure on AWS. That's right, AWS will run your infrastructure (with some caveats to discussed in the next section).

Additional resources:

- [AWS Config Product Page][aws_config]
- [AWS Config FAQ][docs_config_faq]
- [AWS Config Developer Guide][docs_config_dg]
- [AWS Config API][docs_config_api]
- [AWS Config CLI][docs_config_cli]
- [AWS Managed Services Product Page][aws_managed_services]
- [AWS Managed Services FAQ][docs_managed_services_faq]

## Why?

AWS Config strong leans towards auditing, change control and compliance. There are some use cases in the next section, but this would help AWS users who are heavily regulated like financial organisations.

AWS Managed Service is generally aimed at large organisations (enterprises) that want a safer way to migrate from on-prem to cloud-based services. Whilst the service itself doesn't handle migration (this is handled by an AWS partner), you've probably had seen this scenario before:

> You work for an enterprise organisation, and the powers that be want you to move to the cloud. They don't want to pay for an expert, so they expect you to learn on the job.
>
> Months later, when the service goes up in smoke (because using one VPC and making it visible to the Internet seemed like a quick way to get things working). The powers that be finally hire the expert to design the cloud architecture from the ground up. Who then proceeds to berates you for not knowing your EC2s from your TF2s.

The key fact to take away from that vent (sorry) is that AWS will deliver an infrastructure that is based on their own best practice. You can concentrate on getting the continuous delivery pipeline working and making the necessary changes to your applications to get them working on AWS.

Eventually, you can take over this infrastructure, but this can be done when the team feels confident enough to do so.

## When?

Some of the suggested (by AWS) uses for AWS Config are:

- Discovery (of resources)
- Change Management
- Continuous audit and compliance
- Compliance as code
- Troubleshooting
- Security Analysis

AWS Managed Service is aimed at enterprises want to migrate to Cloud Services, but do not have to experience to do this themselves.

## How?

There are no practical sections for these two services.

Reminder: AWS Config will cost money if you decide to play around with it as it's not covered by the free tier.

## API and CLI features and verbs

There's no section for AWS Managed Services because there's no API/CLI.

Whilst there is an API/CLI for AWS Config, the common consensus is that you just need to be aware of the service. If you have come across a question during the exam that did rely on knowing the API please let me know.

[aws_free_tier]: https://aws.amazon.com/free/
[aws_config]: https://aws.amazon.com/config/
[docs_config_dg]: https://docs.aws.amazon.com/config/latest/developerguide/WhatIsConfig.html
[docs_config_faq]: https://aws.amazon.com/config/faq/
[docs_config_api]: https://docs.aws.amazon.com/config/latest/APIReference/Welcome.html
[docs_config_cli]: https://docs.aws.amazon.com/cli/latest/reference/configservice/index.html
[aws_managed_services]: https://aws.amazon.com/managed-services/
[docs_managed_services_faq]: https://aws.amazon.com/managed-services/faqs/

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro)
  - [CloudFormation](/2019/aws-devops-pro-certification-cloudformation)
  - [Elastic Beanstalk](/2019/aws-devops-pro-certification-elastic-beanstalk)
  - [OpsWorks](/2019/aws-devops-pro-certification-opsworks)
  - [AWS Lambda](/2019/aws-devops-pro-certification-lambda/)
  - [AWS ECS](/2019/aws-devops-pro-certification-ecs)
  - AWS Config
  - AWS Managed Services
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
