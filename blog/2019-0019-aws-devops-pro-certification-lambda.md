---
permalink: "/2019/aws-devops-pro-certification-aws-lambda"
title: "AWS DevOps Pro Certification Blog Post Series: AWS Lambda"
categories:
  - "aws,study,certification,lambda"
layout: post.liquid
published_date: "2019-06-01 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification,lambda"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier][aws_free_tier]. You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try to refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

AWS Lambda is ...

- a Serverless function framework
- highly integrated with AWS services
- a good fit for DevOps tasks

Additional resources:

- [AWS Lambda User Guide][docs_ug]
- [AWS Lambda FAQ][docs_faq]
- [AWS Lambda API][docs_api]
- [AWS Lambda CLI][docs_cli]

## Why?

Here are some ideas that a DevOps / Infra team might use cases for AWS Lambda. None of this is new or groundbreaking innovations. The only difference is that when trying to implement these in AWS Lambda we no longer need to factor new servers, billing is per second and Lambda was built to talk with other AWS services in mind.

- Automate backups/cycle through EBS snapshots
- Generating reports - use it to audit resources on AWS (if you don't want to shell out on AWS Config)
- Perform S3 ops i.e. moving code build artefacts to a location on a given S3 bucket
- Batch log processing - extract, transform and load (ETL) from various resources and consolidate into a central data warehouse
- Scheduled Tasks - perform any of the above use cases at a given schedule, just like cron jobs
- ChatOps - running Slack chatbots to manage and report against your infrastructure

Use cases inspired by the epagon blog post: [Why DevOps Engineers Love AWS][link_devops_loves_aws_lambda]

## When?

- You need to perform a DevOps task, but don't want to go through the trouble of provisioning an application server to host it.
- You're trying to break up a monolithic management server that's responsible for scheduling and running DevOps tasks.

## How?

We're going to use a simple example where the DevOps engineer wants to log all files being uploaded for a given S3 bucket. A lot of the hard work around this tutorial was done via Sunil Dalal's blog post,  "[Using Lambda as S3 events processor][link_sunil_dalal]". Thanks, Sunil for sharing!

### Pre-requisites

- Create a Lambda execution role to grant lambda access to services and resources. This can be done through the console using this [guide][docs_ug_execution_role]. Copy the ARN you'll need it when we upload the function. The role should have the following permissions applied:
  - allow the role to create CloudWatch log entries.
  - allow the role S3 read-only access
- You've got an S3 bucket (might be a good idea to create one just for this walkthrough)
- Have the following tools installed:
  - [jq][link_jq] for wrangling JSON data out of AWS CLI
  - [awslogs][link_awslogs] if you want to view CloudWatch log entries in the terminal)
- The AWS CLI default profile has been configured
  - to output JSON
  - has a fixed region

### Create files

Copy the following snippet and call it `index.js`

```javascript
exports.handler = async (event) => {
    var srcBucket = event.Records[0].s3.bucket.name;
    var srcKey = decodeURIComponent(event.Records[0].s3.object.key);

    console.log("bucket:", srcBucket, " file: ", srcKey);
};

```

Copy the following snippet and call it `payload-test.json`

```json
{
  "Records":[  
    {  
      "eventVersion":"2.0",
      "eventSource":"aws:s3",
      "awsRegion":"us-west-2",
      "eventTime":"1970-01-01T00:00:00.000Z",
      "eventName":"ObjectCreated:Put",
      "userIdentity":{  
        "principalId":"AIDAJDPLRKLG7UEXAMPLE"
      },
      "requestParameters":{  
        "sourceIPAddress":"127.0.0.1"
      },
      "responseElements":{  
        "x-amz-request-id":"C3D13FE58DE4C810",
        "x-amz-id-2":"FMyUVURIY8/IgAtTv8xRjskZQpcIZ9KG4V5Wp6S7S/JRWeUWerMUE5JgHvANOjpD"
      },
      "s3":{  
        "s3SchemaVersion":"1.0",
        "configurationId":"testConfigRule",
        "bucket":{  
          "name":"sourcebucket",
          "ownerIdentity":{  
            "principalId":"A3NL1KOZZKExample"
          },
          "arn":"arn:aws:s3:::sourcebucket"
        },
        "object":{  
          "key":"HappyFace.jpg",
          "size":1024,
          "eTag":"d41d8cd98f00b204e9800998ecf8427e",
          "versionId":"096fKKXTRTtl3on89fVO.nfljtsv6qko"
        }
      }
    }
  ]
}
```

The remainder of the session can be done via the command line:

```bash
export LAMBDA_NAME=your-lambda-function-name
export LAMBDA_ROLE=your-lambda-execution-role
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq -r ".Account")
export LAMBDA_ROLE_ARN=arn:aws:iam::$AWS_ACCOUNT_ID:role/$LAMBDA_ROLE
export LAMBDA_S3_BUCKET=your-s3-bucket
export LAMBDA_S3_ARN=arn:aws:s3:::$LAMBDA_S3_BUCKET

# package the lambda function
zip function.zip index.js

# create function
aws lambda create-function --function-name $LAMBDA_NAME \
  --zip-file fileb://function.zip \
  --handler index.handler \
  --runtime nodejs10.x \
  --role $LAMBDA_ROLE_ARN


# setup S3 notifications, first we'll allow the s3 bucket to invoke the lambda
aws lambda add-permission \
  --function-name $LAMBDA_NAME \
  --principal s3.amazonaws.com \
  --statement-id $LAMBDA_NAME$RANDOM \
  --action "lambda:InvokeFunction" \
  --source-arn $LAMBDA_S3_ARN \
  --source-account $AWS_ACCOUNT_ID

export LAMBDA_ARN=$(aws lambda get-function --function-name $LAMBDA_NAME  | jq -r .Configuration.FunctionArn)

cat << EOF > notification.json
{
    "LambdaFunctionConfigurations": [
      {
        "Id": "1234567890",
        "LambdaFunctionArn": "$LAMBDA_ARN",
        "Events": [ "s3:ObjectCreated:*" ]
      }
    ]
}
EOF

# next create the notification event in the bucket
# DANGER: this will overwrite any existing event notifications in your bucket
# DO NOT RUN THIS on a bucket that is important to you or work!
aws s3api put-bucket-notification-configuration \
  --bucket $LAMBDA_S3_BUCKET \
  --notification-configuration file://notification.json

# test the integration to see if the message formatting is correct. 
# this should look identical to the actual CloudWatch entry.
# n.b. base64 appears to use the same switch to decode for both BSD and GNU 
# variants
aws lambda invoke \
  --invocation-type RequestResponse \
  --function-name $LAMBDA_NAME \
  --log-type Tail \
  --payload file://payload-test.json outputfile.txt \
  | jq -r .LogResult | base64 --decode


# Finally let's test it properly
touch hello.txt
aws s3 cp hello.txt s3://$LAMBDA_S3_BUCKET/

# If you didn't install awslogs, you can still use AWS Console to view logs in 
# Cloud Watch.
awslogs get /aws/lambda/s3-blab --start='5 min'

# Teardown

aws lambda delete-function --function-name $LAMBDA_NAME

aws s3api put-bucket-notification-configuration \
  --bucket $LAMBDA_S3_BUCKET \
  --notification-configuration 'LambdaFunctionConfigurations=[]'

# you may wish to clear down the S3 bucket of your test files and the log group 
# that was created in CloudWatch.
```

## API and CLI features and verbs

### Features

- Alias
- Event Source Mapping
- Function

### Verbs (CRUD)

- create
- get/list
- update (function-[code/configuration])
- delete

### Outliers

- add-layer-version-permission
- add-permission
- delete-function-concurrency
- delete-layer-version
- get-account-settings
- get-function-configuration
- get-layer-version
- get-layer-version-by-arn
- get-layer-version-policy
- get-policy
- invoke
- list-layer-versions
- list-layers
- list-tags
- list-versions-by-function
- publish-layer-version
- publish-version
- put-function-concurrency
- remove-layer-version-permission
- remove-permission
- tag-resource
- untag-resource
- wait

[aws_free_tier]: https://aws.amazon.com/free/
[docs_ug]: https://docs.aws.amazon.com/lambda/latest/dg/welcome.html?sc_ichannel=ha&sc_icampaign=pa_lamdbaresourcestop&sc_icontent=devguide&sc_detail=1
[docs_ug_execution_role]: https://docs.aws.amazon.com/lambda/latest/dg/lambda-intro-execution-role.html
[docs_faq]: https://aws.amazon.com/lambda/faqs/
[docs_api]: https://docs.aws.amazon.com/lambda/latest/dg/API_Reference.html
[docs_cli]: https://docs.aws.amazon.com/cli/latest/reference/lambda/index.html
[link_devops_loves_aws_lambda]: https://epsagon.com/blog/why-devops-engineers-love-aws-lambda/
[link_jq]: https://stedolan.github.io/jq/
[link_awslogs]: https://github.com/jorgebastida/awslogs
[link_sunil_dalal]: https://www.polyglotdeveloper.com/lambda/2017-07-05-Using-Lambda-as-S3-events-processor/

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro/)
  - [CloudFormation](/2019/aws-devops-pro-certification-cloudformation)
  - [Elastic Beanstalk](/2019/aws-devops-pro-certification-elastic-beanstalk/)
  - OpsWorks
  - AWS Lambda
  - [AWS ECS](/2019/aws-devops-pro-certification-ecs/)
  - [AWS Config](/2019/aws-devops-pro-certification-config-managed-services/)
  - [AWS Managed Services](/2019/aws-devops-pro-certification-config-managed-services/)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
