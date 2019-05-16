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

- Stack - an instantiation of a template
- Template
  - `Parameters` - User configuration options
  - `Mapping` - Hashes (array of key/value pairs), allows you to apply logic i.e. choose the correct AMI based on region.
  - `Resources` - The resources we'll use CloudFormation to provision
  - `Output` - Results from the template, usually fed into another template as `Parameters`.
- Stack Policy - IAM style policy statement which governs what can be changed and who can change it

- Intrinsic functions - enables programmability by providing helper functions.

## Why?

This allows you to define your infrastructure as code, rather than manual steps carried out via various UIs (Console and CLI)

## When?

- Deploy infra rather than doing it manually
- Repeatedly pattern environment - wordpress blog and database for running your web hosting business
- To run an Automated testing for CI/CD. Create the environment from scratch.
- Define an environment to any region in AWS cloud without reconfiguration. Keeping things generic
- Can managed template using version control system i.e. Git (this is an attribute of IaC)
- Templates should be designed in mind for 1, 100 or 1000 applicatios in one or more regions. Overhead. But then again so are unit tess rights?

## How?

Here's a very basic example of CloudFormation, we'll use it to create an S3 bucket.

The CloudFormation template: `hello-bucket.yaml`

```yaml
Resources:
  HelloBucket:
    Type: AWS::S3::Bucket
```

`HelloBucket` is the logical name of our `resource`, and the type we've gone for is an S3 bucket.

Let's use the CLI to create the stack based on this template.

```bash
aws cloudformation create-stack \
  --stack-name hellostack \
  --template-body \
  file:///path/to/hello-bucket.yaml 
{
    "StackId": "arn:aws:cloudformation:eu-west-3:xxx:stack/hellostack/4a3b0220-7552-11e9-acf0-0a230f532f04"
}  

aws cloudformation describe-stacks
{
    "Stacks": [
        {
            "StackId": "arn:aws:cloudformation:eu-west-3:xxx:stack/hellostack/4a3b0220-7552-11e9-acf0-0a230f532f04",
            "StackName": "hellostack",
            "CreationTime": "2019-05-13T07:39:50.524Z",
            "RollbackConfiguration": {},
            "StackStatus": "CREATE_COMPLETE",
            "DisableRollback": false,
            "NotificationARNs": [],
            "Tags": [],
            "DriftInformation": {
                "StackDriftStatus": "NOT_CHECKED"
            }
        }
    ]
}
```

Let's check on the status of stack creation.

```bash
 aws cloudformation describe-stack-resources --stack-name hellostack
{
    "StackResources": [
        {
            "StackName": "hellostack",
            "StackId": "arn:aws:cloudformation:eu-west-3:xxx:stack/hellostack/4a3b0220-7552-11e9-acf0-0a230f532f04",
            "LogicalResourceId": "HelloBucket",
            "PhysicalResourceId": "hellostack-hellobucket-1ux8azkoq7t0t",
            "ResourceType": "AWS::S3::Bucket",
            "Timestamp": "2019-05-13T07:40:15.289Z",
            "ResourceStatus": "CREATE_COMPLETE",
            "DriftInformation": {
                "StackResourceDriftStatus": "NOT_CHECKED"
            }
        }
    ]
}
```

Useful fields:

- `StackName` - this is the logic name of Stack (which we defined when using the `create-stack` sub command in the CLI)
- `PhysicalResourceId` - this is the bucket name, note the default naming convention: `<Stack Name>-<Logical Name of Resource in the Template>-<Random Hex String>`
- `ResourceStatus` - This tells us if the resource creation was successful.

We can verify the name of the bucket by using the `s3api` command:

```bash
aws s3api list-buckets | jq '.Buckets[] | select(.Name | contains("hellostack"))'
{
  "Name": "hellostack-hellobucket-1ux8azkoq7t0t",
  "CreationDate": "2019-05-13T07:39:55.000Z"
}
```

Finally let's tear down, and verify the bucket has been deleted.

```bash
aws cloudformation delete-stack --stack-name hellostack
# no output

aws s3api list-buckets | jq '.Buckets[] | select(.Name | contains("hellostack"))'
# no output
```

## API and CLI features and verbs

**Features**

- Stacks [Drift/Events/Policy/Resource(s)Drift(s)]
  - Template
  - Imports/Exports
- Change sets
- Stack sets
  - Instance(s)
  - Set
  - SetOperation
    - SetOperationResults

**Verbs (CRUD) **

- Stacks
  - Create
  - List/Describe (stacks)
  - Set/Update/Put
  - Delete

- Change sets
  - Create
  - List/Describe
  - Set/Update/Put
  - Delete

- Stack sets
  - Create
  - List/Describe
  - Set/Update/Put
  - Delete

**Outliers**

- Stacks
  - CancelUpdateStack
  - ContinueUpdateRollback
  - DescribeStackDriftDetectionStatus
  - EstimateTemplateCost
  - GetTemplateSummary
  - UpdateTerminationProtection
  - ValidateTemplate

- Change sets
  - ExecuteChangeSet

- Stack sets
  - StopStackSetOperation

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
