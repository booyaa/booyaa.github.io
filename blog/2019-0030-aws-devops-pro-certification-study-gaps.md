---
permalink: "/2019/aws-devops-pro-certification-study-gaps"
title: "AWS DevOps Pro Certification Blog Post Series: Study Gaps"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-06-22 13:37:00 +0000"
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

## Study Gaps

This section will change a lot as I find new gaps whilst sitting in mock exams.

I've had a go at the [sample exam][aws_sample_exam] under exam condititions (which before AWS made the exams adaptive would leave you with about 2 mins per question). Here's some items where I need to fill in gaps:

### General

- Knowing which services are able to use [Resource Based Policies][iam_services]:
  - Lambda ([Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro)).
  - ECR (via ECS - [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro)).
  - CloudWatch Logs ([Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging)).
  - AWS Secrets Manager ([Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)).

### SDLC Automation

- Need to read the [blue/green][devopswp_bluegreen] whitepaper ([SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)). Pssst if you have the time you should read all the [DevOps][devopswp] related whitepapers!

#### Blue/Green Techniques using CloudFormation or manually provisioned i.e. through AWS Console

This is based on the [Blue/Green][devopswp_bluegreen] whitepaper.

- Update DNS Routing with Amazon Route 53 
  - Setup
    - Route 53 DNS
    - Blue/Green Environments 
      - Elastic Load Balancer (ELB)
      - Autoscaling group behind xthe ELB
      - Both environments are point to the same database instance (Amazon RDS Multi-AZ)
  - Sub patterns
    - **Classic DNS pattern** - Flip alias (live) record from blue to green
    - **Classic DNS-weighted distribution** - Use split to send traffic to different environments
- Swap the Auto Scaling Group Behind Elastic Load Balancer
  - Setup
    - Route 53 DNS
    - ELB pointing to
    - Blue and Green Auto Scaling Groups
    - Both ASGs point to the same database  instance (Amazon RDS Multi-AZ)
- Update Auto Scaling Group Launch Configurations 
  - Setup
    - Route 53 DNS
    - ELB point to
    - Auto Scaling Group containing
      - Blue Launch Config (LC)
      - Green Launch Config (LC)
    - LCs  are point to Amazon DynamoDB, Amazon RDS Multi-AZ or Amazon ElastiCache

There’s patterns for OpsWorks and Elastic Beanstalk, will add if I have time.

### Configuration Management and Infrastructure as Code

- Lambda
  - Deploying new versions
  - What triggers are available
    - API Gateway
    - AWS IoT
    - Application Load Balancer
    - CloudWatch Events ([Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging))
    - CloudWatch Logs ([Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging))
    - CodeCommit ([SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/))
    - Cognito Sync Trigger
    - DynamoDB ([High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/))
    - Kinesis ([Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/))
    - Also doesn't hurt to know the following services are supported: S3,SNS and SQS

### Monitoring and Logging

- CloudWatch events for the [services][cw_service_events] covered in the exam
  - SDLC Automation
    - CodeCommit
    - CodeBuild
    - CodeDeploy
    - CodePipeline
  - Configuration Management and Infrastrcuture as Code
    - AWS Config
    - AWS OpsWorks
    - AWS (Lambda) Step Functions
    - AWS ECS
  - Monitoring and Logging
    - CloudWatch (scheduled events)
  - Policies and Standards Automation
    - Amazon Macie
    - AWS Systems Manager
      - Configuration Compliance
      - Maintenance Windows
      - Parameter Store
    - Trusted Advisor
  - Incident and Event Reporting
    - Amazon GuardDuty
  - Fault Tolerance, High Availability and Disaster Recovery
    - Amazon EC2 Auto Scaling
- CloudWatch Event Rule [Targets][cw_event_rule_targets]
  - SDLC Automation
    - Code Build
    - Code Pipeline
  - Configuration Management and Infrastructure as Code
    - Lambda (and Step) function
  - Incident and Events Reporting
    - Kinesis
      - Data Streams
      - Data Firehose
    - Amazon Inspector
  - Policies and Standards Automation
    - Systems Manager
      - Run Command
      - Automation
  - Nice to knows: SNS and SQS

### Fault Tolerance, High Availability and Disaster Recovery

- RDS
  - snapshots and their use in a DR situation. ([High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)).
  - Understanding Recovery Time Objective (RTO) and Recovery Point Objective (RPO) with DR in mind. ([High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)).

### Policies and Standards Automation

- AWS Systems Manager - EC2 patch groups and Patch Manager's baselines ([Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/))
- AWS Service Catalogue - how to offer products that provide different tiers (web, web + db) or stacks (.NET or Ruby) ([Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/))

<!-- links -->

[aws_free_tier]: https://aws.amazon.com/free/
[aws_sample_exam]: https://d1.awsstatic.com/training-and-certification/docs-devops-pro/AWS%20Certified%20DevOps%20Engineer%20-%20Professional_Sample%20Questions.pdf
[cw_service_events]: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/EventTypes.html
[cw_event_rule_targets]: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/WhatIsCloudWatchEvents.html
[devopswp]: https://aws.amazon.com/whitepapers/
[devopswp_bluegreen]: https://d1.awsstatic.com/whitepapers/AWS_Blue_Green_Deployments.pdf
[iam_services]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-services-that-work-with-iam.html

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
