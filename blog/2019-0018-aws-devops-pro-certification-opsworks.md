---
permalink: "/2019/aws-devops-pro-certification-opsworks"
title: "AWS DevOps Pro Certification Blog Post Series: OpsWorks"
categories:
  - "aws,study,certification,opsworks"
layout: post.liquid
published_date: "2019-05-29 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification,opsworks"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier](https://aws.amazon.com/free/). You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try to refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

OpsWorks is

- provides three managed services
  - AWS OpsWorks for Chef Automate
  - AWS OpsWorks for Puppet Enterprise
  - AWS OpsWorks Stacks which uses Chef Solo
  
In this post we'll primarily focussing on AWS OpsWorks Stacks, but know that the others are managed services that can be utilised instead of running yourself (compare to self hosting a postgresql database server and using RDS).

OpsWorks Stack...

- is a declarative state engine (as is Chef Automate and Solo). By this mean you define what you want to happen i.e. have a web server running, OpsWorks/Chef will then determine how to do it on the operating system that the Chef agent is installed on. Recall that package managers and configuration files live in different places in Operating Systems, even in distributions of Operating Systems (CentOS, Debian et al).
- FIXME: Rewrite this bit - A cookbook is the fundamental unit of configuration and policy distribution. A cookbook defines a scenario and contains everything that is required to support that scenario:
  - Recipes that specify the resources to use and the order in which they are to be applied
  - Attribute values
  - File distributions
  - Templates
  - Extensions to Chef, such as custom resources and libraries
- also unique compared to other Chef managed services in that it uses the concept of "Layers"
- autoscaling and scheduled scaling enabled
- provdes you with a choice of Chef 11 or 12 stacks. The different between the two version is that Chef 11 has built in cookbooks, where as Chef 12 allows you to use your own or community cookbooks.
- has a concept of Layers (think of these as different layers of functionality i.e. web server, database server)
  - these layers can be OpsWorks, ECS or RDS based


Additional resources:

- FAQs
  - [OpsWorks for Chef Automate](https://aws.amazon.com/opsworks/chefautomate/faqs/?nc=sn&loc=5)
  - [OpsWorks for Puppet Enterprise](https://aws.amazon.com/opsworks/puppetenterprise/faqs/?nc=sn&loc=5)
  - [OpsWorks Stacks](https://aws.amazon.com/opsworks/stacks/faqs/?nc=sn&loc=5)
- [OpsWorks Stacks User Guide](https://docs.aws.amazon.com/opsworks/latest/userguide/welcome.html)
- APIs
  - [OpsWorks Stacks](https://docs.aws.amazon.com/opsworks/latest/APIReference/Welcome.html)
  - [OpsWorks Configuration Management](https://docs.aws.amazon.com/opsworks-cm/latest/APIReference/Welcome.html)
- CLIs
  - [OpsWorks Stacks](https://docs.aws.amazon.com/cli/latest/reference/opsworks/index.html)
  - [OpsWork Configuration Management](https://docs.aws.amazon.com/cli/latest/reference/opsworks-cm/index.html)

## Why?

If CloudFormation is most configurable (and ultimate the most complex) orchestration tool (requiring a fair bit of Operations/Infrastructure experience) and Elastic Beanstalk is developer friendly and quick to get up and running. Then OpsWorks Stacks is probably the middle ground.

CloudFormation is a tool that is very specific to AWS, where as your Chef recipes could be used on other Chef installations.

## When?

- You have familiarity with Chef
- What a certain degree of control, but not the complexity of CloudFormation.

## How?



## API and CLI features and verbs

### Stacks

**Features**

- App
- Instance
- Layer
- Stack
- User Profile

**Verbs (CRUD) **

- create
- describe
- update
- delete

**Outliers**

- assign-instance
- assign-volume
- associate-elastic-ip
- attach-elastic-load-balancer
- clone-stack
- create-deployment
- deregister-ecs-cluster
- deregister-elastic-ip
- deregister-instance
- deregister-rds-db-instance
- deregister-volume
- describe-agent-versions
- describe-commands
- describe-deployments
- describe-ecs-clusters
- describe-elastic-ips
- describe-elastic-load-balancers
- describe-load-based-auto-scaling
- describe-my-user-profile
- describe-operating-systems
- describe-permissions
- describe-raid-arrays
- describe-rds-db-instances
- describe-service-errors
- describe-stack-provisioning-parameters
- describe-stack-summary
- describe-time-based-auto-scaling
- describe-user-profiles
- describe-volumes
- detach-elastic-load-balancer
- disassociate-elastic-ip
- get-hostname-suggestion
- grant-access
- list-tags
- reboot-instance
- register
- register-ecs-cluster
- register-elastic-ip
- register-instance
- register-rds-db-instance
- register-volume
- set-load-based-auto-scaling
- set-permission
- set-time-based-auto-scaling
- start-instance
- start-stack
- stop-instance
- stop-stack
- tag-resource
- unassign-instance
- unassign-volume
- untag-resource
- update-elastic-ip
- update-my-user-profile
- update-rds-db-instance
- update-volume
- wait

### Configuration Management

**Features**

- Server
- Engine
- Backup
- Events
- Account attributes

**Verbs (CRUD) **

- create (backup/server)
- describe (backups/servers/account-attribute/events)
- update (server/server-engine-attributes)
- delete (backup/server)

**Outliers**

- associate-node
- describe-node-association-status
- disassociate-node
- export-server-engine-attribute
- restore-server
- start-maintenance
- wait

**AWS DevOps Pro Certification Blog Post Series**

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SLDC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro)
  - [CloudFormation](/2019/aws-devops-pro-certification-cloudformation)
  - [Elastic Beanstalk](/2019/aws-devops-pro-certification-elastic-beanstalk)
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