---
permalink: "/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover"
title: "AWS DevOps Pro Certification Blog Post Series: High Availability, Fault Tolerance and Disaster Recovery"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-06-07 13:37:02 +0000"
is_draft: true
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

According to the [AWS Whitepapers for DevOps](https://aws.amazon.com/whitepapers/#dev-ops) we should look at the following documents:

- ???

## What services and products covered in this domain?

- [AWS Single Sign-On][sso_page] is Amazon's managed SSO service allow your users to sign into AWS and other connected services using your existing Microsoft Active Directory (AD).
- [Amazon CloudFront][cloudfront_page] is a managed Content Delivery Network (CDN) service.
  - Autoscaling and Lifecycle Hooks???
- Databases
  - [Amazon RDS][rds_page] is a managed relational database service with a large choice of engines: Amazon Aurora, PostgreSQL, MySQL, MariaDB, Oracle Database and SQL Server.
    - [Amazon Aurora][aurora_page] is part of the RDS offering, but is unique in that it provides compatibility with MySQL and PostgreSQL engines whilst outperforming them considerably (5x for MySQL and 3x for PostgreSQL).
  - [Amazon DynamoDB][dynamodb_page] is a managed NoSQL (non-relational) database service that can be used for storing key-value pairs or document based records.
    - Amazon DynamoDB Keys and Streams

Source: [AWS DevOps - Monitoring and Logging page](https://aws.amazon.com/devops/#monitoring)

## What about other types of documentation?

If you have the time, by all means, read the User Guides, but they are usually a couple of hundred pages.

- Amazon Single-Sign On
- [Amazon CloudFront][cloudfront_guide]
- Databases
  - [Amazon RDS][rds_guide]
    - [Amazon Aurora][aurora_guide]
  - [Amazon DynamoDB][dynamodb_guide]

Alternatively, get familiar with the services using the FAQs:

- [Amazon Single-Sign On][sso_faq]
- [Amazon CloudFront][cloudfront_faq]
- Databases
  - [Amazon RDS][rds_faq]
    - [Amazon Aurora][aurora_faq]
  - [Amazon DynamoDB][dynamodb_faq]

You're all expected to know the APIs

- Amazon Single-Sign On
- [Amazon CloudFront][cloudfront_api]
- Databases
  - [Amazon RDS][rds_api]
    - Amazon Aurora uses the same API as [RDS][rds_api]
  - [Amazon DynamoDB][dynamodb_api]

Before you panic, you'll start to spot a pattern with the API verbs.

And the CLI commands

- [Amazon Single-Sign On][sso_cli]
- [Amazon CloudFront][cloudfront_cli]
- Databases
  - [Amazon RDS][rds_cli]
    - Amazon Aurora uses the same CLI as [RDS][rds_cli]
  - Amazon DynamoDB has two sub commands: [dynamodb][dynamodb_cli1] and [dynamodbstreams][dynamodb_cli2]

As with the API, there are patterns to the commands.

## High Availability, Fault Tolerance and Disaster Recovery, oh my!

Let's the basics out of the way and discuss the core concepts around this domain.

I'm going to use an excellent example provided by Patrick Benson in his blog post: [The Difference Between Fault Tolerance, High Availability, & Disaster Recovery][link_pbenson]

If you think of Fault Tolerant an airplane with multiple engines. Most airplanes can operating with the loss of one or more engines.

High availability would be a spare tire in car. If you get a flat, you can replace it in-situ. If anyone can think of a better analogy that involves a airplane instead, let me know!

Finally Disaster Recovery is like the ejector seat in Fighter aircraft (Jet fighter).

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

<!-- domain intro -->

[link_pbenson]: http://www.pbenson.net/2014/02/the-difference-between-fault-tolerance-high-availability-disaster-recovery/

### AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SLDC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro/)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: High Availability, Fault Tolerance, and Disaster Recovery