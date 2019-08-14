---
permalink: "/2019/aws-devops-pro-certification-ecs"
title: "AWS DevOps Pro Certification Blog Post Series: AWS ECS"
categories:
  - "aws,study,certification,ecs"
layout: post.liquid
published_date: "2019-06-04 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification,ecs"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier][aws_free_tier]. You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try to refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

AWS ECS ...

- is Amazon's Docker managed service. Naturally, you also get a container registry service in the form of [Elastic Container Registry][aws_ecr] (ECR).
- comes in two varieties (launch types): EC2 or Fargate.
  - EC2 based clusters as the name implies uses EC2 instances as Docker hosts for containers.
    - You pay for the resources spun up i.e. EC2 instances and/or EBS volumes.
    - You're also responsible for the upkeep of the EC2 instances (patching, monitoring and making secure).
  - Fargate abstracts away EC2 instances (much like serverless functions).
    - You pay for the vCPU (virtual CPU) and memory resources the container uses. This is charged at per second rate (with a minimum charge of a minute).
    - Fargate is only available to few [regions][docs_ug_fargate] (13 at the time of writing this)
    - There's no EC2 instances to maintain, just your tasks.
- is not a Kubernetes managed services, this is a separate offering with the catchy name of [Elastic Container Service for Kubernetes Service][aws_eks] (EKS)

Additional resources:

- [AWS ECS User Guide][docs_ug]
- [AWS ECS FAQ][docs_faq]
- [AWS ECS API][docs_api]
- [AWS ECS CLI][docs_cli]

## Why?

- As with all managed services, you want to focus on the functionality rather than the upkeep of a service.
- With Docker becoming the lingua franca of the Cloud you can utilise 3rd party images and build solutions in a build block manner. Granted, Amazon has been using this modularized concept for many years (OpsWorks and Elastic Beanstalk) before Docker became mainstream.

## When?

- Microservices and batch jobs are good workloads for a cluster.
- You want to migrate away from Docker managed through on-premises infrastructure or EC2 instances that are not ECS managed.

## How?

For this section, we're going to use Fargate rather than an EC2 based ECS cluster. 

This is mostly to reduce the additional complexity of provisioning the EC2 instances that will join the ECS cluster. This guide is loosely based around the [Fargte][docs_ug_fargate_tutorial] tutorial in the Developer Guide. I've just removed the part about setting up a service and ran a task with public IP we could visit to test.

That said, for day to day work you may find yourself still using EC2 based cluster until Fargate is available across all regions. You may also still find yourself using EC2 based clusters from a cost-saving perspective. If anyone has a calculator they've created when it makes more sense to go with the Fargate launch-type over EC2, please share in the comments or @ me on Twitter!

### Pre-requisites

- A VPC with at least one subnet that has inbound and outbound access to the internet.
- A suitable security group as per the previous point

```bash
export ECS_CLUSTER_NAME=your-cluster-name
export ECS_SECURITY_GROUP=your-security-group
export ECS_SUBNETS=yoursubnet

# create a cluster
aws ecs create-cluster --cluster-name $ECS_CLUSTER_NAME

# register a task

cat <<EOF > fargate-task.json
{
  "family": "sample-fargate",
  "networkMode": "awsvpc",
  "containerDefinitions": [
    {
      "name": "fargate-app",
      "image": "httpd:2.4",
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80,
          "protocol": "tcp"
        }
      ],
      "essential": true,
      "entryPoint": ["sh", "-c"],
      "command": [
        "/bin/sh -c \"echo '<html> <head> <title>Hello dev.to-ers</title> <style>body {margin-top: 40px; background-color: #333;} </style> </head><body> <div style=color:white;text-align:center> <h1>Hello, world!</h1> </div></body></html>' >  /usr/local/apache2/htdocs/index.html && httpd-foreground\""
      ]
    }
  ],
  "requiresCompatibilities": ["FARGATE"],
  "cpu": "256",
  "memory": "512"
}
EOF

aws ecs register-task-definition \
  --cli-input-json file://fargate-task.json

# create a task, assign it to our network and enable the public IP

aws ecs run-task \
  --cluster $ECS_CLUSTER_NAME \
  --task-definition sample-fargate:2 \
  --count 1 \
  --launch-type "FARGATE" \
  --network-configuration "awsvpcConfiguration={subnets=[$ECS_SUBNETS],securityGroups=[$ECS_SECURITY_GROUP],assignPublicIp="ENABLED"}"


# list tasks

aws ecs list-tasks --cluster $ECS_CLUSTER_NAME

# describe the task

export ECS_TASK_ID=$(aws ecs list-tasks --cluster $ECS_CLUSTER_NAME --query "taskArns" --output text)
aws ecs describe-tasks --cluster $ECS_CLUSTER_NAME --tasks $ECS_TASK_ID

# get the public IP of the task (well, the one bound to the ENI)

export ECS_TASK_NETWORK_ID=$(aws ecs describe-tasks --cluster $ECS_CLUSTER_NAME --tasks $ECS_TASK_ID --query 'tasks[*].attachments[*].details[?name==`networkInterfaceId`].value' --output text)

export ECS_TASK_PUBLIC_IP=$(aws ec2 describe-network-interfaces --network-interface-ids $ECS_TASK_NETWORK_ID --query "NetworkInterfaces[*].PrivateIpAddresses[*].Association.PublicIp" --output text)

# test

curl $ECS_TASK_PUBLIC_IP

# tear down

aws ecs stop-task --task $ECS_TASK_ID --cluster $ECS_CLUSTER_NAME
aws ecs delete-cluster --cluster $ECS_CLUSTER_NAME
```

## API and CLI features and verbs

### Features

- Clusters
- Services
- Task Sets

### Verbs (CRUD)

- create
- describe/list (cluster/services)
- update (service/task-set)
- delete

### Outliers

- delete-account-setting
- delete-attributes
- deploy
- deregister-container-instance
- deregister-task-definition
- describe-container-instances
- describe-task-definition
- describe-tasks
- discover-poll-endpoint
- list-account-settings
- list-attributes
- list-container-instances
- list-tags-for-resource
- list-task-definition-families
- list-task-definitions
- list-tasks
- put-account-setting
- put-account-setting-default
- put-attributes
- register-container-instance
- register-task-definition
- run-task
- start-task
- stop-task
- submit-container-state-change
- submit-task-state-change
- tag-resource
- untag-resource
- update-container-agent
- update-container-instances-state
- update-service-primary-task-set
- wait

[aws_free_tier]: https://aws.amazon.com/free/
[aws_ecr]: https://aws.amazon.com/ecr/
[aws_eks]: https://aws.amazon.com/eks/
[docs_ug]: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html
[docs_ug_fargate]: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html
[docs_ug_ecs_cli]: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_CLI.html
[docs_ug_fargate_tutorial]: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_AWSCLI_Fargate.html
[docs_faq]: https://aws.amazon.com/ecs/faqs/
[docs_api]: https://docs.aws.amazon.com/AmazonECS/latest/APIReference/Welcome.html
[docs_cli]: https://docs.aws.amazon.com/cli/latest/reference/ecs/index.html

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro)
  - [CloudFormation](/2019/aws-devops-pro-certification-cloudformation)
  - [Elastic Beanstalk](/2019/aws-devops-pro-certification-elastic-beanstalk/)
  - [OpsWorks](/2019/aws-devops-pro-certification-opsworks)
  - [AWS Lambda](/2019/aws-devops-pro-certification-lambda/)
  - AWS ECS
  - [AWS Config](/2019/aws-devops-pro-certification-config-managed-services/)
  - [AWS Managed Services](/2019/aws-devops-pro-certification-config-managed-services/)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
