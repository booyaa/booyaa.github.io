---
permalink: "/2019/aws-devops-pro-certification-intro"
title: "AWS DevOps Pro Certification Blog Post Series"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-03-24 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification"
  route: blog
---

This is the start of a blog post series about studying for the [AWS DevOps Professional](https://aws.amazon.com/certification/certified-devops-engineer-professional/) certification.

## Background

First a bit of background about me, I'm an engineer at [Made Tech](https://www.madetech.com/) who specialises in [Site Reliability Engineering](https://landing.google.com/sre/books/). My job is to support our fellow software engineers on two of the three big cloud providers: AWS and Azure. I'm responsible for provisioning the infrastructure that the applications run on, setting up continuous delivery pipelines and application monitoring.

This year I decided I want to strengthen my capabilities with AWS and a good way to do this is to become certified as an AWS DevOps Professional.

My tried and tested method for learning stuff, is to blog about it which is why I'm creating this blog post series! Also, I'm accountable for my study by journaling the experience.

## Certification

Before we begin, let's be clear about which version of the exam we're referring to. This is the certification exam taken after February 2019.

The AWS DevOps Professional certification costs 300 USD and takes 170 minutes to complete, with a scoring system of 100-1000 points: you need 750 points to pass.

In this version of the exam, they no longer provide the number of questions, but previously it was 80 questions so this works out about 2 minutes per question.

The questions in the exam are information dense. There are two twos of question format:

- Multiple-choice - pick one as the correct answer.
- Multiple-response - two or more choice to make up the correct answer.

If you're wondering how dense, take a look at the free [sample exam questions](https://d1.awsstatic.com/training-and-certification/docs-devops-pro/AWS%20Certified%20DevOps%20Engineer%20-%20Professional_Sample%20Questions.pdf) (can't provide an example because it's copyrighted material).

Go have a look, and come back when you've done it, I'll wait.

Unless you're already a DevOps Pro or used AWS for a really long time you're probably in a state a shock.

Whilst we wait for the shock subside, let's cover the areas you'll be tested on.

## The master of your domain

There are six domains of study, this is the high-level view and we'll go into greater detail in the following posts as part of the series.

| Domain | Subject                                                   | % of exam |
| ------ | --------------------------------------------------------- | --------- |
| 1      | Software Delivery Lifecycle (SDLC) Automation             | 22        |
| 2      | Configuration Management and Infrastructure as Code       | 19        |
| 3      | Monitoring and Logging                                    | 15        |
| 4      | Policies and Standards Automation                         | 10        |
| 5      | Incident and Event Response                               | 18        |
| 6      | High Availability, Fault Tolerance, and Disaster Recovery | 16        |

## Resources

Luckily there's a variety of resources to help you study.

Your first port of call should be the [exam guide](<https://d1.awsstatic.com/training-and-certification/docs-devops-pro/AWS%20Certified%20DevOps%20Engineer%20Professional_Exam%20Guide_v1.5_FINAL%20(2).pdf>) aka the blueprint. This guide will give you a list of whitepapers to ready. A detailed breakdown of the topics you're expected to know for each domain (see the table from the previous section).

You've already seen the [sample exam questions](https://d1.awsstatic.com/training-and-certification/docs-devops-pro/AWS%20Certified%20DevOps%20Engineer%20-%20Professional_Sample%20Questions.pdf).

The [Exam Readiness Training](https://www.aws.training/training/schedule?courseId=19030?src=cert-prep) is another helpful resource with more sample questions.

## Knowing when it's time to sit the exam

I didn't feel particularly confident I would pass the exam cold i.e. no study. The exam costs 350 USD, so I wasn't eager to spend that much money (even if it is covered by my employers) to fail.

The next best thing was to try the practice the exam which costs 40 USD which has 20 questions you need to answer within an hour. The practice exam is booked through the [AWS Certification site](https://www.aws.training/certification?src=cert-prep). This is the same method for booking the actual exam, except you can take the practice exam online, whereas the actual exam requires you to visit a test centre.

I sat the practice exam and scored 40% :(

My study plan is to:

- create a series of blog posts
- do lots of actual practice using the services covered in the exam. I'll be using aws cli, Amazon AMI, MacOS, bash and jq. Reminder: some of the unix commands on MacOS are the BSD variant rather than GNU, but I'll try to limit using variant specific switch where possible.
- drill against a set of flashcards I'll be creating as part of the study plan

I'm tentatively giving myself a month to study, spending at minimum two hours a day. After which I'm going to retake the practice exam if I score at least 80% I'll consider booking the exam.

So stay tuned.

## AWS DevOps Pro Certification Blog Post Series

- Intro
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
