---
permalink: "/2019/aws-devops-pro-certification-elasticbeanstalk"
title: "AWS DevOps Pro Certification Blog Post Series: Elastic Beanstalk"
categories:
  - "aws,study,certification,elasticbeanstalk"
layout: post.liquid
published_date: "2019-05-30 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification,elasticbeanstalk"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier](https://aws.amazon.com/free/). You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try to refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

Elastic Beanstalk...

- is a Platform as a Service (just like Heroku, Netlify), you deploy your code and it provisions the servers you need to get your app running.
- is powered by CloudFormation behind the scene.
- (Elastic Beanstalk) Extensions are the equivalent of User Data field for EC2 instances, in that you can add some tasks that need to run during the provisioning of servers i.e. enable automatic updates on windows.
- comes with a cli (eb), this is primarily aimed at developer giving them a similar PaaS experience to other providers like Heroku i.e. link your version control system (Git, etc) and Elastic Beanstalk will do the rest. There's a lot of simplification in the eb cli versus the aws cli e.g. `eb create my-env` (which creates an environment) would require three aws cli Elastic Beanstalk commands: `check-dns-availability`, `create-application-version` and `create-environment`.

Additional resources:

- dev.to tag for [Elastic Beanstalk][devto_elasticbeanstalk]
- [Elastic Beanstalk FAQs](https://aws.amazon.com/elasticbeanstalk/faqs/)
- [Elastic Beanstalk User Guide](https://aws.amazon.com/elasticbeanstalk/)
- [Elastic Beanstalk API](https://docs.aws.amazon.com/elasticbeanstalk/latest/api/Welcome.html)
- [Elastic Beanstalk CLI](https://docs.aws.amazon.com/cli/latest/reference/elasticbeanstalk/index.html)

## Why?

Of all the Orchestration tools provided by AWS, this is probably the easiest to use. Just like Heroku which pioneered this method of simplifying the application deployments, this is aimed at Developers who don't want to get involved in the operational side of provisioning infrastructure.

Recall the level of complexity around CloudFormation, this isn't for everyone.

## When?

- Time poor or not willing to learn a more complex, but ultimately highly configurable Orchestration tool like CloudFormation.
- Don't have a sysadmin handy
- Want to release your application quickly and not worry about the details around the infrastructure.

## How?

We're going to work through one of the [example apps][docs_apps] provided by AWS, download the Go example (`go-v1.zip`). The environment setup commands were cribbed from [user guide][docs_cli] too.

Important: You'll need an S3 bucket to store the solution.

```bash
export APP_NAME=hello-eb
export APP_BUCKET=your-bucket

# copy the zip file to your bucket
aws s3 cp path/to/downloaded/go-v1.zip s3://$APP_BUCKET/

# create the application
aws elasticbeanstalk create-application --application-name $APP_NAME
{
    "Application": {
        "ApplicationArn": "arn:aws:elasticbeanstalk:eu-west-3:xxx:application/hello-eb",
        "ApplicationName": "hello-eb",
        "DateCreated": "2019-05-29T16:03:18.885Z",
        "DateUpdated": "2019-05-29T16:03:18.885Z",
        "ConfigurationTemplates": [],
        "ResourceLifecycleConfig": {
            "VersionLifecycleConfig": {
                "MaxCountRule": {
                    "Enabled": false,
                    "MaxCount": 200,
                    "DeleteSourceFromS3": false
                },
                "MaxAgeRule": {
                    "Enabled": false,
                    "MaxAgeInDays": 180,
                    "DeleteSourceFromS3": false
                }
            }
        }
    }
}

# create the application version
aws elasticbeanstalk create-application-version \
  --application-name $APP_NAME \
  --version-label v1 \
  --source-bundle S3Bucket="$APP_BUCKET",S3Key="go-v1.zip"
{
    "ApplicationVersion": {
        "ApplicationVersionArn": "arn:aws:elasticbeanstalk:eu-west-3:x:applicationversion/hello-eb/v1",
        "ApplicationName": "hello-eb",
        "VersionLabel": "v1",
        "SourceBundle": {
            "S3Bucket": "your_bucket",
            "S3Key": "go-v1.zip"
        },
        "DateCreated": "2019-05-29T16:07:20.796Z",
        "DateUpdated": "2019-05-29T16:07:20.796Z",
        "Status": "UNPROCESSED"
    }
}

# create a configuration template, this tells Elastic Beanstalk which
# specialised server image to use
aws elasticbeanstalk create-configuration-template \
  --application-name $APP_NAME \
  --template-name v1 \
  --solution-stack-name "64bit Amazon Linux 2018.03 v2.11.1 running Go 1.12.4"  
{
    "SolutionStackName": "64bit Amazon Linux 2018.03 v2.11.1 running Go 1.12.4",
    "PlatformArn": "arn:aws:elasticbeanstalk:eu-west-3::platform/Go 1 running on 64bit Amazon Linux/2.11.1",
    "ApplicationName": "hello-eb",
    "TemplateName": "v1",
    "DateCreated": "2019-05-29T16:09:58Z",
    "DateUpdated": "2019-05-29T16:09:58Z"
}

# to get a list of the prebuilt platforms you can use
aws elasticbeanstalk list-available-solution-stacks | jq -r '.SolutionStacks[]'
64bit Amazon Linux 2018.03 v2.8.3 running Python 3.6
64bit Amazon Linux 2018.03 v2.8.3 running Python 3.4
64bit Amazon Linux 2018.03 v2.8.3 running Python
64bit Amazon Linux 2018.03 v2.8.3 running Python 2.7
*snip*

# create the environment, well need to tell Elastic Beanstalk what IAM role to use to create ec2 instances
cat options.txt
[
    {
        "Namespace": "aws:autoscaling:launchconfiguration",
        "OptionName": "IamInstanceProfile",
        "Value": "aws-elasticbeanstalk-ec2-role"
    }
]

# create the environment
aws elasticbeanstalk create-environment \
  --cname-prefix $APP_NAME \
  --application-name $APP_NAME \
  --template-name v1 --version-label v1 \
  --environment-name $APP_NAME-env \
  --option-settings file://options.txt
{
    "EnvironmentName": "hello-eb-env",
    "EnvironmentId": "e-g8pwbwxc5j",
    "ApplicationName": "hello-eb",
    "VersionLabel": "v1",
    "SolutionStackName": "64bit Amazon Linux 2018.03 v2.11.1 running Go 1.12.4",
    "PlatformArn": "arn:aws:elasticbeanstalk:eu-west-3::platform/Go 1 running on 64bit Amazon Linux/2.11.1",
    "CNAME": "hello-eb.eu-west-3.elasticbeanstalk.com",
    "DateCreated": "2019-05-29T16:11:32.355Z",
    "DateUpdated": "2019-05-29T16:11:32.355Z",
    "Status": "Launching",
    "Health": "Grey",
    "Tier": {
        "Name": "WebServer",
        "Type": "Standard",
        "Version": "1.0"
    },
    "EnvironmentArn": "arn:aws:elasticbeanstalk:eu-west-3:xxx:environment/hello-eb/hello-eb-env"
}

# examine the status of the new environment
aws elasticbeanstalk describe-environments --environment-names $APP_NAME-env
{
    "Environments": [
        {
            "EnvironmentName": "hello-eb-env",
            "EnvironmentId": "e-g8pwbwxc5j",
            "ApplicationName": "hello-eb",
            "VersionLabel": "v1",
            "SolutionStackName": "64bit Amazon Linux 2018.03 v2.11.1 running Go 1.12.4",
            "PlatformArn": "arn:aws:elasticbeanstalk:eu-west-3::platform/Go 1 running on 64bit Amazon Linux/2.11.1",
            "EndpointURL": "awseb-e-g-AWSEBLoa-1S8LUETQTXR9H-746312279.eu-west-3.elb.amazonaws.com",
            "CNAME": "hello-eb.eu-west-3.elasticbeanstalk.com",
            "DateCreated": "2019-05-29T16:11:32.324Z",
            "DateUpdated": "2019-05-29T16:14:11.172Z",
            "Status": "Ready",
            "AbortableOperationInProgress": false,
            "Health": "Green",
            "Tier": {
                "Name": "WebServer",
                "Type": "Standard",
                "Version": "1.0"
            },
            "EnvironmentLinks": [],
            "EnvironmentArn": "arn:aws:elasticbeanstalk:eu-west-3:xxx:environment/hello-eb/hello-eb-env"
        }
    ]
}

# Once the status is Ready and health is Green, you can open the fully qualified domain name in `CNAME`

curl -sv http://$APP_NAME.eu-west-3.elasticbeanstalk.com/ | head
*snip*
*< HTTP/1.1 200 OK
< Accept-Ranges: bytes
< Content-Type: text/html; charset=utf-8
< Date: Wed, 29 May 2019 16:15:33 GMT
< Last-Modified: Thu, 17 Sep 2015 17:53:06 GMT
< Server: nginx/1.14.1
< Content-Length: 3049
< Connection: keep-alive
<
{ [1208 bytes data]
* Connection #0 to host hello-eb.eu-west-3.elasticbeanstalk.com left intact
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <!--
    Copyright 2015 Amazon.com, Inc. or its affiliates. All Rights Reserved.

    Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

        http://aws.Amazon/apache2.0/

# Let's tear down

aws elasticbeanstalk terminate-environment \
    --environment-name $APP_NAME-env

aws elasticbeanstalk delete-configuration-template \
    --application-name $APP_NAME --template-name v1

aws elasticbeanstalk delete-application \
    --application-name $APP_NAME
```

N.B. I've noticed there's some delay in deleting the application. You may need to check on the AWS console to confirm all the resources have been deleted.

## API and CLI features and verbs

### Features

- Application(s)
  - Version
  - Resource Lifecycle
- Environment
  - Configuration
- Platform Version
- Storage

### Verbs (CRUD)

- Applications
  - Create (Application [Version])
  - Describe (Applications)
  - Update (Application [Resource Lifecycle])
  - Delete (Application [Version])

- Environment
- Platform Version
- Storage

### Outliers

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
  
[docs_apps]: https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/tutorials.html
[docs_cli]: https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/environments-create-awscli.html

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro/)
  - [CloudFormation](/2019/aws-devops-pro-certification-cloudformation)
  - Elastic Beanstalk
  - [OpsWorks](/2019/aws-devops-pro-certification-opsworks)
  - [AWS Lambda](/2019/aws-devops-pro-certification-lambda/)
  - [AWS ECS](/2019/aws-devops-pro-certification-ecs/)
  - [AWS Config](/2019/aws-devops-pro-certification-config-managed-services/)
  - [AWS Managed Services](/2019/aws-devops-pro-certification-config-managed-services/)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
