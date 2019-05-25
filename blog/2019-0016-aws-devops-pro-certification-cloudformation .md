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
- Template consist of
  - `Parameters` - User configuration options
  - `Mapping` - Hashes (array of key/value pairs), allows you to apply logic i.e. choose the correct AMI based on region.
  - `Resources` - The resources we'll use CloudFormation to provision
  - `Output` - Results from the template, usually fed into another template as `Parameters`.
- Stack Policy - IAM style policy statement which governs what can be changed and who can change it
- Programmability
  - Intrinsic functions - helper functions.
  - Custom Resources

### Intrinsic functions

| Function        | Usecases                                      |
|-----------------|-----------------------------------------------|
| Fn::Base64      | UserData of EC2 instances                     |
| Fn::Cidr        | [CIDR][wiki_cidr] address blocks / Networking |
| Fn::FindInMap   | Lookups of values i.e. AMIs by region         |
| Fn::GetAtt      | Cross referencing templates (including self)  |
| Fn::GetAZs      | Networking / Subnets                          |
| Fn::ImportValue | Cross referencing templates (including self)  |
| Fn::Join        | Merges an array into a string                 |
| Fn::Select      | Picking a value from an array                 |
| Fn::Split       | Turns a string into an array                  |
| Fn::Sub         | Substituting one value for another            |
| Fn::Transform   | Calling CloudFormation Macros                 |
| Ref             | Cross referencing templates (including self)  |
| Fn::And         | Conditional operation                         |
| Fn::Or          | Conditional operation                         |
| Fn::Equals      | Conditional function                          |
| Fn::If          | Conditional function                          |
| Fn::Not         | Conditional function                          |

### Resource Attributes

- [CreationPolicy][docs_creationpolicy], requires a signal to be sent by the resource or a timeout occurs

```yaml
CreationPolicy:
  ResourceSignal:
    Count: '3' # 3 instances have been created, so 3 signals are generated
    Timeout: PT15M # [ISO8601 durations format][link_iso8601_durations]: `PT#H#M#S` where `#` is the number of hours, minutes and seconds. Give the instances as long as possible, if the timeout is too short you will trigger rollbacks. `PT15M` is a timeout of 15 minutes
```

To send a signal you would add to the uesr data of each instance:

```bash
#!/bin/bash -xe
yum update -y aws-cfn-bootstrap
/opt/aws/bin/cfn-signal -e $? --stack ${AWS::StackName} --resource AutoScalingGroup --region ${AWS::Region}
```

Only works on Autoscaling groups and EC2 instances.

Common uses scenario: spin up servers, wait until servres are up to attach auto scaling group.

- DeletionPolicy - define what happens to a resource when the stack is deleted. Possible values are:
  - Delete - default
  - Retain
  - Snapshot - only available to EBS, RDS and RedShift. Storage costs for storing the snapshot.
- DependsOn - has no guarentees that the process will have completed successfully
- Metadata
- UpdatePolicy
- UpdateReplacePolicy

Know when to use the [Wait condition][docs_wait_conditions] over a CreationPolicy.

### Pseudo Parameters

### Nested stacks

- A stack contains resources: S3 bucket, EC2 instances and other AWS services
- A stack can also contain another stack as a resource.
- Allow a complex infrastructure to be split up into managable templates.
- Stack Limits: 200/60/60 resources/outputs/parameters can be overcomed using nest stacks
- Allow resources

### Stack updates

Stack Policy is JSON only.

- general rule is to allow everything, but deny specific resources
- The absence of stack policy means all updates are permitted
- once applied it can't be deleted
- once applied all objects are protected and Update:* is denied
- FIXME: Resource impacts (didn't undersand this) 1:44

### Custom Resources (JSON only)

https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/walkthrough-custom-resources-lambda-lookup-amiids.html

In a nutshell: Custom provisioning logic for resources that might not be available in cfn. Also the list of resources avalable in cfn is massive: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html

AWS examples are using Lambda to perform an AMI lookup for a given region and CPU type. Before custom resources, you would to keep a list of mapping created templates that would need to be updated as and when the AMIs changed.

The other is using SNS to trigger other resources and storing the responses as output.

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

[docs_creationpolicy]: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-creationpolicy.html
[docs_wait_conditions]: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-waitcondition.html
[link_iso8601_durations]: https://en.wikipedia.org/wiki/ISO_8601#Durations
[wiki_cidr]: https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing