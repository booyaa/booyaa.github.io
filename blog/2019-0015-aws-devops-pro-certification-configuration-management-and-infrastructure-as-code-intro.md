---
permalink: "/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro"
title: "AWS DevOps Pro Certification Blog Post Series: Configuration Management and Infrastructure as Code introduction"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-04-15 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_


https://aws.amazon.com/architecture/icons/
https://duo.com/blog/introducing-cloudmapper-an-aws-visualization-tool

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
- [AWS Lambda](https://aws.amazon.com/lambda/) - A service to run microservices / Serverless functions ???
- [AWS ECS](https://aws.amazon.com/ecs/) - Managed container services. IaC (codified)
- [AWS Config](https://aws.amazon.com/config/) - Auditing services of your AWS services.
- [AWS Systems Manager](https://aws.amazon.com/systems-manager/) - Allows you to manage your system environment using an agent, bit like chef and puppet. CM.
https://www.youtube.com/watch?v=BmpxZsk9N48
- [AWS Managed Services](https://aws.amazon.com/managed-services/) - Let's AWS managed your AWS!

## What about other types of documentation?

If you have the time, by all means, read the User Guides, but they are usually a couple of hundred pages. Alternatively, get familiar with the services using the FAQs:

- [CloudFormation](https://aws.amazon.com/cloudformation/faqs/)
- OpsWorks has multiple FAQs for their various offerings [Chef Automate](https://aws.amazon.com/opsworks/chefautomate/faqs/?nc=sn&loc=5), [Puppet Enterprise](https://aws.amazon.com/opsworks/puppetenterprise/faqs/?nc=sn&loc=5) and [Stacks](https://aws.amazon.com/opsworks/stacks/faqs/?nc=sn&loc=5)
- [Elastic Beanstalk](https://aws.amazon.com/elasticbeanstalk/faqs/)
- [AWS Lambda](https://aws.amazon.com/lambda/faqs/)
- [AWS ECS](https://aws.amazon.com/ecs/faqs/)
- [AWS Config](https://aws.amazon.com/config/faq/)
- [AWS Systems Manager](https://aws.amazon.com/systems-manager/faq/)
- [AWS Managed Services](https://aws.amazon.com/managed-services/faqs/)

You're all expected to know the APIs

- [CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/Welcome.html)
- OpsWorks has two APIs [Stacks](https://docs.aws.amazon.com/opsworks/latest/APIReference/Welcome.html) and [Configuration Management](https://docs.aws.amazon.com/opsworks-cm/latest/APIReference/Welcome.html)
- [Elastic Beanstalk](https://docs.aws.amazon.com/elasticbeanstalk/latest/api/Welcome.html)
- [AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/API_Reference.html)
- [AWS ECS](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/Welcome.html)

- [AWS Config](https://aws.amazon.com/config/faq/)
- [AWS Systems Manager](https://aws.amazon.com/systems-manager/faq/)
- [AWS Managed Services](https://aws.amazon.com/managed-services/faqs/)

Before you panic, you'll start to spot a pattern with the API verbs.

And the CLI commands

- [CloudFormation](https://docs.aws.amazon.com/cli/latest/reference/cloudformation/index.html)
- OpsWorks has two commands [opswork](https://docs.aws.amazon.com/cli/latest/reference/opsworks/index.html) and [opswork-cm](https://docs.aws.amazon.com/cli/latest/reference/opsworks-cm/index.html
)
- [Elastic Beanstalk](https://docs.aws.amazon.com/cli/latest/reference/elasticbeanstalk/index.html)
- [AWS Lambda](https://docs.aws.amazon.com/cli/latest/reference/lambda/index.html)
- [AWS ECS](https://docs.aws.amazon.com/cli/latest/reference/ecs/index.html)

- [AWS Config](https://aws.amazon.com/config/faq/)
- [AWS Systems Manager](https://aws.amazon.com/systems-manager/faq/)
- [AWS Managed Services](https://aws.amazon.com/managed-services/faqs/)

As with the API, there are patterns to the commands.

## CI, see what?

If you're not familiar with SDLC automation, this involves the automation of the following:

- build process that compiles the code, or optimises the content for a static site, docker image
- running tests to verify the build was successful
- deploying the new build to a target e.g. application servers, app store, web server, etc. This can also involve publishing the artefacts from the build process to GitHub Releases page of your repository.

Usually, the trigger to initiate these steps is a commit or merge to the `master` branch of your code.

The build and testing stages are often provided by a Continuous Integration service like Travis CI, Circle CI or Jenkins.

The deployment stages are handled by you guessed it Continuous Delivery service like Octopus, Azure DevOps (release pipelines) and often services that provide CI will also handle deployment.

Next, we're going to look at the Code Commit in greater detail.

**AWS DevOps Pro Certification Blog Post Series**

- [Intro](/2019/aws-devops-pro-certification-intro/)
- SLDC automation introduction
- [Code Commit](/2019/aws-devops-pro-certification-code-commit/)
- [Code Build](/2019/blog/aws-devops-pro-certification-code-build/)
- [Code Deployment](/2019/aws-devops-pro-certification-code-deploy/)