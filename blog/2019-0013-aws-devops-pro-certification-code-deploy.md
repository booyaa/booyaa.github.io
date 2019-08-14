---
permalink: "/2019/aws-devops-pro-certification-code-deploy"
title: "AWS DevOps Pro Certification Blog Post Series: Code Deploy"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-03-29 13:37:00 +0000"
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

The format of the blog posts is liable to change as I try refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

Code Build is a managed deployment service.

## Why?

Deployment services are often part of the build farm so would also contribute to infrastructure expenditure.

## When?

```
SDLC automation
~~~~~~~~~~~~~~~~

CodeCommit -> CodeBuild -> [CodeDeploy] -> ???
```

## How?

This is based around the [tutorial](https://docs.aws.amazon.com/codedeploy/latest/userguide/tutorials-auto-scaling-group.html) for deploying to an EC2 Auto Scaling Group. The key difference is that I've condensed it to only include instructions for using on Linux/MacOS based machine using the Amazon v2 AMI.

### Creating the CodeDeploy service role and EC2 IAM Instance Profile

This is part of the [Getting Started](https://docs.aws.amazon.com/codedeploy/latest/userguide/getting-started-codedeploy.html) guide. 

N.B. We've opted to use the managed policy for deploying to EC2/On-Premises compute platform.

Copy the JSON object below and paste into a new file called `CodeDeployDemo-Trust.json`

```json
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "",
          "Effect": "Allow",
          "Principal": {
              "Service": [
                  "codedeploy.amazonaws.com"
              ]
          },
          "Action": "sts:AssumeRole"
      }
  ]
}

aws iam create-role \
  --role-name CodeDeployServiceRole \
  --assume-role-policy-document file://CodeDeployDemo-Trust.json

aws iam attach-role-policy \
  --role-name CodeDeployServiceRole \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole
```


Copy the JSON object below and paste into a file called `CodeDeployDemo-EC2-Trust.json`

```json
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "",
          "Effect": "Allow",
          "Principal": {
              "Service": "ec2.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
      }
  ]
}
```

Copy the JSON object below and paste into a file called `CodeDeployDemo-EC2-Permissions.json`

```json
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Action": [
              "s3:Get*",
              "s3:List*"
          ],
          "Effect": "Allow",
          "Resource": "*"
      }
  ]
}
```

```bash
aws iam create-role \
  --role-name CodeDeployDemo-EC2-Instance-Profile \
  --assume-role-policy-document file://CodeDeployDemo-EC2-Trust.json

aws iam put-role-policy \
  --role-name CodeDeployDemo-EC2-Instance-Profile 
  --policy-name CodeDeployDemo-EC2-Permissions 
  --policy-document file://CodeDeployDemo-EC2-Permissions.json

aws iam create-instance-profile \
  --instance-profile-name CodeDeployDemo-EC2-Instance-Profile

aws iam add-role-to-instance-profile \
  --instance-profile-name CodeDeployDemo-EC2-Instance-Profile \
  --role-name CodeDeployDemo-EC2-Instance-Profile
```

### Create the autoscaling group (ASG)

Copy the script below and paste into a new file called `instance-setup.sh`. This will install the CodeDeploy agent will work deploy the application to the instances associated by the Deployment Group (via the ASG).

```bash
#!/bin/bash
yum -y update
yum install -y ruby
cd /home/ec2-user
curl -O https://aws-codedeploy-????.s3.amazonaws.com/latest/install
chmod +x ./install
./install auto
```

Edit `????` to reflect your region i.e. if your region is Paris then the value would be `eu-west-3`.

Environment variables we want to define are:

- AMI_ID = The Amazon v2 AMI for your region
- KEY_NAME = Your Key Pair for the region
- AZ = The available zone(s) for our region

Here are a few aws cli commands to help you get the right values for your own environment.

```bash
# Find the Amazon v2 AMI for your region
aws ec2 describe-images --owners amazon \
  --filters \
    'Name=name,Values=amzn2-ami-hvm-2.0.????????-x86_64-gp2' \
    'Name=state,Values=available' \
  --output json | \
jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId')


# List key pairs in your region
aws ec2 describe-key-pairs | jq -r '.KeyPairs[].KeyName | sort_by(.CreationDate)'

# List availability zones for your region
aws ec2 describe-availability-zones
```

Create the launch configuration:

```bash
AMI_ID=__FILL_ME_IN__
KEY_NAME=__FILE_ME_IN__
aws autoscaling create-launch-configuration \
  --launch-configuration-name CodeDeployDemo-AS-Configuration \
  --image-id $AMI_ID \
  --key-name $KEY_NAME \
  --iam-instance-profile CodeDeployDemo-EC2-Instance-Profile \
  --instance-type t2.micro \
  --user-data file://instance-setup.sh
```

Create the autoscaling group:

```bash
set AZ eu-west-3a
aws autoscaling create-auto-scaling-group \
  --auto-scaling-group-name CodeDeployDemo-AS-Group \
  --launch-configuration-name CodeDeployDemo-AS-Configuration \
  --min-size 1 \
  --max-size 1 \
  --desired-capacity 1 \
  --availability-zones $AZ
```

Run the following command to check on the state of your ASG. Proceed to the next step when the status is "Healthy Inservice":

```bash
aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names CodeDeployDemo-AS-Group \
  --query "AutoScalingGroups[0].Instances[*].[HealthStatus, LifecycleState]" \
  --output text
```

## Deploy the Application to the ASG

Environment variables we want to define are:

- SERVICE_ROLE_ARN = The Service Role we created at the beginning of the lab
- REGION = Our region

```bash
SERVICE_ROLE_ARN=$(aws iam get-role --role-name CodeDeployServiceRole --query "Role.Arn" --output text)
REGION eu-west-3
BUCKET_NAME aws-codedeploy-$REGION

aws deploy create-application --application-name SimpleDemoApp

aws deploy create-deployment-group \
  --application-name SimpleDemoApp \
  --auto-scaling-groups CodeDeployDemo-AS-Group \
  --deployment-group-name SimpleDemoDG \
  --deployment-config-name CodeDeployDefault.OneAtATime \
  --service-role-arn $SERVICE_ROLE_ARN

DEPLOYMENT_ID=$(aws deploy create-deployment \
  --application-name SimpleDemoApp \
  --deployment-config-name CodeDeployDefault.OneAtATime \
  --deployment-group-name SimpleDemoDG \
  --s3-location bucket=$BUCKET_NAME,bundleType=zip,key=samples/latest/SampleApp_Linux.zip | jq -r .deploymentId)
```

### AppSpec file

Let's download a copy of the sample application and examine the contents:

```bash
 curl -LO https://s3.$REGION.amazonaws.com/$BUCKET_NAME/samples/latest/SampleApp_Linux.zip
 unzip SampleApp_Linux.zip
 tree # to see the structure of the app
 cat appspec.yml
```

The contents of the archive is:

- the web page we'll be deploying via CodeDeploy
- scripts to install/stop/start the web server
- [AppSpec](https://docs.aws.amazon.com/codedeploy/latest/userguide/reference-appspec-file.html) file which is what the CodeDeploy agent will use to deploy the webpage to each instance in the deployment group.

Let's return back to our deployment.

Keep checking on the deployment until the following command outputs "Succeeded".

```bash
aws deploy get-deployment --deployment-id $DEPLOYMENT_ID \
  --query "deploymentInfo.status" \
  --output text
```

Tip: If you get an access denied error at the Download stage, the EC2 IAM Instance Profile maybe configured incorrectly or the policy to allow access to S3 wasn't attached.

Let's verify that our deployment worked, by getting the public address of our instance.

```bash
INSTANCE_ID=$(aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names CodeDeployDemo-AS-Group \
  --query "AutoScalingGroups[0].Instances[*].InstanceId" --output text)

curl $(aws ec2 describe-instances \
  --instance-id $INSTANCE_ID \
  --query "Reservations[0].Instances[0].PublicDnsName" \
  --output text)
```

### Increase the number of instances in the ASG

We'll increase the instance count by ASG to bring it to a total of 2.

```bash
aws autoscaling update-auto-scaling-group \
  --auto-scaling-group-name CodeDeployDemo-AS-Group \
  --min-size 2 \
  --max-size 2 \
  --desired-capacity 2
```

Keep checking on the instances in the ASG, only proceed to the next step when they are both "Healthy InService".

```bash
aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names CodeDeployDemo-AS-Group \
  --query "AutoScalingGroups[0].Instances[*].[HealthStatus, LifecycleState]" \
  --output text
```

Now check the status of the deployment, it should be "Succeeded".

```bash
DEPLOYMENT_ID=$(aws deploy list-deployments \
  --application-name SimpleDemoApp \
  --deployment-group-name SimpleDemoDG \
  --query "deployments" | jq -r 'last(.[])')

aws deploy get-deployment \
  --deployment-id $DEPLOYMENT_ID \
  --query "deploymentInfo.[status, creator]" \
  --output text  
```

Next, let's curl all the instances to verify we've got a working site.

```bash
INSTANCE_IDS=$(aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names CodeDeployDemo-AS-Group \
  --query "AutoScalingGroups[0].Instances[*].InstanceId" \
  --output text)

  --instance-ids $INSTANCE_IDS \
  --query "Reservations[0].Instances[0].PublicDnsName" \
  --output text

aws ec2 describe-instances \
  --instance-ids $INSTANCE_IDS \
  --query "Reservations[*].Instances[*].PublicDnsName" \
  | jq -r .[][] | xargs curl {}
```

## Clean up

```bash
aws autoscaling delete-auto-scaling-group \
  --auto-scaling-group-name CodeDeployDemo-AS-Group \
  --force-delete

aws autoscaling delete-auto-scaling-group \
  --auto-scaling-group-name CodeDeployDemo-AS-Group \
  --force-delete

aws deploy delete-application \
  --application-name SimpleDemoApp
```

## API and CLI features and verbs

### Features

- Deployments
  - Deployment groups
  - Application revisions
- Applications
- Deployment configurations
- On-premise instances

### Verbs (CRUD)

- create
- batch-get/get/list/describe
- update/put
- delete

### Outliers

- register-on-premises-instance
- batch-get-on-premises-instances
- add-tags-to-on-premises-instances
- remove-tags-from-on-premises-instances
- deregister-on-premises-instance
- continue-deployment
- stop-deployment
- delete-git-hub-account-token
- deregister
- install
- push
- register
- register-application-revision
- put-lifecycle-event-hook-execution-status

**AWS DevOps Pro Certification Blog Post Series**

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
  - [Code Commit](/2019/aws-devops-pro-certification-code-commit/)
  - [Code Build](/2019/aws-devops-pro-certification-code-build/)
  - Code Deploy
  - [Code Pipeline](/2019/aws-devops-pro-certification-code-pipeline)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
