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

### Intrinsic functions

N.B. Whilst we're only using YAML as our templating language, we will be using the full function name invocation rather than the short form i.e. `!FunctionName valueToEncode`. This is because it's close enough to it's JSON equivalent and should make it easier for you to convert the templates (used in this post) if you prefer JSON.

#### Fn::Base64

Encodes a string into Base64, a common use is to pass a value to the `UserData` of an Amazon EC2 instance safely.

```yaml
Fn::Base64: valueToEncode
```

You can use any intrinsic function within `Fn::Base64` provided it returns a string.

#### Fn::Cidr

Returns an array of [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) address block.

Declaration:

```yaml
Fn::Cidr:
  - ipBlock
  - count
  - cidrBits
```

Parameters:

- ipBlock - CIDR address block to be split into smaller blocks
- count - number of CIDRs to generate between 1 and 256 items
- cidrBit - The number of [subnet bits](http://subnet-calculator.org/cidr.php) for a CIDR.

You can use `Fn::Select` and `Ref` inside the `Fn::Cidr`.

#### Fn::FindInMap

Returns the value that is assigned to the `SecondLevelKey`

```yaml
Fn::FindInMap: [ MapName, TopLevelKey, SecondLevelKey ]
```

- MapName - The logical name of the mapping as defined in the Mappings section of the template
- TopLevelKey - The key name that returns a list of key-value pairs
- SecondLevelKey -  The key name (originating from the list of key-value pairs returned by the TopLevelKey whose value we which to return.

You can use `Fn::FindInMap` and `Ref` inside the `Fn::FindInMap`. Also you can't nest instances of `Fn::FindInMap` with in another `Fn::FindInMap` if using the short form of the function i.e. `!FindInMap`

#### Fn::GetAtt

Returns the value from a Resource attribute in the template

```yaml
Fn::GetAtt: [ logicalNameOfResource, attributeName]
```

You cannot use functions for the `logicalNameOfResource` parameter, you can use the `Ref` function for the `attributeName` parameter.

#### Fn:GetAZs

Returns a list of availability zones for a given region.

```yaml
Fn::GetAZs: region
```

- region - You can use a string to specify the region i.e. `us-east-1`, alternatively you can use the `AWS::Region`  pseudo parameter which will use the region where the stack is being created. Providing an empty string is the will also use this pseudo parameter.

You can use the `Ref` function in the `Fn::GetAzs` function.

#### Fn::ImportValue

Returns the value from an output exported by another stack. Typically used to create cross-stack references (FIXME: to be defined).

```yaml
Fn::ImportValue: sharedValueToImport
```

The following functions can be used in `Fn::ImportValue` function, the values of these functions can't depend on a resource (FIX: Explain)

- `Fn::Base64`
- `Fn::FindInMap`
- `Fn::If`
- `Fn::Join`
- `Fn::Select`
- `Fn::Sub`
- `Ref`

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

The CloudFormation template: `hello-bucket.yaml`.

N.B. To keep things terse, I've decided to only use YAML as the template format. CloudFormation can use JSON (in fact this was the original format, so you will still find a lot of examples in this format).

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