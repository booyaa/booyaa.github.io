---
permalink: "/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover"
title: "AWS DevOps Pro Certification Blog Post Series: High Availability, Fault Tolerance and Disaster Recovery"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-06-08 10:32:02 +0000"
is_draft: false
data:
  tags: "aws,study,certification"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## What does the exam guide say?

To pass this domain, you'll need to know the following:

- Determine appropriate use of multi-AZ versus multi-region architectures
- Determine how to implement high availability, scalability, and fault tolerance
- Determine the right services based on business needs (e.g., RTO/RPO, cost)
- Determine how to design and automate disaster recovery strategies
- Evaluate a deployment for points of failure

This domain is **16%** of the overall mark for the exam.

## What whitepapers are relevant?

According to the [AWS Whitepapers](https://aws.amazon.com/whitepapers) page we should look at the following documents:

- [Backup and Recovery Approaches Using AWS (June 2016)][wp_backup_and_recovery]
- [Building Fault-Tolerant Applications on AWS (October 2011)][wp_build_ft_apps_on_aws]

## What services and products covered in this domain?

- [AWS Single Sign-On][sso_page] is Amazon's managed SSO service allow your users to sign in to AWS and other connected services using your existing Microsoft Active Directory (AD).
- [Amazon CloudFront][cloudfront_page] is a managed Content Delivery Network (CDN) service.
- Autoscaling resources - Amazon has two offerings [Amazon Autoscaling][autoscaling_page] and [Amazon EC2 Auto Scaling][asg_page]
- [Amzon Route 53][route53_page] is a managed Domain Name Service (DNS).
- Databases
  - [Amazon RDS][rds_page] is a managed relational database service with a large choice of engines: Amazon Aurora, PostgreSQL, MySQL, MariaDB, Oracle Database and SQL Server.
    - [Amazon Aurora][aurora_page] is part of the RDS offering but is unique in that it provides compatibility with MySQL and PostgreSQL engines whilst outperforming them considerably (5x for MySQL and 3x for PostgreSQL).
  - [Amazon DynamoDB][dynamodb_page] is a managed NoSQL (non-relational) database service that can be used for storing key-value pairs or document based records.

## What about other types of documentation?

If you have the time, by all means, read the User Guides, but they are usually a couple of hundred pages.

- [Amazon Single-Sign On][sso_guide]
- [Amazon CloudFront][cloudfront_guide]
- [Amazon Autoscaling][autoscaling_guide] and [Amazon EC2 Autoscaling][asg_guide]
- [Amazon Route53][route53_guide]
- Databases
  - [Amazon RDS][rds_guide]
    - [Amazon Aurora][aurora_guide]
  - [Amazon DynamoDB][dynamodb_guide]

Alternatively, get familiar with the services using the FAQs:

- [Amazon Single-Sign On][sso_faq]
- [Amazon CloudFront][cloudfront_faq]
- [Amazon Autoscaling][autoscaling_faq] and [Amazon EC2 Autoscaling][asg_faq]
- [Amazon Route53][route53_faq]
- Databases
  - [Amazon RDS][rds_faq]
    - [Amazon Aurora][aurora_faq]
  - [Amazon DynamoDB][dynamodb_faq]

You're all expected to know the APIs

- [Amazon CloudFront][cloudfront_api]
- [Amazon Autoscaling][autoscaling_api] and [Amazon EC2 Autoscaling][asg_api]
- [Amazon Route53][route53_api]
- Databases
  - [Amazon RDS][rds_api]
    - Amazon Aurora uses the same API as [RDS][rds_api]
  - [Amazon DynamoDB][dynamodb_api]

Before you panic, you'll start to spot a pattern with the API verbs.

And the CLI commands

- [Amazon CloudFront][cloudfront_cli]
- [Amazon Autoscaling][autoscaling_cli] and [Amazon EC2 Autoscaling][asg_cli]
- Amazon Route53 has three subcommands: [DNS and Healthchecking][route53_cli1], [Service Discovery][route53_cli2] and [Domain Registration][route53_cli3]
- Databases
  - [Amazon RDS][rds_cli]
    - Amazon Aurora uses the same CLI as [RDS][rds_cli]
  - Amazon DynamoDB has two sub commands: [dynamodb][dynamodb_cli1] and [dynamodbstreams][dynamodb_cli2]

As with the API, there are patterns to the commands.

## High Availability, Fault Tolerance and Disaster Recovery, oh my!

Let's the basics out of the way and discuss the core concepts around this domain.

I'm going to use an excellent example provided by Patrick Benson in his blog post: [The Difference Between Fault Tolerance, High Availability, & Disaster Recovery][link_pbenson]

An airplane has multiple engines and can operate with the loss of one or more engines. The design of the airplane has been made it resilient to falling out of the sky because of engine failure. This design is **fault tolerant**.

In terms of infrastructure, this is likely to be a managed service like RDS, where under the hood the database engine has multiple disks and CPUs to cope with catastrophic failure.

Whereas spare tire in car, isn't fault tolerant i.e. you have to stop change the tire, but having the spare tire in the first place makes the car still **highly available**. In terms of infrastructure is any type of technology like an autoscaling group.

It's very common for a solution to implement a system that is fault tolerant (resilience) and highly available (scalable).

Finally, ejector seats in Fighter aircraft are **disaster recovery** (DR) measure. The goal is to preserve the pilot, or in our case, the service after all other measures have failed (Fault Tolerance and HA).

Often in terms of infrastructure, this might be a standby infrastructure or database replica in a different AWS region and using Route 53 to point to the stand by infrastructure. Whilst it's still common for DR strategies to be manual, for this domain we'll be expected to provide an automated solution.

<!-- product meta links -->

[sso_page]: https://aws.amazon.com/single-sign-on/
[sso_faq]: https://aws.amazon.com/single-sign-on/faqs/
[sso_guide]: https://docs.aws.amazon.com/singlesignon/latest/userguide/what-is.html

[cloudfront_page]: https://aws.amazon.com/cloudfront/
[cloudfront_pricing]: https://aws.amazon.com/cloudfront/pricing/?nc=sn&loc=3
[cloudfront_faq]: https://aws.amazon.com/cloudfront/faqs/?nc=sn&loc=6
[cloudfront_guide]: https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/index.html
[cloudfront_cli]: https://docs.aws.amazon.com/cli/latest/reference/cloudfront/index.html
[cloudfront_api]: https://docs.aws.amazon.com/cloudfront/latest/APIReference/Welcome.html
[cloudfront_wp1]: https://d0.awsstatic.com/whitepapers/Security/Secure_content_delivery_with_CloudFront_whitepaper.pdf
[cloudfront_wp2]: https://d1.awsstatic.com/whitepapers/wordpress-best-practices-on-aws.pdf?trk=gs_card
[cloudfront_wp3]: https://d0.awsstatic.com/whitepapers/deploying-wordpress-with-aws-elastic-beanstalk.pdf
[cloudfront_usecases]: https://aws.amazon.com/cloudfront/case-studies/?nc=sn&loc=7

[autoscaling_page]: https://aws.amazon.com/autoscaling/
[autoscaling_faq]: https://aws.amazon.com/autoscaling/faqs/
[autoscaling_guide]: https://docs.aws.amazon.com/autoscaling/plans/userguide/
[autoscaling_api]: https://docs.aws.amazon.com/autoscaling/plans/APIReference/
[autoscaling_cli]: https://docs.aws.amazon.com/cli/latest/reference/autoscaling-plans/index.html
[asg_page]: https://aws.amazon.com/ec2/autoscaling/
[asg_faq]: https://aws.amazon.com/ec2/autoscaling/faqs/
[asg_guide]: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/index.html
[asg_api]: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/index.html
[asg_cli]: https://docs.aws.amazon.com/cli/latest/reference/autoscaling/index.html

[route53_page]: https://aws.amazon.com/route53/
[route53_guide]: https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/index.html
[route53_faq]: https://aws.amazon.com/route53/faqs/
[route53_api]: https://docs.aws.amazon.com/Route53/latest/APIReference/index.html
[route53_cli1]: https://docs.aws.amazon.com/cli/latest/reference/route53/index.html
[route53_cli2]: https://docs.aws.amazon.com/cli/latest/reference/servicediscovery/index.html
[route53_cli3]: https://docs.aws.amazon.com/cli/latest/reference/route53domains/index.html

[rds_page]: https://aws.amazon.com/rds/
[rds_pricing]: https://aws.amazon.com/rds/pricing/
[rds_faq]: https://aws.amazon.com/rds/faqs/
[rds_guide]: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/index.html
[rds_cli]: https://docs.aws.amazon.com/cli/latest/reference/rds/index.html
[rds_api]: https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/index.html

[aurora_page]: https://aws.amazon.com/rds/aurora/
[aurora_pricing]: https://aws.amazon.com/rds/aurora/pricing/
[aurora_faq]: https://aws.amazon.com/rds/aurora/faqs/
[aurora_guide]: https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/index.html

[dynamodb_page]: https://aws.amazon.com/dynamodb/
[dynamodb_pricing]: https://aws.amazon.com/dynamodb/pricing/
[dynamodb_faq]: https://aws.amazon.com/dynamodb/faqs/
[dynamodb_guide]: http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/
[dynamodb_cli1]: https://docs.aws.amazon.com/cli/latest/reference/dynamodb/index.html
[dynamodb_cli2]: https://docs.aws.amazon.com/cli/latest/reference/dynamodbstreams/index.html
[dynamodb_api]: http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/

<!-- white papers -->

[wp_backup_and_recovery]: https://d1.awsstatic.com/whitepapers/Storage/Backup_and_Recovery_Approaches_Using_AWS.pdf
[wp_build_ft_apps_on_aws]: https://d1.awsstatic.com/whitepapers/aws-building-fault-tolerant-applications.pdf

<!-- domain intro -->

[link_pbenson]: http://www.pbenson.net/2014/02/the-difference-between-fault-tolerance-high-availability-disaster-recovery/

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro/)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: High Availability, Fault Tolerance, and Disaster Recovery
  - [Amazon Single-Sign On](/2019/aws-devops-pro-certification-sso-cloudfront-autoscaling-route53/)
  - [Amazon CloudFront](/2019/aws-devops-pro-certification-sso-cloudfront-autoscaling-route53/)
  - [Auto Scaling](/2019/aws-devops-pro-certification-sso-cloudfront-autoscaling-route53/)
  - [Amazon Route53](/2019/aws-devops-pro-certification-sso-cloudfront-autoscaling-route53/)
  - Databases
    - Amazon RDS
    - Amazon Aurora
    - Amazon DynamoDB
