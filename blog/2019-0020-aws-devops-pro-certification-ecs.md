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

- is Amazon's Docker managed service. Naturally you also get a container registry service in the form of [Elastic Container Registry][aws_ecr] (ECR).
- comes in two varieties (launch types): EC2 or Fargate.
  - EC2 based clusters as the name imples uses EC2 instances as Docker hosts for containers.
    - You just pay for the resources spun up i.e. EC2 instances and/or EBS volumes.
  - Fargate abstracts away EC2 instances (much like serverless functions).
    - You pay for the vCPU and memory resources the container uses. This is charged at per second (with a minimum charge of a minute.
    - Fargate is only available to few [regions][docs_ug_fargate] (13 at the time of writing this)
- is not a Kubernetes managed services, this is a separate offering called [Elastic Container Service for Kubernetes Service][aws_eks] (EKS)

Additional resources:

- [AWS ECS User Guide][docs_ug]
- [AWS ECS FAQ][docs_faq]
- [AWS ECS API][docs_api]
- [AWS ECS CLI][docs_cli]

## Why?

- As with all managed services, you want to focus on the functionality rather than the upkeep of a service.
- With Docker becoming the lingua franca of the Cloud you can utilise 3rd party images and build solutions in a build block manner. Granted, Amazon has used the modularized concept for many years (OpsWorks and Elastic Beanstalk) before Docker became mainstream.

## When?

- Microservices and batch jobs are good workloads for a cluster.
- You want to migrate away from Docker managed through on-premises infrastructure or EC2 instances that are not ECS managed.

## How?

We're going to create an EC2 based ECS cluster, whilst Fargate is definitely the future for most workloads it's still only being rolled out to a limited amount of regions.

We're going to use the AWS CLI instead of the [ECS CLI][docs_ug_ecs_cli], this is to re-enforce learning of the API. For actual day to day use, Amazon recommend the ECS CLI.

## API and CLI features and verbs

**Features**

- Clusters
- Services
- Task Sets

**Verbs (CRUD)**

- create
- describe/list (cluster/services)
- update (service/task-set)
- delete

**Outliers**

- delete-account-setting
- delete-attributes
- deploy
- deregister-container-instance
- deregister-task-definition
- describe-container-instances
- describe-task-definition
- describe-tasks
- discover-poll-endpoint
- list-account-settings
- list-attributes
- list-container-instances
- list-tags-for-resource
- list-task-definition-families
- list-task-definitions
- list-tasks
- put-account-setting
- put-account-setting-default
- put-attributes
- register-container-instance
- register-task-definition
- run-task
- start-task
- stop-task
- submit-container-state-change
- submit-task-state-change
- tag-resource
- untag-resource
- update-container-agent
- update-container-instances-state
- update-service-primary-task-set
- wait

[aws_free_tier]: https://aws.amazon.com/free/
[aws_ecr]: https://aws.amazon.com/ecr/
[aws_eks]: https://aws.amazon.com/eks/
[docs_ug]: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html
[docs_ug_fargate]: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html
[docs_ug_ecs_cli]: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_CLI.html
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