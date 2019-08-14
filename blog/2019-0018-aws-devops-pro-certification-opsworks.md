---
permalink: "/2019/aws-devops-pro-certification-opsworks"
title: "AWS DevOps Pro Certification Blog Post Series: OpsWorks"
categories:
  - "aws,study,certification,opsworks"
layout: post.liquid
published_date: "2019-05-31 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification,opsworks"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier][aws_free_tier]. You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try to refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

OpsWorks is

- provides three managed services
  - AWS OpsWorks for Chef Automate
  - AWS OpsWorks for Puppet Enterprise
  - AWS OpsWorks Stacks which uses Chef Solo
  
In this post, we'll primarily be focussing on AWS OpsWorks Stacks, but know that the others are managed services that can be utilised instead of running yourself (think of the comparison to self-hosting a database server versus using RDS).

OpsWorks Stack...

- is a declarative state engine (as is Chef Automate and Solo). By this mean you define what you want to happen i.e. have a web server running, OpsWorks/Chef will then determine how to do it on the operating system that the Chef agent is installed on. Recall that package managers and configuration files live in different places in Operating Systems, even in distributions of Operating Systems (CentOS, Debian et al).
- is also unique compared to other Chef managed services in that it uses the concept of "Layers"
- autoscaling and scheduled scaling enabled
- provides you with a choice of Chef 11 or 12 stacks. The difference between the two versions is that Chef 11 has built-in cookbooks, whereas Chef 12 allows you to use your own or community cookbooks.
- has a concept of Layers (think of these as different layers of functionality i.e. web server, database server)
  - these layers can be OpsWorks, ECS or RDS based

Additional resources:

- FAQs
  - [OpsWorks for Chef Automate][faq_chef_automate]
  - [OpsWorks for Puppet Enterprise][faq_puppet_enterprise]
  - [OpsWorks Stacks][faq_opsworks_stacks]
- [OpsWorks Stacks User Guide][docs_ug]
- APIs
  - [OpsWorks Stacks][docs_api_stacks]
  - [OpsWorks Configuration Management][docs_api_cm]
- CLIs
  - [OpsWorks Stacks][docs_cli_stacks]
  - [OpsWork Configuration Management][docs_cli_cm]

## Why?

If CloudFormation is most configurable (and ultimate the most complex) orchestration tool (requiring a fair bit of Operations/Infrastructure experience) and Elastic Beanstalk is developer friendly and quick to get up and running. Then OpsWorks Stacks is probably the middle ground.

CloudFormation is a tool that is very specific to AWS, whereas your Chef recipes could be used on other Chef installations.

## When?

- You have familiarity with Chef
- Want a certain degree of control, but not the complexity of CloudFormation.

## How?

I've not had the time to hunt down the CLI equivalent for this section, please drop me a comment if you have resources I can use!

I've loosely based this around the [Getting Started][docs_ug_getting_started] guide for Linux with the following exceptions:

- Using a Chef 11 Stack
- The application is a static site
- The application deployment is via https (the GitHub download as zip link)

- Go to AWS Console and find the OpsWorks service (if you don't have a Stack defined you'll be at the introductory page which provides info about Stacks and the other managed services offerings).
- Create a stack (Chef 11)
  - Provide a stack name
  - Everything else is based on the region you choose i.e. VPC and subnet or sensible defaults provided by AWS (Operating System)
- Add a layer (OpsWorks / ECS / RDS) - well drill into OpsWorks
  - Set *Layer Type* as `Static Web Server`
    - The layer type is based on blueprints and can be load balancing, app server (Static, Node, PHP and Rails) and a few other types (MySQL, Memcache, Ganglia and custom). 
    - You can only have one type as a Layer.
  - You can assign to an Elastic Load Balancer if you have one available (it will become a new layer). This makes sense if you've got multiple instances.
- Add an instance(s)
  - *Hostname* - will be predefined based on the layer type
  - *Size* - AROOGA! AROOGA! aws wants to set this as `c4.large` maybe pick something cheaper like `t2.micro`? ;)
  - *Subnet* - you will want to distribute your instances across different subnets.
  - *Advanced* is where you can configure scaling type (24/7, time or load based) or override default settings for OS and SSH key
  - Start the instance(s)
- Add an Application
  - Provide a name
  - Set *Repository Type* as `HTTP Archive` (note: other options as Git, Subversion, S3 and Other)
  - Set *Repository URL* as `https://github.com/booyaa/static-site-demo/archive/master.zip`
  - Click •Add App* button
- Deploy the app
  - Click the *Deploy* link next to your newly created "App"
  - By default, the instances associated with your `Static Web Server` will be selected
  - Click the *Deploy* button
- Wait until the app has been deployed to your instance, then go to the *Instances* link in the sidebar and click on the *Public IP* of your instance. This should launch the static site.

To tear down:

- Delete the app
- Stop the instances
- Delete the instances
- Delete the `Static Web Server` layer
- Delete the app

## API and CLI features and verbs

### Stacks

#### Features

- App
- Instance
- Layer
- Stack
- User Profile

#### Verbs (CRUD)

- create
- describe
- update
- delete

#### Outliers

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

#### Features

- Server
- Engine
- Backup
- Events
- Account attributes

#### Verbs (CRUD)

- create (backup/server)
- describe (backups/servers/account-attribute/events)
- update (server/server-engine-attributes)
- delete (backup/server)

#### Outliers

- associate-node
- describe-node-association-status
- disassociate-node
- export-server-engine-attribute
- restore-server
- start-maintenance
- wait

[aws_free_tier]: https://aws.amazon.com/free/
[faq_chef_automate]: https://aws.amazon.com/opsworks/chefautomate/faqs/?nc=sn&loc=5
[faq_puppet_enterprise]: https://aws.amazon.com/opsworks/puppetenterprise/faqs/?nc=sn&loc=5
[faq_opsworks_stacks]: https://aws.amazon.com/opsworks/stacks/faqs/?nc=sn&loc=5
[docs_ug]: https://docs.aws.amazon.com/opsworks/latest/userguide/welcome.html
[docs_ug_getting_started]: https://docs.aws.amazon.com/opsworks/latest/userguide/gettingstarted-linux.html
[docs_api_stacks]: https://docs.aws.amazon.com/opsworks/latest/APIReference/Welcome.html
[docs_api_cm]: https://docs.aws.amazon.com/opsworks-cm/latest/APIReference/Welcome.html
[docs_cli_stacks]: https://docs.aws.amazon.com/cli/latest/reference/opsworks/index.html
[docs_cli_cm]: https://docs.aws.amazon.com/cli/latest/reference/opsworks-cm/index.html

### AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro/)
  - [CloudFormation](/2019/aws-devops-pro-certification-cloudformation)
  - [Elastic Beanstalk](/2019/aws-devops-pro-certification-elastic-beanstalk/)
  - OpsWorks
  - [AWS Lambda](/2019/aws-devops-pro-certification-lambda/)
  - [AWS ECS](/2019/aws-devops-pro-certification-ecs/)
  - [AWS Config](/2019/aws-devops-pro-certification-config-managed-services/)
  - [AWS Managed Services](/2019/aws-devops-pro-certification-config-managed-services/)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
