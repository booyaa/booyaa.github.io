---
permalink: "/2019/aws-devops-pro-certification-xray"
title: "AWS DevOps Pro Certification Blog Post Series: AWS X-Ray"
categories:
  - "aws,study,certification,xray"
layout: post.liquid
published_date: "2019-06-05 13:16:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification,xray"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier][aws_free_tier]. You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try to refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

AWS X-Ray is an application performance monitoring (APM) tool similar to New Relic, Solarwind TraceView or Microsoft Applications Insights. APM tools go beyond the usual metric level of capturing, instead of performing traces which are data rich with information about application requests, the response time of blocks of code and latency. In short, they can often give you a context into what the application was done with at a request at a given time.

In addition to full data capture around an application, X-Ray can also build a service map that shows the various components that your application interacts with. The example application in the [Getting Started][xray_getting_started] guide shows the interactions between the Java app, DynamoDB, SNS and external API.

The following AWS service (that are in scope for this exam) that provide integration with X-Ray are:

- AWS Lambda
- ELB
- AWS Elastic Beanstalk

The full list of services integrated with X-Ray can be found in the [Developer Guide][docs_guide_integrated_services]

Additional resources:

- [AWS X-Ray Product Page][aws_product_page]
- [AWS X-Ray FAQ][docs_faq]
- [AWS X-Ray Guide][docs_guide]
- [AWS X-Ray API][docs_api]
- [AWS X-Ray CLI][docs_cli]

## Why?

Previously debugging of application could be done in a post-mortem fashion analysing dumps, stack traces. This was often done offline. With the advent of APMs, you can now look at your application's health whilst in-flight.

## When?

X-Ray only makes sense in a Production environment as it's used as a troubleshooting tool. There might be some value in using in other environments as a learning aid.

## How?

There's an excellent tutorial that is part of the [Getting Started][xray_getting_started] guide. It's highly recommended to get familiar with the feature set of X-Ray.

As always, remember you may incur a charge for the resources started using this guide.

## API and CLI features and verbs

*Features**

- Groups
- Sampling Rules

**Verbs (CRUD)**

- create group/sampling-rule
- get group(s)/sampling-rule
- update group/sampling-rule
- delete groupsampling-rule

**Outliers**

- batch-get-traces
- get-encryption-config
- get-sampling-statistic-summaries
- get-sampling-targets
- get-service-graph
- get-time-series-service-statistics
- get-trace-graph
- get-trace-summaries
- put-encryption-config
- put-telemetry-records
- put-trace-segments

Remember there's specific [APIs][docs_api] for Java, .Net (and Core), Ruby, Node and Python SDKs.

[aws_free_tier]: https://aws.amazon.com/free/
[aws_product_page]: https://aws.amazon.com/xray/
[docs_faq]: https://aws.amazon.com/xray/faqs/
[docs_guide]: http://docs.aws.amazon.com/xray/latest/devguide/aws-xray.html
[docs_guide_integrated_services]: https://docs.aws.amazon.com/xray/latest/devguide/xray-usage.html#xray-usage-services
[docs_api]: https://docs.aws.amazon.com/xray/latest/api/Welcome.html
[docs_cli]: https://docs.aws.amazon.com/cli/latest/reference/xray/index.html
[xray_getting_started]: https://eu-west-2.console.aws.amazon.com/xray/home?region=eu-west-2#/getting-started.html

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro/)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging/)
  - [CloudWatch](/2019/aws-devops-pro-certification-cloudwatch/)
  - AWS X-Ray
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
