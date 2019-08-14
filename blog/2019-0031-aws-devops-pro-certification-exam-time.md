---
permalink: "/2019/aws-devops-pro-certification-exam-time"
title: "AWS DevOps Pro Certification Blog Post Series: Exam Time!"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-07-09 13:37:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier][aws_free_tier]. You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try to refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## Exam Time!

At the end of June, I sat the AWS DevOps Profession exam and sadly readers I did not pass. I hadn't really expected to pass the first time, but I scored 69% (you need to score 75% to pass)!

After completing the exam you're given an immediate PASS or FAIL result. A few days later you get the actual score and areas that need improving.

### Domains where I have demonstrated adequate knowledge

- Configuration management and Infrastructure as Code
- Monitoring and logging
- Policies and Standards Automation

### Domains where I need to brush up on

- SDLC automation
- Incident and Events response
- High Availability, Fault tolerance and Disaster recovery


## Things I wish I knew beforehand

The main and most obvious thing I should've done was to focus my knowledge around best practices to build infrastructures and utilising AWS services.

Most of the questions were of a similar format to the [sample exam][aws_sample_exam] and mock exam. They wanted you to pick the best answer to meet the requirements of a customer. 

There were so many services that I hadn't had hands-on experience, which meant I spent a lot of time just trying to gain a basic understanding of what each service did and their use cases. Turns out I needed to a deeper understanding of the domains I scored poorly against.

I think the only domain I was surprised at scoring poorly against was SDLC automation, as I do a lot of CI/CD on a daily basis, although this tends to be around non-AWS services: Circle CI, Travis CI and Azure DevOps.

So, how can you find out what the best practices are? There are probably two key documents:

- The AWS [whitepapers][devopswp], which often contain solutions that combine various AWS products and services
- The service's user or developer guide

My study before retaking exam will focus on this. I only spent the week before the exam skimming through the whitepapers, but this time I plan to make a lot more notes and try to memorise diagrams of solutions provided.

## Tips for sitting the exam

### Check your gear

The exam centres will require you to place all your belongings in a locker.

Some centres will allow you to bring cups of water to the exam, take two cups if you can carry them. 

You'll also be given paper and pen, or something similar to make notes. Check the pen works before you start the exam!

Empty your bladder before you sit the exam, some places require you get the attention of the invigilator which can cost you precious minutes of your exam time.

### Timekeeping

Start getting used to scanning questions in 2-minute intervals. This is the max you should spend on reading and answering a question.

In a perfect scenario where you could answer each question fully and not skip any, it would be easy to know the next 2-minute interval. In reality, you will probably skip or answer a question in less than 2 minutes, so whilst this might be obvious to most, I used the following to keep myself on track: as I started the next question I made a note of the current time on the exam countdown timer and worked out how long I had to answer the question, so if timer was at 1 hour and 7 minutes, I would need to answer the question on or before 1 hour and 5 minutes.

### Skip and don't dither

Unless you're feeling particularly confident about your capabilities, you'll probably be in a blind panic (like I was). Give yourself up to 30 seconds (better if you can do it in less) to scan the question, if you don't even know where to begin then skip it. That time is better spent on questions where you have a vague notion of what the answer is.

Skipping questions is okay and you will find there's still time to revisit these questions once you've gone through all the questions.

Don't panic if you find you're skipping lots of questions either, it's probably your nerves.

## Alternative study aids

Whilst studying for this exam, I've used the following to help absorb the study material:

- My AWS DevOps Pro [Tinycards][tinycards] deck is a flashcard app by Duolingo. It's a bit rough and ready, but it's helped me retain some of the facts and figures that pop up.
- I've also been listening to [Last week in AWS][last_week_in_aws] which is a podcast by Corey Quinn that covers the ever-changing AWS landscape.

## Until next time

I will, of course, let you know when I sit and pass the next exam (see what I did there). I'm aiming for mid-July so expect to hear from me soon!

<!-- links -->

[aws_free_tier]: https://aws.amazon.com/free/
[aws_sample_exam]: https://d1.awsstatic.com/training-and-certification/docs-devops-pro/AWS%20Certified%20DevOps%20Engineer%20-%20Professional_Sample%20Questions.pdf
[devopswp]: https://aws.amazon.com/whitepapers/
[tinycards]: https://tiny.cards/decks/MYHnT1YG/aws-devops-pro-2019
[last_week_in_aws]: https://www.lastweekinaws.com/

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
