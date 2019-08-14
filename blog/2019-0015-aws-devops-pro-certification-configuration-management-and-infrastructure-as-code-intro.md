---
permalink: "/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro"
title: "AWS DevOps Pro Certification Blog Post Series: Configuration Management and Infrastructure as Code introduction"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-05-11 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## What does the exam guide say?

To pass this domain, you'll need to know the following:

- Determine deployment services based on deployment needs
- Determine application and infrastructure deployment models based on business needs
- Apply security concepts in the automation of resource provisioning
- Determine how to implement lifecycle hooks on a deployment
- Apply concepts required to manage systems using AWS configuration management tools and services

## What whitepapers are relevant?

According to the [AWS Whitepapers for DevOps](https://aws.amazon.com/whitepapers/#dev-ops) we should look at the following documents:

- [Infrastructure as Code (39 pages)](https://d1.awsstatic.com/whitepapers/DevOps/infrastructure-as-code.pdf)
- [Introduction to DevOps on AWS (20 pages)](https://d1.awsstatic.com/whitepapers/AWS_DevOps.pdf)
- [Practicing Continuous Integration and Continuous Delivery (32 pages)](https://d1.awsstatic.com/whitepapers/DevOps/practicing-continuous-integration-continuous-delivery-on-AWS.pdf)
- [Jenkins on AWS (48 pages)](https://d1.awsstatic.com/whitepapers/jenkins-on-aws.pdf)
- [Import Windows Server to Amazon EC2 with PowerShell (20 pages)](https://d1.awsstatic.com/whitepapers/DevOps/import-windows-server-to-amazon-ec2.pdf)

## What services and products covered in this domain?

Useful https://aws.amazon.com/devops/#infrastructureascode

- [CloudFormation](https://aws.amazon.com/cloudformation/) - This is a templating language that allows you to codify your infrastructure. This is the "Infrastructure as Code" part of this domain.
- [OpsWorks](https://aws.amazon.com/opsworks/) - This service provides managed versions of Chef and Puppet. These are both industry standard configuration management systems.
- [Elastic Beanstalk](https://aws.amazon.com/elasticbeanstalk/) - is AWS' Platform as a Service (PaaS) offering.
- [AWS Lambda](https://aws.amazon.com/lambda/) - A service to run microservices / Serverless functions / Buzzword bingo
- [AWS ECS](https://aws.amazon.com/ecs/) - Managed container services. IaC (codified)
- [AWS Config](https://aws.amazon.com/config/) - Auditing services of your AWS services.
- [AWS Managed Services](https://aws.amazon.com/managed-services/) - Let's AWS manage your AWS!

## What about other types of documentation?

If you have the time, by all means, read the User Guides, but they are usually a couple of hundred pages. Alternatively, get familiar with the services using the FAQs:

- [CloudFormation](https://aws.amazon.com/cloudformation/faqs/)
- OpsWorks has multiple FAQs for their various offerings [Chef Automate](https://aws.amazon.com/opsworks/chefautomate/faqs/?nc=sn&loc=5), [Puppet Enterprise](https://aws.amazon.com/opsworks/puppetenterprise/faqs/?nc=sn&loc=5) and [Stacks](https://aws.amazon.com/opsworks/stacks/faqs/?nc=sn&loc=5)
- [Elastic Beanstalk](https://aws.amazon.com/elasticbeanstalk/faqs/)
- [AWS Lambda](https://aws.amazon.com/lambda/faqs/)
- [AWS ECS](https://aws.amazon.com/ecs/faqs/)
- [AWS Config](https://aws.amazon.com/config/faq/)
- [AWS Managed Services](https://aws.amazon.com/managed-services/faqs/)

You're all expected to know the APIs

- [CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/Welcome.html)
- OpsWorks has two APIs [Stacks](https://docs.aws.amazon.com/opsworks/latest/APIReference/Welcome.html) and [Configuration Management](https://docs.aws.amazon.com/opsworks-cm/latest/APIReference/Welcome.html)
- [Elastic Beanstalk](https://docs.aws.amazon.com/elasticbeanstalk/latest/api/Welcome.html)
- [AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/API_Reference.html)
- [AWS ECS](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/Welcome.html)

There's no API for AWS Managed Services because this a professional or technical services offering.

Before you panic, you'll start to spot a pattern with the API verbs.

And the CLI commands

- [CloudFormation](https://docs.aws.amazon.com/cli/latest/reference/cloudformation/index.html)
- OpsWorks has two commands [opswork](https://docs.aws.amazon.com/cli/latest/reference/opsworks/index.html) and [opswork-cm](https://docs.aws.amazon.com/cli/latest/reference/opsworks-cm/index.html)
- [Elastic Beanstalk](https://docs.aws.amazon.com/cli/latest/reference/elasticbeanstalk/index.html)
- [AWS Lambda](https://docs.aws.amazon.com/cli/latest/reference/lambda/index.html)
- [AWS ECS](https://docs.aws.amazon.com/cli/latest/reference/ecs/index.html)

There's no CLI for AWS Managed Services because there's no corresponding API.

As with the API, there are patterns to the commands.

## Configu-what? And Infra as Who?

In the previous domain, we learnt that SDLC specifically the continuous delivery pipeline ensures that our code's integrity is being tested repeatedly and in a consistent manner.

Now we'll see how we can achieve something similar to the underlying infrastructure that powers both our build and hosting of our applications.

Configuration Management is a systematic way of handling changes to servers in such as a way that it maintains integrity over time. The key thing to remember is that often we talking about maintaining lots of servers i.e. more than one. To do this manually introduces risks that steps will be missed and inconsistencies in your environments will occur.

By automating this process for server builds and maintenance we reduce this risk. Whilst you could do this yourself through a series of shell scripts and ssh, it's better to use a dedicated tool, some popular choices are Puppet, Chef, and, Salt Stack and Ansible.

If Configuration Management ensures that our servers are patched to the correct version of operating system and contain the correct software to operate, then Infrastructure as Code ensures that provisioning of *drum roll* Infrastructure is done as reproducible steps. Tools you can expect to find in this space are Terraform, Azure Resource Manager and of course CloudFormation.

Both configuration management and infrastructure as code are often expressed as templates or a programming language. This makes both ideal candidates for using version control systems like Git to track changes.

Our next blog post will be about CloudFormation

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
  - [CloudFormation](/2019/aws-devops-pro-certification-cloudformation)
  - [Elastic Beanstalk](/2019/aws-devops-pro-certification-elastic-beanstalk)
  - [OpsWorks](/2019/aws-devops-pro-certification-opsworks)
  - [AWS Lambda](/2019/aws-devops-pro-certification-lambda/)
  - [AWS ECS](/2019/aws-devops-pro-certification-ecs/)
  - [AWS Config](/2019/aws-devops-pro-certification-config-managed-services/)
  - [AWS Managed Services](/2019/aws-devops-pro-certification-config-managed-services/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro/)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
