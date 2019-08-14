---
permalink: "/2019/aws-devops-pro-certification-code-pipeline"
title: "AWS DevOps Pro Certification Blog Post Series: Code Pipeline"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-04-10 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier](https://aws.amazon.com/free/). You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try to refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

CodePipeline is continuous delivery service that can be used to orchestrate the various services required to release software automatically: CodeCommit, CodeBuild and CodeDeploy.

## Why?

Whilst it is possible to trigger CodeComit, CodeBuild and CodeDeploy manually, CodePipeline will do this for you automatically (via CloudWatch Events)

## When?

```text
SDLC automation
~~~~~~~~~~~~~~~~

CodePipeline
+---------------------------------------+
|                                       |
| CodeCommit -> CodeBuild -> CodeDeploy |
|                                       |
+---------------------------------------+
```

## How?

TODO: going to revisit the previous blog posts for CodeCommit, CodeBuild and CodeDeploy to have a lab that spans these posts.

## API and CLI features and verbs

### Features

- Pipelines
- Custom Action Type
- Webhooks

### Verbs (CRUD)

- create/register
- get/list
- update/put
- delete

### Outliers

- acknowledge-job
- acknowledge-third-party-job
- disable-stage-transition
- enable-stage-transition
- get-job-details
- get-pipeline-execution
- get-pipeline-state
- get-third-party-job-details
- list-action-executions
- list-action-types
- list-pipeline-executions
- poll-for-jobs
- poll-for-third-party-jobs
- put-action-revision
- put-approval-result
- put-job-failure-result
- put-job-success-result
- put-third-party-job-failure-result
- put-third-party-job-success-result
- retry-stage-execution
- start-pipeline-execution

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
  - [Code Commit](/2019/aws-devops-pro-certification-code-commit/)
  - [Code Build](/2019/aws-devops-pro-certification-code-build/)
  - [Code Deploy](/2019/aws-devops-pro-certification-code-deploy/)
  - Code Pipeline
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
