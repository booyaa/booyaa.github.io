---
permalink: "/2019/aws-devops-pro-certification-monitoring-and-logging"
title: "AWS DevOps Pro Certification Blog Post Series: Monitoring and Logging"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-06-04 13:37:02 +0000"
is_draft: false
data:
  tags: "aws,study,certification"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## What does the exam guide say?

To pass this domain, you'll need to know the following:

- Determine how to set up the aggregation, storage, and analysis of logs and metrics
- Apply concepts required to automate monitoring and event management of an environment
- Apply concepts required to audit, log, and monitor operating systems, infrastructures, and applications
- Determine how to implement tagging and other metadata strategies

## What whitepapers are relevant?

According to the [AWS Whitepapers for DevOps](https://aws.amazon.com/whitepapers/#dev-ops) we should look at the following documents:

- [Introduction to DevOps on AWS (20 pages)](https://d1.awsstatic.com/whitepapers/AWS_DevOps.pdf)

## What services and products covered in this domain?

- [CloudWatch](https://aws.amazon.com/cloudwatch/) - Complete visibility of your cloud resources and applications. Chances are if you provision a resource (well at least through the Console), it's probably logging in CloudWatch.
- [AWS X-Ray](https://aws.amazon.com/xray/) - Analyze and debug production, distributed applications. Similar products are Rollbar, Sentry, Azure Application Insights.

Source: [AWS DevOps - Monitoring and Logging page](https://aws.amazon.com/devops/#monitoring)

## What about other types of documentation?

If you have the time, by all means, read the User Guides, but they are usually a couple of hundred pages. Alternatively, get familiar with the services using the FAQs:

- [CloudWatch](https://aws.amazon.com/cloudwatch/faqs/)
- [AWS X-Ray](https://aws.amazon.com/xray/faqs/)

You're all expected to know the APIs

- [CloudWatch](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/index.html)
- [AWS X-Ray](https://docs.aws.amazon.com/xray/latest/api/Welcome.html). There's specific APIs for the Java, .Net (and Core), Ruby, Node and Python SDKs.

Before you panic, you'll start to spot a pattern with the API verbs.

And the CLI commands

- [CloudWatch](https://docs.aws.amazon.com/cli/latest/reference/cloudwatch/index.html). This is for the command that is part of the AWS CLI. The standalone CloudWatch CLI has been deprecated.

There's no CLI for X-ray

As with the API, there are patterns to the commands.

## Monitoring and Logging (yawn)

Monitoring and logging are what DevOps engineers do on a daily basis.  We use the data from our logs to spot patterns, and the monitoring alerts to react to issues and mitigate outages.

It's not the most exciting topic to cover, it's a necessity for the role. I hope in future versions of the exam, this domain extends to Observability.

This domain contains the fewest services, but make no mistake CloudWatch integrates with so many services it makes sense to have a good understanding of the features it provides. AWS X-Ray if you've used similar products, should be an easier concept to grasp (famous last words).

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro/)
- Domain 3: Monitoring and Logging
  - [CloudWatch](/2019/aws-devops-pro-certification-cloudwatch/)
  - [AWS X-Ray](/2019/aws-devops-pro-certification-xray/)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
