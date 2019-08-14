---
permalink: "/2019/aws-devops-pro-certification-code-build"
title: "AWS DevOps Pro Certification Blog Post Series: Code Build"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-03-27 13:37:00 +0000"
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

Code Build is a managed build service.

## Why?

Asides the infrastructure required to host your applications and services, build farms are the next largest expenditure. Also orchestration to provision a build farm is non-trivial. Managed build services like Travis CI, Circle CI and Appveyor have helped Open Source projects thrive and allowed maintainers to support a wide range of CPU and operating systems.

## When?

```
SDLC automation
~~~~~~~~~~~~~~~~

CodeCommit -> [CodeBuild] -> ???
```

## How?

This is loosely based around the [Getting Started]https://docs.aws.amazon.com/codebuild/latest/userguide/getting-started.html) section of the User Guide.

The main differences are that I'm going to use the CLI instead of the Web UI to aid in learning these commands too, also I'm going to use Rust to demonstrate how to distribute build artefacts.

### Create S3

We're going to use S3 to store our build artefacts, so we'll create a bucket in the same region as our CodeBuild project (`eu-west-2`). This is an important thing to note, as you can't use an S3 bucket in a different region to your CodeBuild project.

```bash
aws s3api create-bucket \
  --bucket hello-codebuild \
  --region eu-west-2 \
  --create-bucket-configuration LocationConstraint=eu-west-2
```

### Setup CodeCommit

Next let's create a new CodeCommit repository to store our code.

```bash
aws codecommit create-repository \
  --repository-name hello-codebuild
  --region eu-west-2
```

### Pull in the source code

To avoid adding more steps (which aren't relevant), I've created a simple [Rust](https://www.rust-lang.org/) app that'll we'll use for this lab.

Now we're going to do the following:

- clone the CodeCommit repo
- download our sample app
- unzip the sample app archive
- do a bit of house keep to place the sample app at the right directory level, and remove the archive
- push the code back up to the CodeCommit repo

```bash
REPO_URL=$(aws codecommit get-repository --repository-name $REPO_NAME | jq -r .repositoryMetadata.cloneUrlSsh)
git clone $REPO_URL
cd hello-codebuild
curl -sLO https://github.com/booyaa/hello-codebuild/archive/master.zip
unzip master.zip
rm -rf master.zip
mv hello-codebuild-master/* .
rm -rf hello-codebuild-master
git add -A
git commit -m 'initial commit'
git push -u origin master
```

#### Build specification

The [build specification](https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html) is similar to other configuration files used by CI services, it tells the build service how to build our code.

```yaml
version: 0.2

phases:
  install:
    commands:
      - apt-get update -y
      - apt-get install -y build-essential
      - curl https://sh.rustup.rs -sSf | sh -s -- -y
      - PATH=/root/.cargo/bin:$PATH
  build:
    commands:
      - cargo test
      - cargo build --release
artifacts:
  files:
    - ./target/release/hello-codebuild
```

The points of interest for us, are the following sections or [phases](https://docs.aws.amazon.com/codebuild/latest/userguide/view-build-details.html#view-build-details-phases):

- `install` - what commands do we need to run to install the build tools for our language. We're using `apt` because our CodeBuild project will use an Ubuntu 14.04 based server image.
- `build` - what commands are required to build the code
- `artifacts` - what do we want to upload to our S3 bucket?

### Create a service role for CodeBuild

Next we'll create a new service role (this is done for us if we create the project through UI), luckily the [User Guide](https://docs.aws.amazon.com/codebuild/latest/userguide/setting-up.html#setting-up-kms) has instructions on how to do this through the CLI.

Let's create the following files:

`create-role.json`

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

`put-role-policy.json`
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "CloudWatchLogsPolicy",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "CodeCommitPolicy",
      "Effect": "Allow",
      "Action": [
        "codecommit:GitPull"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "S3GetObjectPolicy",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "S3PutObjectPolicy",
      "Effect": "Allow",
      "Action": [
        "s3:PutObject"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
```

Let's run the following commands to create the Service Role.

```bash
aws iam create-role \
  --role-name CodeBuildServiceRole 
  --assume-role-policy-document file://create-role.json

aws iam put-role-policy --role-name CodeBuildServiceRole \
  --policy-name CodeBuildServiceRolePolicy \
  --policy-document file://put-role-policy.json
```

Once we've created this Service Role, we can reference it for all for future CodeBuild projects.

### Create the CodeBuild project

Finally we can create our CodeBuild project!

```bash
REPO_NAME=hello-codebuild
S3_BUCKET=$REPO_NAME
SERVICE_ROLE_ARN=$(aws iam get-role --role-name CodeBuildServiceRole | jq -r .Role.Arn)
REPO_URL=$(aws codecommit get-repository --repository-name $REPO_NAME | jq -r .repositoryMetadata.cloneUrlHttp)
aws codebuild create-project \
  --name $REPO_NAME \
  --source type=CODECOMMIT,location=$REPO_URL \
  --artifacts type=S3,location=$S3_BUCKET \
  --environment type=LINUX_CONTAINER,image=aws/codebuild/ubuntu-base:14.04,computeType=BUILD_GENERAL1_SMALL,imagePullCredentialsType=CODEBUILD \
  --service-role $SERVICE_ROLE_ARN
```

Key parameters/switches to point out:

- `source` 
  - We've opted for the CodeCommit `type`, but there are also options for BitBucket, CodePipeline, GitHub, S3 and finally No Source (when there's no source code). 
  - The other parameter we provided was the `location` of the Git repo URL. 
  - More details about the `sourceType` can be found in the [API](https://docs.aws.amazon.com/codebuild/latest/APIReference/API_ProjectSource.html).
- `artifacts` 
  - We've opted for the `type` S3, the only other options are CodePipeline and No artifacts. 
  - The other parameter we provided was the `location` of the S3 bucket. 
  - More details about the `artifacts` can be found in the [API](https://docs.aws.amazon.com/codebuild/latest/APIReference/API_ProjectArtifacts.html)
- `environment` 
  - The image `type` is Linux, instead of Windows. 
  - The `image` is Ubuntu 14.04 base (which looks like the only choice if you go through the UI). 
  - The `computeType` is the smallest general purpose build server
  - The `imagePullCredentialsType` is AWS CodeBuild's own credentials to pull the image, which is fine since the Container Registry we're using is the one provided by AWS for it's own images.
- `service-role` is the ARN of the IAM role that we created earlier.  

### Run build

```bash
BUILD_ID=$(aws codebuild start-build --project-name $REPO_NAME | jq -r .build.id)
```

### View build logs

```bash
aws codebuild batch-get-builds --ids $BUILD_ID
```

### Get artifact and test it

```bash
aws s3 cp s3://hello-codebuild/hello-codebuild/target/release/hello-codebuild hello-codebuild
chmod +x
docker run --rm -it -v $PWD:/root ubuntu bash -c /root/hello-codebuild
```

### Clean up

```bash
aws codebuild delete-project --name hello-codebuild
aws codecommit delete-repository --repository-name hello-codebuild
aws s3api delete-bucket --bucket hello-codebuild
```

You could remove the Service Role, but it might be handy if you plan to do some more practice sessions with this lab.

## API and CLI features and verbs

### Features

- Project(s)
- Build(s)
- Webhook
- Source Credentials

### Verbs (CRUD)

- create
- batch-get/get/list/describe
- update/put
- delete

### Outliers

- list-curated-environment-images
- import-source-credentials
- invalidate-project-cache
- stop/start build

**AWS DevOps Pro Certification Blog Post Series**

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
  - [Code Commit](/2019/aws-devops-pro-certification-code-commit/)
  - Code Build
  - [Code Deploy](/2019/aws-devops-pro-certification-code-deploy/)
  - [Code Pipeline](/2019/aws-devops-pro-certification-code-pipeline)
- Domain 2: Configuration Management and Infrastructure as Code
- Domain 3: Monitoring and Logging
- Domain 4: Policies and Standards Automation
- Domain 5: Incident and Event Response
- Domain 6: High Availability, Fault Tolerance, and Disaster Recovery
