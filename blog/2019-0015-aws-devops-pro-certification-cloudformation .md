---
permalink: "/2019/aws-devops-pro-certification-cloudformation"
title: "AWS DevOps Pro Certification Blog Post Series: CloudFormation"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-05-12 13:37:00 +0000"
is_draft: true
data:
  tags: "aws,study,certification,cloudformation"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier](https://aws.amazon.com/free/). You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

CloudFormation is:

- Stack - ???
- Template
 - Parameters
 - Mapping - Hashes (array of key/value pairs)
 - Resources
 - Output - Results from the template
- Stack Policy - IAM style policy statement which governs what can be changed and who can change it

- Intrinsic functions

## Why?

TBC

## When?

- Deploy infra rather than doing it manually
- Repeatedly pattern environment - wordpress blog and database for running your web hosting business
- To run an Automated testing for CI/CD. Create the environment from scratch.
- Define an environment to any region in AWS cloud without reconfiguration. Keeping things generic
- Can managed template using version control system i.e. Git (this is an attribute of IaC)
- Templates should be designed in mind for 1, 100 or 1000 applicatios in one or more regions. Overhead. But then again so are unit tess rights?

## How?

Here's an example CloudFormation template

`hello-bucket.yaml`

```yaml
Resources:
  HelloBucket:
    Type: AWS::S3::Bucket
```

`HelloBucket` is our resource, and the type we've gone for is an S3 bucket.

```bash
aws cloudformation create-stack \
  --stack-name hellostack \
  --template-body \
  file:///path/to/hello-bucket.yaml 
{
    "StackId": "arn:aws:cloudformation:eu-west-3:12345:stack/hellostack/4a3b0220-7552-11e9-acf0-0a230f532f04"
}  
```

## API and CLI features and verbs

**Features**

- TBC

**Verbs (CRUD) **

- create
- batch-get/get/list/describe
- update/put
- delete

**Outliers**

- TBC

**AWS DevOps Pro Certification Blog Post Series**

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SLDC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: Configuration Management and Infrastructure as Code
  - CloudFormation
  - OpsWorks
  - Elastic Beanstalk
  - AWS Lambda
  - AWS ECS
  - AWS Config
  - AWS Systems Manager
  - AWS Managed Services
- Domain 3: Monitoring and Logging
- Domain 4: Policies and Standards Automation
- Domain 5: Incident and Event Response
- Domain 6: High Availability, Fault Tolerance, and Disaster Recovery
