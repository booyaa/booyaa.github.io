---
permalink: "/2019/aws-devops-pro-certification-cloudformation"
title: "AWS DevOps Pro Certification Blog Post Series: CloudFormation"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-05-27 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification,cloudformation"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier](https://aws.amazon.com/free/). You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try to refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

CloudFormation is a templating language that can be expressed as JSON or YAML. This is one tool that falls under the Infrastructure as Code (IaC) category for this domain.

The core concepts you need to be aware of are:

- Stack - an instantiation of a template
- A template consist of the following core elements
  - `Parameters` - User configuration options
  - `Mapping` - Hashes (array of key/value pairs), allows you to apply logic i.e. choose the correct AMI based on region.
  - `Resources` - The [resources][docs_supported_resources] we'll use CloudFormation to provision. At the time of writing there 89 services that are directly accessible through CloudFormation, later we'll see how to use services that aren't via Custom Resources.
  - `Output` - Results from the template, usually fed into another template as `Parameters`.
  - Other elements to be aware of
    - Format Version - identifies the capabilities of the template
    - Description - self-explanatory
    - Metadata - provides information about the template
    - Conditions - commonly used to define if a resource is created i.e. create this resource if the environment type is production
    - Transform - allows you to execute macros that are either template snippets (`AWS::Include`) or serverless (aka Lambda - `AWS:Serverless`).
- Stack Policies - IAM style policy statement which governs what can be changed and who can change it
- Programmability
  - Intrinsic functions - helper functions.
  - Custom Resources
  - `Transform` section in a template

### Intrinsic functions (helpers)

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
    Count: '3' # 3 instances have been created, so 3 signals will need to be generated before fulfilling the CreationPolicy requirements
    Timeout: PT15M
```

`Timeout` value is [ISO8601 durations format][wiki_iso8601_durations]: `PT#H#M#S` where `#` is the number of hours, minutes and seconds. Give the instances as long as possible, if the timeout is too short you will trigger rollbacks. `PT15M` is a timeout of 15 minutes

To send a signal, you need to install help script called [`cfn-signal`][docs_cfn_signals] on the resources (usually done in the User Data area of EC2 instances).

- DeletionPolicy - define what happens to a resource when the stack is deleted. Possible values are:
  - Delete - default
  - Retain
  - Snapshot - only available to EBS, RDS and RedShift. Storage costs for storing the snapshot.
- DependsOn - has no guarantees that the process will have completed successfully
- UpdatePolicy - defines what happens to resource when the stack is updated.
- UpdateReplacePolicy - use this retain / backup a physical instance of a resource it is replaced during a stack update.

Know when to use the [Wait condition][docs_wait_conditions] over a CreationPolicy.

### Pseudo Parameters

Are predefined parameters that return a valued on the current context i.e. current account or region in use.

| Parameter             | Returns                                                                                             |
|-----------------------|-----------------------------------------------------------------------------------------------------|
| AWS::AccountId        | The account ID                                                                                      |
| AWS::NotificationARNs | A list of notification ARNs for a stack                                                             |
| AWS::NoValue          | Removes the corresponding resource when specified using `Fn::If`                                    |
| AWS::Partition        | The partition a resource is in, only relevant to specialist regions like China and US Government |
| AWS::Region           | The current region                                                                                  |
| AWS::StackId          | The ID of the stack currently created                                                               |
| AWS::StackName        | The Name of the stack currently created                                                             |
| AWS::URLSuffix        | The suffix for a domain typically amazonaws.com, but may vary for specialized regions               |

### Nested stacks

- A stack contains resources: S3 bucket, EC2 instances and other AWS services
- A stack can also contain another stack as a resource.
- Allow a complex infrastructure to be split up into manageable templates.
- Allows you to get around Stack limits (200/60/60 resources/outputs/parameters)

### Stack updates

Stack Policy is JSON only.

- The general rule is to allow everything, but deny specific resources
- The absence of stack policy means all updates are permitted
- Once applied it can't be deleted
- Once applied all objects are protected by default and updates are denied

### Custom Resources

Custom Resources are a way to provision and track resources that are not supported directly through CloudFormation.

The request/response mechanism is either an SNS topic or Lambda backed [ARN][aws_arn].

AWS has a [walk through][docs_custom_resource] that demonstrates how to create a custom resource to perform an AMI lookup (using Lambda) to provide the correct AMI for a given region (in this case the region where we create the stack) and CPU type.

Before custom resources, you would've had to keep a static list of AMIs in the Mappings section of a template.

## Why?

This allows you to define your infrastructure as code, rather than manual steps carried out via various UIs (Console and CLI)

## When?

- Deploying infrastructure in a systematic and repeatable fashion rather than doing it manually.
- Repeat pattern environment i.e. You host WordPress business and you have a template that deploys a web server and database to each new customer.
- If you are using an automated CI/CD environment, but want to expand to a Blue/Green (Red/Black) and create a mirror of your environment to allow for zero downtime.
- Create an environment in any region of the AWS cloud without manual reconfiguration i.e. AMI selection or subnet allocation.
- You want to track change to your environment, by using CloudFormation templates these can be stored in a version control system i.e. Git

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

### Features

- Stacks [Drift/Events/Policy/Resource(s)Drift(s)]
  - Template
  - Imports/Exports
- Change sets
- Stack sets
  - Instance(s)
  - Set
  - SetOperation
    - SetOperationResults

### Verbs (CRUD)

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

### Outliers

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

[docs_creationpolicy]: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-creationpolicy.html
[docs_wait_conditions]: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-waitcondition.html
[docs_cfn_signals]: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-signal.html
[docs_supported_resources]: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html
[doc_custom_resource]: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/walkthrough-custom-resources-lambda-lookup-amiids.html
[wiki_cidr]: https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing
[aws_arn]: https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html
[wiki_iso8601_durations]: https://en.wikipedia.org/wiki/ISO_8601#Durations

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro/)
  - CloudFormation
  - [Elastic Beanstalk](/2019/aws-devops-pro-certification-elastic-beanstalk)
  - [OpsWorks](/2019/aws-devops-pro-certification-opsworks)
  - [AWS Lambda](/2019/aws-devops-pro-certification-lambda/)
  - [AWS ECS](/2019/aws-devops-pro-certification-ecs/)
  - [AWS Config](/2019/aws-devops-pro-certification-config-managed-services/)
  - [AWS Managed Services](/2019/aws-devops-pro-certification-config-managed-services/)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
