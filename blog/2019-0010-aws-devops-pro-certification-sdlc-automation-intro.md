---
permalink: "/2019/aws-devops-pro-certification-sdlc-intro"
title: "AWS DevOps Pro Certification Blog Post Series: SDLC automation introduction"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-03-25 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## What does the exam guide say?

To pass this domain, you'll need to know the following:

- Apply concepts required to automate a CI/CD pipeline
- Determine source control strategies and how to implement them
- Apply concepts required to automate and integrate testing
- Apply the concepts required to build and manage artefacts securely
- Determine deployment/delivery strategies (e.g., A/B, Blue/green, Canary, Red/black) and how to
implement them using AWS Services

## What whitepapers are relevant?

According to the [AWS Whitepapers for DevOps](https://aws.amazon.com/whitepapers/#dev-ops) we should look at the following documents:

- [Introduction to DevOps on AWS (20 pages)](https://d1.awsstatic.com/whitepapers/AWS_DevOps.pdf)
- [Development and Test on AWS (17 pages)](https://d1.awsstatic.com/whitepapers/aws-development-test-environments.pdf)
- [Practicing Continuous Integration and Continuous Delivery (32 pages)](https://d1.awsstatic.com/whitepapers/DevOps/practicing-continuous-integration-continuous-delivery-on-AWS.pdf)
- [Blue/Green Deployments on AWS (35 pages)](https://d1.awsstatic.com/whitepapers/AWS_Blue_Green_Deployments.pdf)
- [Jenkins on AWS (48 pages)](https://d1.awsstatic.com/whitepapers/jenkins-on-aws.pdf)

## What services and products covered in this domain?

- [Code Commit](https://docs.aws.amazon.com/codecommit/index.html?id=docs_gateway#lang/en_us) - This service provides Source Control Management (SCM). This is where you store your source code and keep a track of the changes made (commits). Examples of similar services: GitHub, Bitbucket, GitLab, and Azure DevOps. You only have one choice of Version Control Service (VCS) and that is Git.
- [Code Build](https://docs.aws.amazon.com/codebuild/index.html?id=docs_gateway#lang/en_us) - This service builds code and produces artefacts. This is often part of a Continuous Integration (CI) pipeline, so this is where tests can be run to ensure the code is stable. Examples of similar services: Travis CI, Circle CI, Azure DevOps and Jenkins.
- [Code Deploy](https://docs.aws.amazon.com/codedeploy/index.html?id=docs_gateway#lang/en_us) -  This service automates the deployment of your applications or publishes files to a website. This is often part of a Continuous Deployment (CD) pipeline. Examples of similar services: Travis CI, Circle CI, Azure DevOps and Octopus.
- [Code Pipeline](https://docs.aws.amazon.com/codepipeline/index.html?id=docs_gateway#lang/en_us) - This service provide a workflow, allow for more complex release step. This is often part of a Continuous Deployment (CD) pipeline. Examples of similar services: Circle CI, Azure DevOps and Jenkins. 

Shrewd readers will have spotted that these are part of Developer Tools suite in the [AWS Documentation](https://docs.aws.amazon.com/index.html?nc2=h_ql_doc#lang/en_us) page. So why have I excluded CodeStar, X-Ray and Tools & SDKs? They're not critical to SDLC automation.

## What about other types of documentation?

If you have the time, by all means, read the User Guides, but they are usually a couple of hundred pages. Alternatively, get familiar with the services using the FAQs:

- [Code Commit](https://aws.amazon.com/codecommit/faqs/)
- [Code Build](https://aws.amazon.com/codebuild/faqs/)
- [Code Deploy](https://aws.amazon.com/codedeploy/faqs/)
- [Code Pipeline](https://aws.amazon.com/codepipeline/faqs/)

You're all expected to know the APIs

- [Code Commit](https://docs.aws.amazon.com/codecommit/latest/APIReference/index.html)
- [Code Build](https://docs.aws.amazon.com/codebuild/latest/APIReference/Welcome.html)
- [Code Deploy](https://docs.aws.amazon.com/codedeploy/latest/APIReference/index.html)
- [Code Pipeline](https://docs.aws.amazon.com/codepipeline/latest/APIReference/index.html)

Before you panic, you'll start to spot a pattern with the API verbs.

And the CLI commands

- [Code Commit](https://docs.aws.amazon.com/cli/latest/reference/codecommit/index.html)
- [Code Build](https://docs.aws.amazon.com/cli/latest/reference/codebuild/index.html)
- [Code Deploy](https://docs.aws.amazon.com/cli/latest/reference/deploy/index.html)
- [Code Pipeline](https://docs.aws.amazon.com/cli/latest/reference/codepipeline/index.html)

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

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: SDLC automation
  - [Code Commit](/2019/aws-devops-pro-certification-code-commit/)
  - [Code Build](/2019/blog/aws-devops-pro-certification-code-build/)
  - [Code Deploy](/2019/aws-devops-pro-certification-code-deploy/)
  - [Code Pipeline](/2019/aws-devops-pro-certification-code-pipeline)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
